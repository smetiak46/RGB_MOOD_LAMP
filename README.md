# RGB_MOOD_LAMP

rgb lampa preblikávajúca medzi RGB farbami a ich odtienami s možnosťou zmeny rýchlosti a intenzity jasu RGB led diódy pomocou tlačidiel dosky NEXYS A7-50T

Aktivita:
2. týždeň: <br>
Samuel - brght_speed.vhdl,brght_speed_tb.vhdl, vypis do gitu 
<br>
Jakub - RGB_fade.vhd, Schema_finale.png, vypis do gitu 
3. týždeň: <br>

TOP:
<img width="1120" height="561" alt="Schema_finale" src="https://github.com/user-attachments/assets/52d2d30c-f5c2-4828-ad92-12b19caf74ba" />

Popis I/O portov: <br>

Modul Top: <br>

  Vstupy: <br>
  btnu, btnd, btnr, btnl - signál budený tlačidlami na doske NEXYS A7-50T, ktoré slúžia k nastaveniu hodnoty jasu a rýchlosti prechodu RGB farieb <br>
  clk - hlavný hodinový signál <br>
  rst - signál, ktorý uvedie počítadla do pôvodného stavu <br>

  Výstupy: <br>
  led_r - rozsvieti červenú ledku
  led_g - rozsvieti zelenú ledku
  ôeg_b - rozsvieti modrú ledku
  
Modul debounce: <br>

  Vstupy: <br>
  btn_in - prijíma signál vyslaný z tlačidla dosky na spracovanie v bloku debounce

  Výstupy: <br>
  btn_press - vysiela odfiltrované signály od hazardov <br>

  signály index_brightness, index_speed - prenáša odfiltrované signály medzi modulom debounce a brght_speed <br> 

Modul brght_speed: <br>

  Vstupy: <br>
  btnu - signál pre zvýšenie hodnoty jasu <br> 
  btnd - signál pre zníženie hodnoty jasu <br>
  brnr - signál pre zvýšenie hodnoty rýchlosti <br>
  btnl - signál pre zníženie hodnoty rýchlosti <br>

  Výstupy: <br>
  brght(7:0) - signál s priradeným indexom, ktorý nastavuje konkrétnu hodnotu jasu <br>
  speed(7:0) - signál s priradeným indexom, ktorý nastavuje konkrétnu hodnotu rýchlosti prechodu farieb <br>

  signály brght_sig(7:0) a speed_sig(7:0) prenášajú hodnotu jasu a rýchlosti z modulu brght_speed do modulu RGB_fade

Modul RGB_fade: <br>

  Vstupy: <br>
  brght(7:0) - 8 bitový vektor s prevzatou hodnotou jasu z modulu brght_speed <br>
  speed(7:0) - 8 bitový vektor s prevzatou hodnotou rýchlosti prechodu farieb z modulu brght_speed <br>

  Výstupy: <br>
  red(7:0), green(7:0), blue(7:0) - 8-bitové hodnoty okamžitej intenzity RGB zložiek, ktoré sa s časom menia <br>

  signály red_sig(7:0), green_sig(7:0), blue_sig(7:0) prenášajú parametre z bloku RGB_fade do bloku PWM <br>

Modul PWM: <br>

  Vstupy: <br>
  red(7:0), green(7:0), blue(7:0) - 8-bitové hodnoty okamžitej intenzity RGB zložiek, ktoré sa s časom menia prevzaté z bloku RGB_fade <br>

  Výstupy: <br>
  red_out - vysiela signál na rozsvietenie červenej led diódy RGB diódy
  green_out - vysiela signál na rozsvietenie zelenej led diódy RGB diódy
  blue_out - vysiela signál na rozsvietenie modrej led diódy RGB diódy
  
Simulácie:
<br>
Sim brght_speed_tb.vhdl
<br>
Simulujeme postupne zmeny speed od 0 do 255 a zmenu jasu od 0 do 255 s 8-bitovými countrami, ovladane clockom a resetom. 
<img width="1636" height="443" alt="simulacia_brght_speed" src="https://github.com/user-attachments/assets/2d679251-3959-4675-8793-9735bba40000" />

brght_speed.vhdl slúži k nastaveniu jasu pomocou tlačítok up a down, a nastaveniu rýchlosti prechodu farieb tlačidlami left a right, debounce slúži k odladeniu šumov pri stláčaní tlačidiel  
<br>
RGB_fade.vhdl slúži k vytvoreniu postupného prechodu farieb RGB
