quote:flip `time`sym`src`bid`ask`bsize`asize!"tssffff"$\:()
trade:([] time:`time$();sym:`symbol$();src:`symbol$();price:`float$();amount:`float$();side:`symbol$())
positions:flip `time`sym`src`price`amount`side`acct`id!"tssffsij"$\:()