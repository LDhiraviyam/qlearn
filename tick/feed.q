/generate dummy trade, quote and position tables for later use. defines configuration variables and schemas
h:neg hopen `::5010 /connect to tickerplant
getsyms:{[syms] $[syms~`;exec distinct sym from quote;(),syms]}
getlps:{[lps] $[lps~`;exec distinct src from quote;(),lps]}
srcs:`LP1`LP2`LP3`LP4`LP5                             / liquidity providers
syms:`APPL`GOOG`CAT`NYSE!(100;200;250.;50.)         / and symbols to choose from
acctid:10?100i                                      / create 10 random acccount ids between 1 and 100
n:1000                                              / set table size 

trade:flip `time`sym`src`price`amount`side!"tssffs"$\:() / creating table schemas
quote:flip `time`sym`src`bid`ask`bsize`asize!"tssffff"$\:()
positions:flip `time`sym`src`price`amount`side`acct`id!"tssffsij"$\:()

init1:{[n;x;y;z] / create quote table. creates 1000 random times between 00:00:00.000 - > 23:59:59.999, in ascending order
 tms:asc n?23:59:59.999;
 mds:y[z]+0.01*sums n?{[x] asc neg[x],x}1 2 3 4 5 6; / creates bids and asks by partially using 'random' prices created above.
 bids:mds+ 0.01*n? neg {[x] asc x}0 1 2 3 4 5 6;
 asks:mds+ 0.01*n? {[x] asc x}0 1 2 3 4 5 6;
 h(".u.upd";`quote;`quote insert flip `time`sym`src`bid`ask`asize`bsize!(tms;z;n? x;bids;asks;n? 50 100 200.;n?50 100 300 200.)); / mass insert
 h(".u.upd";`trade;`trade insert select time,sym,src,price:?[side=`buy;bid;ask],amount:?[side=`buy;bsize; asize],side
  from update side:count[i]?`buy`sell from (`int$n%10)?quote); / create trade and customer positions tables
 h(".u.upd";`positions;`positions insert update id:i from update acct:count[i]?acctid from (`int$n%10)?trade);
 `time xasc' `quote`trade`positions;
 }

init:{[] init1[n;srcs;syms;] each key syms;}
init[]

