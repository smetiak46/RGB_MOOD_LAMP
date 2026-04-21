# RGB_MOOD_LAMP

rgb lampa preblikávajúca medzi RGB farbami a ich odtienami s možnosťou zmeny rýchlosti a intenzity jasu RGB led diódy pomocou tlačidiel dosky NEXYS A7-50T

TOP:
<img width="1120" height="561" alt="Schema_finale" src="https://github.com/user-attachments/assets/52d2d30c-f5c2-4828-ad92-12b19caf74ba" />

Popis I/O portov: <br>
btnu, btnd, btnr, btnl - sigál budený tlačidlami na doske NEXYS A7-50T, ktoré slúžia k nastaveniu hodnoty jasu a rýchlosti prechodu RGB farieb <br>
clk - hlavný hodinový signál <br>
rst - signál, ktorý uvedie počítadla do pôvodného stavu <br>

Modul brght_speed:


Aktivita:
Samuel - brght_speed.vhdl,brght_speed_tb.vhdl,
<br>
Jakub - RGB_fade.vhd, Schema_finale.png, vypis do gitu

Simulácie:
<br>
Sim brght_speed_tb.vhdl
<br>
Simulujeme postupne zmeny speed od 0 do 255 a zmenu jasu od 0 do 255 s 8-bitovými countrami, ovladane clockom a resetom. 
<img width="1636" height="443" alt="simulacia_brght_speed" src="https://github.com/user-attachments/assets/2d679251-3959-4675-8793-9735bba40000" />

brght_speed.vhdl slúži k nastaveniu jasu pomocou tlačítok up a down, a nastaveniu rýchlosti prechodu farieb tlačidlami left a right, debounce slúži k odladeniu šumov pri stláčaní tlačidiel  
<br>
RGB_fade.vhdl slúži k vytvoreniu postupného prechodu farieb RGB
