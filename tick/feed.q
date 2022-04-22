/generate dummy trade, quote and position tables for later use. defines configuration variables and schemas and merge 3 tables in it.
h:neg hopen `::5010
srcs:`LP1`LP2`LP3`LP4`LP5
syms:`APPL`GOOG`CAT`NYSE!(100;200;250.;50.)
n:2
side:`buy`sell
m:{y+0.01*sums x?-6+til 13}
b:{x-0.01*count[x]?0 1 2 3 4 5 6}
a:{x+0.01*count[x]?0 1 2 3 4 5 6}
s:{x?50 100 200 300.}
flag:1


.z.ts:{
  mid:raze m[n;] each value syms;n1::n*count syms;k:raze (n#) each key syms;
  $[0<flag mod 10;
    h(".u.upd";`quote;(asc n1?.z.N;k;n1?srcs;b mid;a mid;s n1;s n1));
    $[0<flag mod 100;
      h(".u.upd";`trade;(asc n1?.z.N;k;n1?srcs;b mid;s n1;n1?side));
      h(".u.upd";`positions;(asc n1?.z.N;k;n1?srcs;b mid;s n1;n1?side;n1?10?100i;n1?100))]];
  flag+:1; }
\t 100


