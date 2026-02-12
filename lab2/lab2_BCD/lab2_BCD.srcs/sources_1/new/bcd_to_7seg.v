module bcd_to_7seg(
    input [3:0] switch,   // switch[3] is A, ..., switch[0] is D
    output [6:0] seg,     // seg[0] is a, ..., seg[6] is g
    output [3:0] an       // Anodes
    );

    // not inputs
    wire An, Bn, Cn, Dn;
    not (An, switch[3]); // switch[3] = A
    not (Bn, switch[2]); // switch[2] = B
    not (Cn, switch[1]); // switch[1] = C
    not (Dn, switch[0]); // switch[0] = D

    // turn on only the one digit
    assign an = 4'b1101; 

    // seg a
    wire a1, a2, a3, a4;
    and (a1, switch[3], switch[2]);          // AB
    and (a2, switch[3], switch[1]);          // AC
    and (a3, An, Bn, Cn, switch[0]);         // A'B'C'D
    and (a4, switch[2], Cn, Dn);             // BC'D'
    or  (seg[0], a1, a2, a3, a4);

    // seg b
    wire b1, b2, b3, b4;
    and (b1, switch[3], switch[2]);          // AB
    and (b2, switch[3], switch[1]);          // AC
    and (b3, switch[2], Cn, switch[0]);      // BC'D
    and (b4, switch[2], switch[1], Dn);      // BCD'
    or  (seg[1], b1, b2, b3, b4);

    // seg c
    wire c1, c2, c3;
    and (c1, switch[3], switch[2]);          // AB
    and (c2, switch[3], switch[1]);          // AC
    and (c3, Bn, switch[1], Dn);             // B'CD'
    or  (seg[2], c1, c2, c3);

    // seg d
    wire d1, d2, d3, d4, d5;
    and (d1, switch[3], switch[2]);          // AB
    and (d2, switch[3], switch[1]);          // AC
    and (d3, switch[2], Cn, Dn);             // BC'D'
    and (d4, switch[2], switch[1], switch[0]); // BCD
    and (d5, An, Bn, Cn, switch[0]);         // A'B'C'D
    or  (seg[3], d1, d2, d3, d4, d5);

    // seg e
    wire e1, e2;
    and (e1, switch[3], switch[1]);          // AC
    and (e2, switch[2], Cn);                 // BC'
    or  (seg[4], switch[0], e1, e2);         // D + AC + BC'

    // seg d
    wire f1, f2, f3, f4;
    and (f1, switch[3], switch[2]);          // AB
    and (f2, Bn, switch[1]);                 // B'C
    and (f3, switch[1], switch[0]);          // CD
    and (f4, An, Bn, switch[0]);             // A'B'D
    or  (seg[5], f1, f2, f3, f4);

    // seg g
    wire g1, g2, g3, g4;
    and (g1, switch[3], switch[2]);          // AB
    and (g2, switch[3], switch[1]);          // AC
    and (g3, An, Bn, Cn);                    // A'B'C'
    and (g4, switch[2], switch[1], switch[0]); // BCD
    or  (seg[6], g1, g2, g3, g4);

endmodule