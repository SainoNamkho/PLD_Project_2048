module test_vga(
	 clk_20M,
    VGA_HS,
    VGA_VS,
    VGA_R,
    VGA_G,
    VGA_B
    );

    input clk_20M;
    output VGA_HS, VGA_VS, VGA_R, VGA_G, VGA_B;

    reg[10:0] x_counter;
    reg[10:0] y_counter;

    reg [3:1] GRBX;

/*
    initial begin
        x_counter = 0;
        y_counter = 0;
    end
*/

// Always block to drive drawing, {front|back}-doors, and syncs.
    always @(posedge clk_20M) begin
        if(x_counter == 645)
        begin
            x_counter = 0;

            if(y_counter == 485)
                y_counter = 0;
            else
                y_counter = y_counter + 1;
        end
        else
            x_counter = x_counter + 1;
    end

    always @(x_counter or y_counter)
    begin
        if (x_counter<100)  GRBX<=3'b111;
            else if (x_counter<200)   GRBX<=3'b110;
            else if (x_counter<300)   GRBX<=3'b101;
            else if (x_counter<400)   GRBX<=3'b100;
            else if (x_counter<500)   GRBX<=3'b011;
            else if (x_counter<600)   GRBX<=3'b010;
            else if (x_counter<700)   GRBX<=3'b001;
            else  GRBX<=3'b000 ; 
        end

    assign  VGA_R=GRBX[2];
    assign  VGA_G=GRBX[3];
    assign  VGA_B=GRBX[1];

    assign VGA_HS = ((x_counter > 639) && (x_counter < 645));
    assign VGA_VS = ((y_counter > 479) && (y_counter < 485));

endmodule