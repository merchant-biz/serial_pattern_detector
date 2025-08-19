////////////////////////////////////////////////////////////////////////////////
// Synchronous N-bit Serial Pattern Detector
//
// @version 0.1.0
//
// @author Jordan Downie <jpjdownie.biz@gmail.com>
// @section LICENSE
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER ``AS IS'' AND ANY EXPRESS
// OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
// OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
// NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENT IAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
// THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
////////////////////////////////////////////////////////////////////////////////
module serial_pattern_detector #(
    parameter N=4, parameter [N-1:0] PATTERN = 4'b1101
    )(
        input wire clk, 
		input wire rst, 
		input wire din, 
	    output wire detect
    );

reg [N-1:0] s_reg = {N{1'b0}};

always @ (posedge clk)
begin
    if (rst)
        s_reg <= 0;
    else
        s_reg <= {s_reg[N-2:0], din};
end

assign detect = (s_reg == PATTERN) ? 1'b1 : 1'b0;

endmodule
