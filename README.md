# RGB_MOOD_LAMP

RGB lampa s plynulým prechodom medzi RGB farbami s možnosťou zmeny rýchlosti a intenzity jasu RGB led diódy pomocou tlačidiel dosky NEXYS A7-50T

<h3> Aktivita </h3>
2. týždeň: <br>
Samuel - brght_speed.vhd, brght_speed_tb.vhd, výpis do gitu
<br>
Jakub - RGB_fade.vhd, TOP_SCHEMA_RGB_LAMP.png, výpis do gitu
<br>
3. týždeň: 
<br>
Samuel - TOP_RGB_LAMPA.vhd, tb_PWM.vhd, výpis do gitu 
<br>
Jakub - tb_RGB_fade, PWM.vhd, výpis do gitu
<br>

<h1> Blokové schéma </h1>
<img width="1636" height="443" alt="simulacia_brght_speed" src="images/TOP_SCHEMA_RGB_LAMP.png" />

<h1 style="color: #4CAF50;"> Popis I/O portov modulu TOP </h1>

</head>
<body>
<table>
  <tr>
    <th>Signál</th>
    <th>I/O</th>
    <th>Popis</th>
  </tr>
  <tr>
    <td>clk</td>
    <td>vstup</td>
    <td>systémové hodiny</td>
  </tr>
  <tr>
    <td>rst</td>
    <td>vstup</td>
    <td>reset</td>
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

<h2> Sim brght_speed_tb.vhd </h2>
Simuluje zmeny intenzity jasu pre definované konštanty a zmenu rýchlosti prechodu farieb pre definované konštanty po stlační tlačidla
<img width="1636" height="443" alt="simulacia_brght_speed" src="images/simulacia_brght_speed.png" />
<b>0</b> => 0% => ledka nesvieti <br>
<b>26</b> => ledka svieti na 10% zo svojho maximálneho jasu, prechod farieb je 10% rýchlosti z maxima <br>
<b>64</b> => ledka svieti na 25% zo svojho maximálneho jasu, prechod farieb je 25% rýchlosti z maxima <br>
<b>102</b> => ledka svieti na 40% zo svojho maximálneho jasu, prechod farieb je 40% rýchlosti z maxima <br>
<b>128</b> => ledka svieti na 50% zo svojho maximálneho jasu, prechod farieb je 50% rýchlosti z maxima <br>
<b>191</b> => ledka svieti na 75% zo svojho maximálneho jasu, prechod farieb je 75% rýchlosti z maxima <br>
<b>230</b> => ledka svieti na 90% zo svojho maximálneho jasu, prechod farieb je 90% rýchlosti z maxima <br>
<b>255</b> => ledka svieti maximálnou intenzitou, prechod farieb je najrýchlejší možný <br>
<br>
odkaz na testbench simulácie: <a href="projekt/sources/sim_sources/brght_speed_tb.vhd">brhgt_speed_tb.vhd</a>

<h2> Sim tb_RGB_fade.vhd </h2>
Simuluje vytvorenie prechodu farieb RGB pre konkrétne nastavenú hodnotu jasu a rýchlosti prechodu farieb
<img width="1047" height="401" alt="tb_fade" src="images/tb_RGB_fade_sim.png"/>
odkaz na testbench simulácie: <a href="projekt/sources/sim_sources/tb_RGB_fade.vhd">tb_RGB_fade.vhd</a>

<h2> Sim tb_PWM.vhd </h2>
Simuluje postupné rozsvecovanie červenej, zelenej a modrej LED-ky RGB LED diódy
<img width="1047" height="401" alt="tb_PWM" src="images/tb_PWM_sim.png"/>
odkaz na testbench simulácie: <a href="projekt/sources/sim_sources/tb_PWM.vhd">tb_PWM.vhd</a>
