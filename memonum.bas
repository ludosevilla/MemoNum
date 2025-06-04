1 REM -------------------------------------
2 REM --             MEMONUM             --
3 REM --   Jeu tout pourri pour PHC-25   --
4 REM --    2025 - Jean-arthur Silve     --
5 REM -------------------------------------
6 REM
20 CLS:screen 1:COLOR 2,,2:CLS
50 CLEAR 200,&HF134
51 P1=&HF134:P2=&HF135:P3=&HF136:P4=&HF137:P5=&HF138:P6=&HF139:PX=&HF140
52 dim ce(35),cb(35),cv(35),cm(10),er(8),dr(18)
61 PRINT "Routine graphique...":GOSUB 11000
66 PRINT "Symboles...":GOSUB 11100
120 m$="cdecdefgfedcbacdecdefgfedcbagfedcab"
130 pa=15
135 goto 10000
139 sc=0:lc=4
140 CLS:screen 3:color 1,3,1:cls
142 vi=50:ov=-1:oc=-1:ol=-1:ll=-1:cc=-1:fi=0:ca=0
145 for i=1 to 35:ce(i)=0:cb(i)=0:cv(i)=-1:next i
147 fi=0
150 gosub 5000
155 pa=pa-1
160 if ca<>pa then gosub 5500:goto 160
165 pa=pa+1
170 gosub 6220:gosub 6020:gosub 6905:AX=1:gosub 6500:AX=0
180 a$=inkey$:if a$="" then gosub 5840:goto 280
190 di=asc(a$)
200 IF (di<>30 AND di<>106) THEN GOTO 210
201 IF LL>0 THEN LL=LL-1:GOSUB 6020:goto 272 ELSE GOTO 280
210 IF (di<>31 AND di<>110) THEN GOTO 220
211 IF LL<4 THEN LL=LL+1:GOSUB 6020:goto 272 ELSE GOTO 280
220 IF (di<>29 AND di<>120) THEN GOTO 230
221 IF CC>0 THEN CC=CC-1:GOSUB 6020:goto 272 ELSE GOTO 280
230 IF (di<>28 AND di<>99) THEN GOTO 280
231 IF CC<6 THEN CC=CC+1:GOSUB 6020:goto 272 ELSE GOTO 280
272 if fi=2 then goto 400
274 if fi<>1 then goto 280
276 if lc<10 then lc=lc+1
277 goto 500
280 if ca<pa then gosub 5516
290 c=(LL*7)+CC+1:if ce(c)=0 then vi=vi-0.5:gosub 6500
310 if vi<=0 then goto 400 ELSE GOTO 180
320 GOTO 180
400 REM
410 REM --------------------------
420 REM --- Fin de partie
430 REM --------------------------
440 a$=inkey$:if a$<>"" then goto 440
445 if vi<0 then vi=0
450 play "s11o2l8el16dl8cl16dl8el8el16el16dl8dl16dl16el8gl16gl8fl16el8dl8c":cls:screen 2:color 4,4,1:cls:locate 7,1:print "****************":locate 7,2:print "**   PERDU!   **":locate 7,3:print "****************"
460 a$="Score actuel : "+str$(sc):a=len(a$):a=(32-a)/2:locate a,6:print a$
470 a$="Bonus : "+str$(int(vi)):a=len(a$):a=(32-a)/2:locate a,7:print a$
480 sc=sc+int(vi):a$="Total : "+str$(sc):a=len(a$):a=(32-a)/2:locate a,8:print a$
490 locate 3,14:print "On recommence? Tapez Espace";chr$(30)
492 a$=inkey$:if a$<>" " goto 492
494 goto 139
500 REM
510 REM --------------------------
520 REM --- Fin de niveau
530 REM --------------------------
535 a$=inkey$:if a$<>"" then goto 535
536 if vi<0 then vi=0
540 play "s11o2l10ccggaagffeeddcggffeeddggffeeddc":cls:screen 2:color 5,5,2:cls:locate 7,1:print "****************":locate 7,2:print "**   BRAVO!   **":locate 7,3:print "****************"
550 a$="Score actuel : "+str$(sc):a=len(a$):a=(32-a)/2:locate a,6:print a$
560 a$="Bonus : "+str$(int(vi)):a=len(a$):a=(32-a)/2:locate a,7:print a$
570 sc=sc+int(vi):a$ = "Total : "+str$(sc):a=len(a$):a=(32-a)/2:locate a,8:print a$
580 a$="Prochain niveau : "+str$(lc-3):a=len(a$):a=(32-a)/2:locate a,11:print a$
590 locate 5,14:print "Pret ? Tapez Espace !"
600 a$=inkey$:if a$<>" " goto 600
610 goto 140
4998 REM
4999 REM --------------------------
5000 REM --- Affiche grille complete
5001 REM --------------------------
5002 for i=0 to 7:play "s5o7l20e":line((i*35),175)-((i*35),0),2:next i
5003 for i=0 to 5:play "s5o7l20e":line(0,(i*35))-(245,(i*35)),2:next i
5010 n=0:for i=0 to 6:for j=0 to 4:X=(i*35)+8:y=(j*35)+1:n=n+1:play "s0o4L20"+mid$(m$,n,1):POKE ER(1),X/2:POKE ER(1)+1,Y+3:POKE P1,1:POKE P2,dr(3):POKE P3,dr(4):EXEC PX:ce((j*7)+i+1)=12:ca=ca+1
5086 if rnd(1)>=0.5 then goto 5090
5087 c=int(rnd(1)*10):cv((j*7)+i+1)=c:y=y+19:gosub 6710
5090 next j:next i:return
5496 REM
5497 REM --------------------------
5498 REM --- Ajout ou suppression d une case
5499 REM --------------------------
5500 if ca=pa then return
5510 if ca>pa then goto 5650
5515 REM Ajout d'une case
5516 m=0:if cc>-1 then m=(LL*7)+CC+1
5520 n = int(rnd(1)*35)+1
5530 if n<>m and ce(n) = 0 then goto 5550
5540 n=n+1:if n>35 then n=1
5545 goto 5530
5550 ce(n)=12:ca=ca+1
5551 if rnd(1)<0.5 then cb(n)=1: ADR=ER(2):Z1=dr(5):Z2=dr(6):goto 5560
5552 cb(n)=0: ADR=ER(1):Z1=dr(3):Z2=dr(4):
5560 j=int(((n-1)/7)):i=n-(j*7)-1::X=(i*35)+8:y=(j*35)+1
5601 POKE ADR,X/2:POKE ADR+1,Y+3:POKE P1,1:POKE P2,Z1:POKE P3,Z2:EXEC PX
5608 REM Il faut que le prochain chiffre a trouver soit present
5609 if rnd(1)>=0.5 then RETURN
5633 c=int(rnd(1)*10):cv(n)=c:y=y+19:if c=cm(np) then play"o6l60cdefg","o6r15l60cdefg"
5635 gosub 6710:return
5650 REM Suppression d'une case
5660 n=int(rnd(1)*35)+1
5670 if ce(n)>0 then goto 5690
5680 goto 5660
5690 ce(n)=0:cv(n)=-1:ca=ca-1
5700 j=int(((n-1)/7)):i=n-(j*7)-1:X=(i*35)+8:y=(j*35)+1
5735 play "s0o1l10d"
5740 line (X,Y+3)-(X+12,Y+30),3,bf
5750 return
5800 REM
5801 REM --------------------------
5810 REM --- Reduit une case
5811 REM --------------------------
5840 n=int(rnd(1)*35)+1
5842 if ce(n)>0 then goto 5870
5845 n=n+1: if n>35 then n=1
5846 goto 5842
5870 j=int(((n-1)/7)):i=n-(j*7)-1
5871 play "s0o3l60f"
5880 X=(i*35)+8:y=(j*35)+1:L=ce(n):O=12-ce(n)
5890 ce(n)=ce(n)-1
5901 if ce(n)<10 then ce(n)=0:cb(n)=0:line (X,Y+3)-(X+12,Y+30),3,bf:cv(n)=-1:ca=ca-1:goto 5910
5903 if ce(n)=11 then ADR=ER(3+cb(n)):Z1=dr(7+(2*cb(n))):Z2=dr(8+(2*cb(n))):GOTO 5905
5904 ADR=ER(5+cb(n)):Z1=dr(11+(2*cb(n))):Z2=dr(12+(2*cb(n)))
5905 POKE ADR,X/2:POKE ADR+1,Y+3:POKE P1,1:POKE P2,Z1:POKE P3,Z2:EXEC PX:RETURN
5910 c=(LL*7)+CC+1:if c<>n then return
5919 REM Joueur 
5921 X=(CC*35)+8+6:y=(LL*35)+1+6:POKE ER(7),(X-2)/2:POKE ER(7)+1,Y+3:POKE P1,1:POKE P2,dr(15):POKE P3,dr(16):EXEC PX
5980 return
6000 REM 
6001 REM --------------------------
6010 REM --- Affiche le joueur sur la ligne LL colonne CC (compte a partir de 0)
6011 REM --------------------------
6020 play "s0o4L20ab"
6025 X=(CC*35)+8+6:y=(LL*35)+1+6:c=(LL*7)+CC+1
6036 REM Joueur 
6037 if ce(c)=0 then GOTO 6179
6038 REM paint(x,y+2),4,3
6040 if cb(c)=1 and (cv(c)=-1 or cv(c)=cm(np)) then vi=vi+20:cb(c)=0:play "","o4l15v15s11gaf":gosub 6500
6050 if cv(c)>-1 and cm(np)=cv(c) then vi=vi+10:goto 6070
6060 if cv(c)>-1 then vi=vi-10:gosub 6500:goto 6100
6065 play "o5l60gfedc","o5r15l60gfedc":sc=sc+ce(c):n=c:gosub 5690:X=(CC*35)+8+6:y=(LL*35)+1+6:POKE ER(7),(X-2)/2:POKE ER(7)+1,Y+3:POKE P1,1:POKE P2,dr(15):POKE P3,dr(16):EXEC PX:goto 6180
6070 REM Case correspondant au chiffre cherche
6072 sc=sc+(ce(c)*2):np=np+1:if np>lc then fi=1
6075 play "","o5l15v15s11gaf":n=c:gosub 5690
6080 goto 6179
6100 REM Case ne correspondant pas au chiffre cherche
6101 play "","s13o1l20c":n=c:gosub 5690:if vi<=0 then fi=2
6178 REM Joueur
6179 X=(CC*35)+8+6:y=(LL*35)+1+6:POKE ER(7),(X-2)/2:POKE ER(7)+1,Y+3:POKE P1,1:POKE P2,dr(15):POKE P3,dr(16):EXEC PX
6180 if oc<0 then oc=cc:ol=ll:return
6181 X=(OC*35)+8+6:y=(OL*35)+1+6:c=(ol*7)+oc+1
6189 REM Efface Joueur
6190 if ce(c)=0 then POKE ER(8),(X-2)/2:POKE ER(8)+1,Y+3:POKE P1,1:POKE P2,dr(17):POKE P3,dr(18):EXEC PX:GOTO 6197
6197 oc=cc:ol=ll:return
6200 REM 
6201 REM --------------------------
6210 REM --- Determine la position de depart
6211 REM --------------------------
6220 zn=int(rnd(1)*35)+1
6230 if ce(zn)>0 and cv(zn)=-1 then goto 6250
6240 GOTO 6220
6250 LL=int((zn-1)/7):CC=(zN-1)-LL*7
6260 return
6500 REM --------------------------
6501 REM --- Barre de vie & score
6502 REM --------------------------
6505 if vi>50 then vi=50:goto 6507
6506 if vi<0 then vi=0
6507 POKE P1,0:POKE P2,int(VI):POKE P5,DR(1):POKE P6,dr(2)
6508 IF AX=0 THEN POKE P3,SC-INT(SC/256)*256:POKE P4,INT(SC/256):EXEC PX:RETURN
6509 IF SC<100 THEN AX=10: goto 6512
6510 IF SC<1000 THEN AX=100:goto 6512
6511 AX=1000
6512 FOR I=0 TO SC STEP AX:play"o6l64g":POKE P3,I-INT(I/256)*256:POKE P4,INT(I/256):EXEC PX:NEXT I
6513 POKE P3,SC-INT(SC/256)*256:POKE P4,INT(SC/256):EXEC PX:RETURN
6700 REM --------------------------
6701 REM --- Affiche un chiffre C en position X et Y
6702 REM --------------------------
6710 ADR=DD+(C*30)
6730 POKE ADR,X/2:POKE ADR+1,Y:POKE P1,1:POKE P2,ADR-INT(ADR/256)*256:POKE P3,INT(ADR/256):EXEC PX
6830 return
6900 REM --------------------------
6901 REM --- Determination de la combinaison a trouver
6902 REM --------------------------
6905 Y=180:L=4:H=8:R=1:X=240-(10*lc)
6910 for yi=1 to lc:c=int(rnd(1)*10):cm(yi)=c 
6920 locate 13-lc+yi,15: print c;chr$(30)
6930 next yi 
6940 for yi=1 to lc:play "s11o1l5g":for xi=1 to 400:next xi:next yi:play "s11o1l2a": for xi=1 to 400:next xi
6950 line(1,180)-(256,192),3,bf:np=1
6970 return
10000 SCREEN 3:COLOR 2,3,1:CLS
10004 POKE P1,1:POKE ER(7)+1,5:POKE P2,dr(15):POKE P3,dr(16)
10006 FOR I = 0 TO 128 STEP 12:POKE ER(7),I:EXEC PX:NEXT I
10010 LOCATE 2,2:PRINT "M E M O N U M"
10020 POKE ER(7)+1,45
10030 FOR I = 0 TO 128 STEP 12:POKE ER(7),I:EXEC PX:NEXT I
10032 play "o5l8cdecdefgabo6ccl16o5bagfedcl8r8o5cdeo6cbl4o5g","o4l8gagfgafefgddeeo5ccl16r8o4bagfedel4o4c","o3l16cgcfcgcfcgcfcgcgo2l8ccggffeeddccl1"
10035 COLOR 1,3,1
10040 LOCATE 2,8:PRINT "Taper Espace":LOCATE 3,9:PRINT "pour jouer":COLOR 4,3,1:LOCATE 3,11:PRINT "Controles:":LOCATE 3,12:PRINT "Fleches ou":LOCATE 4,13:PRINT "N,J,X,C"
10280 a$=inkey$:if a$="" then goto 10280
10300 if a$=" " then goto 139
10340 goto 10280
11000 REM Routine Graphique
11005 DATA "DDE5DD210000DD3921F4FF39F93A34F1DD77FFB7280ADD7EFF3DCA50F3C3F3F33A35F14F06005950CB7828055950131313"
11006 DATA "CB2ACB1BCB2ACB1BDD73FB11C076DD36FE00DD7EFEDD96FB3034DD36FF00DD7EFFDD77FCDD36FD003E05DDCBFC26DDCBFD"
11007 DATA "163D20F5DD6EFCDD66FD193600DD34FFDD7EFFD60638D613DD34FE18C479E6034F3E04918747AF0418018710FDF6AA4F06"
11008 DATA "00682600292929292919710478D60638F0137BD6CD7ADE7630160E0069260029292929291936AA0C79D60638EF1318E23A"
11009 DATA "36F12137F1460E005F160079B34F78B2473A38F12139F1561E006F26007BB5DD77F67AB4DD77F7DD36FD64DD36F810DD36"
11010 DATA "F927C5DD5EF8DD56F96960CDFDF3C16BDD5EFD2600D55D5429192919291929D17DDD86F6DD77FE7CDD8EF7DD77FF16B5DD"
11011 DATA "6EFEDD66FF7EDD77FCD65ACA1BF3DD7EFCD6592007DD73FD14C30FF3DD7EFCD6582006DD36FA021804DD36FA03DD7EFDDD"
11012 DATA "77F4DD36F5006AAFCB1FCB1D1FDD86F4DD77FB7DDD8EF5DD77FCDD6EFBDD66FCCB3CCB1DCB3CCB1DFD210060C54D44FD09"
11013 DATA "C1DD7EFBE603876F3E06956FDD66FA7D3C1802CB243D20FBDD74FADD36FB032C1804DDCBFB262D20F9FDE5E17EDD77FCDD"
11014 DATA "7EFB2FDDA6FCDD77FCDD7EFADDA6FBDDB6FC77DD34FDDD34FEC265F2DD34FFC365F27BC605DD77FD3E01DDBEF83E00DD9E"
11015 DATA "F9D2F3F3DD5EF8DD56F96960CD33F4D5110A00DD6EF8DD66F9CDFDF3C1DD73F8DD72F9C337F22135F14E3A36F1571E0043"
11016 DATA "79B34F78B24769606E5D0351600ADD77FD7AC601DD77FE7CCE00DD77FFDD4EFEDD46FF0AFE5A28701800FE5920066BDD34"
11017 DATA "FD185A5514FE5820036A1851C6BFDD77FC4D0600DD6EFD260029292929292929094DCB3CCB1DCB3CCB1D7CC6606779E603"
11018 DATA "4FCB213E06914FDD7EFC410418018710FDDD77FC410E03041802CB2110FC46792FA0F579DDA6FC4FF1B1776ADD34FE208A"
11019 DATA "DD34FF1885DDF9DDE1C95D6F2600547BE680B220110610ED6A17933001833FED6A10F65FEBC906097D6C2600CB1DED6AED"
11020 DATA "523001193F1710F5CB10505FC95D6FCDFAF3EBC9CDFDF3EBC9"
11030 DATA "X"
11031 RESTORE 11005:ADR=PX
11032 READ DX$:if DX$<>"X" THEN X=LEN(DX$):FOR J=1 TO X STEP 2: POKE ADR,VAL("&H"+MID$(DX$,J,2)):ADR=ADR+1:NEXT J:GOTO 11032
11033 DX$="":RETURN
11100 REM  Symboles
11101 DATA "..DDDYDXDYDXDYDXDYDXDYDXDYDDDZ","..XXDYXXDYXXDYXXDYXXDYXXDYXXDZ","..DDDYXXDYXXDYDDDYDXXYDXXYDDDZ","..DDDYXXDYXXDYDDDYXXDYXXDYDDDZ","..DXDYDXDYDXDYDDDYXXDYXXDYXXDZ"
11102 DATA "..DDDYDXXYDXXYDDDYXXDYXXDYDDDZ","..DXXYDXXYDXXYDDDYDXDYDXDYDDDZ","..DDDYXXDYXXDYXXDYXXDYXXDYXXDZ","..DDDYDXDYDXDYDDDYDXDYDXDYDDDZ","..DDDYDXDYDXDYDDDYXXDYXXDYXXDZ"
11103 DATA "..CAAAACYAAAAAAYADAADAYAADDAAYADAADAYADAADAYADAADAYADAADAYAADDAAYADAADAYAAAAAAYCAAAACYZ","..CBBBBCYBBBBBBYBDBBDBYBBDDBBYBDBBDBYBDBBDBYBDBBDBYBDBBDBYBBDDBBYBDBBDBYBBBBBBYCBBBBCYZ"
11104 DATA "..CCCCCCYCACCACYCDAADCYCADDACYCDAADCYADAADAYCDAADCYADAADAYCADDACYCDAADCYCACCACYCCCCCCYZ","..CCCCCCYCBCCBCYCDBBDCYCBDDBCYCDBBDCYBDBBDBYCDBBDCYBDBBDBYCBDDBCYCDBBDCYCBCCBCYCCCCCCYZ"
11105 DATA "..CCCCCCYCCCCCCYCCCCCCYCCDDCCYCDAADCYCDAADCYCDAADCYCDAADCYCCDDCCYCCCCCCYCCCCCCYCCCCCCYZ","..CCCCCCYCCCCCCYCCCCCCYCCDDCCYCDBBDCYCDBBDCYCDBBDCYCDBBDCYCCDDCCYCCCCCCYCCCCCCYCCCCCCYZ"
11106 DATA "..XXXDYXXDDDYXDDDDDYDDBDBDDYDDDDDDDYDDADADDYDDDADDDYXDDDDDYXBDDDBYBBXDXBBZ","..XXXCYXXCCCYXCCCCCYCCCCCCCYCCCCCCCYCCCCCCCYCCCCCCCYXCCCCCYXCCCCCYCCXCXCCZ"
11120 RESTORE 11101:DD=ADR+65536:DR(1)=(DD+2)-INT((DD+2)/256)*256:dr(2)=INT((DD+2)/256):FOR I=1 TO 10:READ DX$:FOR J=1 TO 30 
11121 POKE ADR,ASC(MID$(DX$,J,1)):ADR=ADR+1:NEXT J:NEXT I
11125 FOR I=1 to 6
11126 READ DX$:ER(I)=ADR:ZZ=ADR+65536:DR((I*2)+1)=ZZ-INT(ZZ/256)*256:DR((I*2)+2)=INT(ZZ/256):FOR J=1 TO 87:POKE ADR,ASC(MID$(DX$,J,1)):ADR=ADR+1:NEXT J
11127 NEXT I
11134 READ DX$:ER(7)=ADR:ZZ=ADR+65536:dr(15)=ZZ-INT(ZZ/256)*256:dr(16)=INT(ZZ/256):FOR J=1 TO 74:POKE ADR,ASC(MID$(DX$,J,1)):ADR=ADR+1:NEXT J
11136 READ DX$:ER(8)=ADR:ZZ=ADR+65536:dr(17)=ZZ-INT(ZZ/256)*256:dr(18)=INT(ZZ/256):FOR J=1 TO 74:POKE ADR,ASC(MID$(DX$,J,1)):ADR=ADR+1:NEXT J
11149 DX$=""
11150 RETURN
