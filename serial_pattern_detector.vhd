--------------------------------------------------------------------------------
-- Synchronous N-bit Serial Pattern Detector
--
-- @version 0.1.0
--
-- @author Jordan Downie <jpjdownie.biz@gmail.com>
-- @section LICENSE
-- 
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER ``AS IS'' AND ANY EXPRESS
-- OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
-- OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
-- NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
-- DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
-- (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
-- LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
-- ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-- (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
-- THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity serial_pattern_detector is
  generic (
    N       : integer := 4;
    PATTERN : std_logic_vector(N-1 downto 0) := "1101"
  );
  port (
    clk    : in  std_logic;
    rst    : in  std_logic;
    din    : in  std_logic;
    detect : out std_logic
  );
end serial_pattern_detector;

architecture rtl of serial_pattern_detector is
  signal s_reg : std_logic_vector(N-1 downto 0) := (others => '0');
begin

  process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        s_reg <= (others => '0');
      else
        s_reg <= s_reg(N-2 downto 0) & din;
      end if;
    end if;
  end process;

  detect <= '1' when s_reg = PATTERN else '0';

end architecture;