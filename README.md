# RGB_MOOD_LAMP

rgb lampa preblikávajúca medzi RGB farbami a ich odtienami s možnosťou zmeny rýchlosti a intenzity jasu RGB led diódy pomocou tlačidiel dosky NEXYS A7-50T

Aktivita:
2. týždeň: <br>
Samuel - brght_speed.vhdl,brght_speed_tb.vhdl, vypis do gitu 
<br>
Jakub - RGB_fade.vhd, Schema_finale.png, vypis do gitu 
3. týždeň: <br>

<h1 style="color: #4CAF50;"> Popis I/O portov </h1>

  <head>
<style>
table {
  font-family: arial, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

td, th {
  border: 1px solid #dddddd;
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {
  background-color: #dddddd;
}
</style>
</head>
<body>
<table>
  <tr>
    <th>Signál</th>
    <th>I/O</th>
    <th>Popis</th>
  </tr>
  <tr>
    <td>btnu</td>
    <td>vstup</td>
    <td>zvýšenie hodnoty jasu LED-ky</td>
  </tr>
  <tr>
    <td>btnd</td>
    <td>vstup</td>
    <td>zníženie hodnoty jasu LED-ky</td>
  </tr>
  <tr>
    <td>btnr</td>
    <td>vstup</td>
    <td>zvýšenie hodnoty rýchlosti prechodu farieb</td>
  </tr>
  <tr>
    <td>btnl</td>
    <td>vstup</td>
    <td>zníženie rýchlosti prechodu farieb</td>
  </tr>
  <tr>
    <td>LED16_r</td>
    <td>výstup</td>
    <td>rozsvieti LED-ku na červeno</td>
  </tr>
  <tr>
    <td>LED16_g</td>
    <td>výstup</td>
    <td>rozsvieti LED-ku na zeleno</td>
  </tr>
  <tr>
   <td>LED16_b</td>
   <td>výstup</td>
   <td>rozsvieti LED-ku na modro</td>
  </tr>
</table>
</body>
 
<h1 style="color: #4CAF50;"> Simulácie: </h1>

Sim brght_speed_tb.vhdl
<br>
Simulujeme zmeny speed pre definované konštanty a zmenu jasu  pre definované konštanty s 8-bitovými countrami, ovladane clockom a resetom. 
<img width="1636" height="443" alt="simulacia_brght_speed" src="images/simulacia_brght_speed.png" />

brght_speed.vhdl slúži k nastaveniu jasu pomocou tlačítok up a down, a nastaveniu rýchlosti prechodu farieb tlačidlami left a right, debounce slúži k odladeniu šumov pri stláčaní tlačidiel  
<br>
RGB_fade.vhdl slúži k vytvoreniu postupného prechodu farieb RGB<br>
<img width="1047" height="401" alt="tb_fade" src="images/tb_fade.png"/>

