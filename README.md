# RGB_MOOD_LAMP

rgb lampa preblikávajúca medzi RGB farbami a ich odtienami s možnosťou zmeny rýchlosti a intenzity jasu RGB led diódy pomocou tlačidiel dosky NEXYS A7-50T

Aktivita:
2. týždeň: <br>
Samuel - brght_speed.vhdl,brght_speed_tb.vhdl, vypis do gitu 
<br>
Jakub - RGB_fade.vhd, Schema_finale.png, vypis do gitu 
3. týždeň: <br>

TOP:
<img width="1120" height="561" alt="Schema_finale" src="images/TOP_SCHEMA_RGB_LAMP.png"/>

<h1 style="color: #4CAF50;"> Modul Top: </h1>

  <span style="color: red;"><h2> Vstupy: </h2></span>
  btnu, btnd, btnr, btnl - signál budený tlačidlami na doske NEXYS A7-50T, ktoré slúžia k nastaveniu hodnoty jasu a rýchlosti prechodu RGB farieb <br>
  clk - hlavný hodinový signál <br>
  rst - signál, ktorý uvedie počítadla do pôvodného stavu <br>

  Výstupy: <br>
  led_r - rozsvieti červenú ledku
  led_g - rozsvieti zelenú ledku
  ôeg_b - rozsvieti modrú ledku
  
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

<h2>HTML Table</h2>

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
    <td>Laughing Bacchus Winecellars</td>
    <td>Yoshi Tannamuri</td>
    <td>Canada</td>
  </tr>
  <tr>
    <td>Magazzini Alimentari Riuniti</td>
    <td>Giovanni Rovelli</td>
    <td>Italy</td>
  </tr>
</table>

</body>
  |Signál|I/O|Popis|
  |btnu|vstup|zvýšenie hodnoty jasu LED-ky|
  |btnd|vstup|zníženie hodnoty jasu LED-ky|
  |btnr|vstup|zvýšenie hodnoty rýchlosti prechodu farieb|
  |btnl|vstup|zníženie hodnoty rýchlosti prechodu farieb|
  
  Výstupy: <br>
  btn_press - vysiela odfiltrované signály od hazardov <br>

  signály index_brightness, index_speed - prenáša odfiltrované signály medzi modulom debounce a brght_speed <br> 

<h1 style="color: #4CAF50;"> Modul brght_speed: </h1>

  Vstupy: <br>
  btnu - signál pre zvýšenie hodnoty jasu <br> 
  btnd - signál pre zníženie hodnoty jasu <br>
  brnr - signál pre zvýšenie hodnoty rýchlosti <br>
  btnl - signál pre zníženie hodnoty rýchlosti <br>

  Výstupy: <br>
  brght(7:0) - signál s priradeným indexom, ktorý nastavuje konkrétnu hodnotu jasu <br>
  speed(7:0) - signál s priradeným indexom, ktorý nastavuje konkrétnu hodnotu rýchlosti prechodu farieb <br>

  signály brght_sig(7:0) a speed_sig(7:0) prenášajú hodnotu jasu a rýchlosti z modulu brght_speed do modulu RGB_fade

<h1 style="color: #4CAF50;"> Modul RGB_fade: </h1>

  Vstupy: <br>
  brght(7:0) - 8 bitový vektor s prevzatou hodnotou jasu z modulu brght_speed <br>
  speed(7:0) - 8 bitový vektor s prevzatou hodnotou rýchlosti prechodu farieb z modulu brght_speed <br>

  Výstupy: <br>
  red(7:0), green(7:0), blue(7:0) - 8-bitové hodnoty okamžitej intenzity RGB zložiek, ktoré sa s časom menia <br>

  signály red_sig(7:0), green_sig(7:0), blue_sig(7:0) prenášajú parametre z bloku RGB_fade do bloku PWM <br>

<h1 style="color: #4CAF50;"> Modul PWM: </h1>

  Vstupy: <br>
  red(7:0), green(7:0), blue(7:0) - 8-bitové hodnoty okamžitej intenzity RGB zložiek, ktoré sa s časom menia prevzaté z bloku RGB_fade <br>

  Výstupy: <br>
  red_out - vysiela signál na rozsvietenie červenej led diódy RGB diódy
  green_out - vysiela signál na rozsvietenie zelenej led diódy RGB diódy
  blue_out - vysiela signál na rozsvietenie modrej led diódy RGB diódy
  
<h1 style="color: #4CAF50;"> Simulácie: </h1>

Sim brght_speed_tb.vhdl
<br>
Simulujeme zmeny speed pre definované konštanty a zmenu jasu  pre definované konštanty s 8-bitovými countrami, ovladane clockom a resetom. 
<img width="1636" height="443" alt="simulacia_brght_speed" src="images/simulacia_brght_speed.png" />

brght_speed.vhdl slúži k nastaveniu jasu pomocou tlačítok up a down, a nastaveniu rýchlosti prechodu farieb tlačidlami left a right, debounce slúži k odladeniu šumov pri stláčaní tlačidiel  
<br>
RGB_fade.vhdl slúži k vytvoreniu postupného prechodu farieb RGB<br>
<img width="1047" height="401" alt="tb_fade" src="images/tb_fade.png"/>

