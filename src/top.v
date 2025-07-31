module top(CLK, rst);
    input wire CLK, rst;

    wire        PCSrc;
    wire        ResultSrc;
    wire        MemWrite;
    wire [ 2:0] ALUControl;
    wire        ALUSrc;
    wire [ 1:0] ImmSrc;
    wire        RegWrite;

    wire [31:0] Instr;
    wire [31:0] PC;
    wire [31:0] PCNext;
    wire [31:0] PCPlus4;
    wire [31:0] PCTarget;

    wire [31:0] ImmExt;
    wire [31:0] WriteData;
    wire [31:0] SrcA;
    wire [31:0] SrcB;
    wire        Zero;
    wire [31:0] ALUResult;
    wire [31:0] ReadData;
    wire [31:0] Result;

    localparam  DATA_WIDTH = 32;
    localparam  ADDR_WIDTH = 5;
    localparam  REG_COUNT  = 32;

    mux m1(
        .in0(PCPlus4),
        .in1(PCTarget),
        .sel(PCSrc),
        .d(PCNext)
    );

    register#(
        .N(DATA_WIDTH)
    ) reg1(
        .CLK(CLK),
        .rst(rst),
        .d(PCNext),
        .q(PC)
    );

    adder soma_plus4(
        .a_in(PC),
        .b_in(32'd4),
        .car_in(1'b0),
        .result(PCPlus4)
    );

    instructionMemory instMem(
        .A(PC),
        .RD(Instr)
    );

    register_file#(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .REG_COUNT(REG_COUNT)
    ) regFile(
        .CLK(CLK),
        .WE3(RegWrite),
        .WD3(Result),
        .A1(Instr[19:15]),
        .A2(Instr[24:20]),
        .A3(Instr[11:7]),
        .RD1(SrcA),
        .RD2(WriteData)
    );

    extend ext(
        .in(Instr[31:7]),
        .ImmSrc(ImmSrc),
        .out(ImmExt)
    );

    mux m2(
        .in0(WriteData),
        .in1(ImmExt),
        .sel(ALUSrc),
        .d(SrcB)
    );

    alu alu(
        .SrcA(SrcA),
        .SrcB(SrcB),
        .ALUControl(ALUControl),
        .Zero(Zero),
        .ALUResult(ALUResult)
    );

    adder soma_target(
        .a_in(PC),
        .b_in(ImmExt),
        .car_in(1'b0),
        .result(PCTarget)
    );

    data_memory dataMem(
        .CLK(CLK),
        .WE(MemWrite),
        .A(ALUResult),
        .WD(WriteData),
        .RD(ReadData)
    );

    mux m3(
        .in0(ALUResult),
        .in1(ReadData),
        .sel(ResultSrc),
        .d(Result)
    );

    control contr(
        .PCSrc(PCSrc),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUControl(ALUControl),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite),
        .op(Instr[6:0]),
        .funct3(Instr[14:12]),
        .funct7(Instr[30]),
        .Zero(Zero)
    );

endmodule
