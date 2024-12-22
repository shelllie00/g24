INCLUDE Irvine32.inc

.data
; Define BoxSize
MarginSize = 15 ; Margin size
ScreenWidth = 130
ScreenHeight = 30

; Define airplane
airplaneDraw1 BYTE ' ', ' ', ' ', ' ', ' ', '/', 5ch, 0
airplaneDraw2 BYTE ' ', ' ', '_', '_', '/', ' ', ' ', 5ch, '_', '_', 0
airplaneDraw3 BYTE '/', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', 5ch, 0
airplaneDraw4 BYTE  ' ',' ',' ', ' ', '|', ' ', ' ', '|', 0
airplaneDraw5 BYTE  ' ',' ', ' ', '/', '_', '|', '|', '_', 5ch, 0
bullet BYTE '*'
initialAirplanePos COORD <ScreenWidth / 2, ScreenHeight - 2>
airplanePos COORD <ScreenWidth / 2, ScreenHeight - 2>
bulletPos COORD <0, 0>

; Define enemies
enemyShape1draw1 BYTE ' ______', 0
enemyShape1draw2 BYTE '| O  O |', 0
enemyShape1draw3 BYTE '|  <>  |', 0
enemyShape1draw4 BYTE '|  \/  |', 0
enemyShape1draw5 BYTE '|______|', 0

enemyShape2draw1 BYTE '  _____', 0
enemyShape2draw2 BYTE ' /     \ ', 0
enemyShape2draw3 BYTE '|       |', 0
enemyShape2draw4 BYTE ' \_____/ ', 0
enemyShape2draw5 BYTE '  (   )', 0

enemyShape3draw1 BYTE '   ( )   ', 0
enemyShape3draw2 BYTE ' /     \ ', 0
enemyShape3draw3 BYTE '|   *   | ', 0
enemyShape3draw4 BYTE ' \     / ', 0
enemyShape3draw5 BYTE '  \___/ ' , 0


enemyShape4draw1 BYTE ' _______', 0
enemyShape4draw2 BYTE '|  O O  |', 0
enemyShape4draw3 BYTE '|   ^   |', 0
enemyShape4draw4 BYTE '|  \_/  |', 0
enemyShape4draw5 BYTE ' \_____/ ', 0


enemyBullet1 BYTE 'o'
enemyBullet2 BYTE 'o'
enemyBullet3 BYTE 'o'
enemyBullet4 BYTE 'o'

; Define enemy positions and bullets
enemyPos1 COORD <26, 7>
enemyBulletPos1 COORD <30, 5>
enemyPos2 COORD <46, 7>
enemyBulletPos2 COORD <50, 5>
enemyPos3 COORD <76, 7>
enemyBulletPos3 COORD <80, 5>
enemyPos4 COORD <96, 7>
enemyBulletPos4 COORD <100, 5>
enemyActive1 BYTE 1
enemyActive2 BYTE 1
enemyActive3 BYTE 1
enemyActive4 BYTE 1

;Define boundary
boundary BYTE '||'
boundaryPosLeft COORD <13, 0>
boundaryPosRight COORD <0 , 0>
boundaryDrawn BYTE 0

;addLife
addLife BYTE '$'
addLifePos COORD <25 , 5>  
addLifeColor WORD 0A9h     
dropPos WORD 33,85,112,78,90,35,110,17
flag WORD 0

;bomb (minus 2 life)
bomb BYTE '#'
bombPos COORD <77 , 5>  
bombColor WORD 0C9h     
dropBombPos WORD 66,44,33,99,41,28,100,50
flagBomb WORD 0

;bomb2 (minus 1 life)
bomb2 BYTE '!'
bombPos2 COORD <20 , 5>  
bombColor2 WORD 0E9h    
dropBombPos2 WORD 44,55,22,99,88,101,66,77
flagBomb2 WORD 0

; Define "WIN!" 
winPos COORD <55,15>
winDraw1 BYTE '_','_',' ',' ',' ',' ',' ',' ',' ',' ','_','_','_','_','_',' ','_',' ',' ',' ','_',' ',' ',' ','_',0 
winDraw2 BYTE 5ch,' ',5ch,' ',' ',' ',' ',' ',' ','/',' ','/','_',' ','_',7ch,' ',5ch,' ',7ch,' ',7ch,' ',7ch,' ',7ch,0
winDraw3 BYTE ' ',5ch,' ',5ch,' ','/',5ch,' ','/',' ','/',' ',7ch,' ',7ch,7ch,' ',' ',5ch,7ch,' ',7ch,' ',7ch,' ',7ch,0
winDraw4 BYTE ' ',' ',5ch,' ','V',' ',' ','V',' ','/',' ',' ',7ch,' ',7ch,7ch,' ',7ch,5ch,' ',' ',7ch,' ',7ch,'_',7ch,0
winDraw5 BYTE ' ',' ',' ',5ch,'_','/',5ch,'_','/',' ',' ',7ch,'_','_','_',7ch,'_',7ch,' ',5ch,'_',7ch,' ','(','_',')',0

; Define "LOSE"
losePos COORD <55,15>
loseDraw1 BYTE ' ','_',' ',' ',' ',' ',' ','_','_','_',' ',' ','_','_','_','_',' ',' ','_','_','_','_','_',' ',' ',' ','_',' ',0
loseDraw2 BYTE '|',' ',7ch,' ',' ',' ','/',' ','_',' ',5ch,'/',' ','_','_','_',7ch,7ch,' ','_','_','_','_',7ch,' ',7ch,' ',7ch,0
loseDraw3 BYTE '|',' ',7ch,' ',' ',7ch,' ',7ch,' ',7ch,' ',5ch,'_','_','_',' ',5ch,7ch,' ',' ','_',7ch,' ',' ',' ',7ch,' ',7ch,0
loseDraw4 BYTE '|',' ',7ch,'_','_',7ch,' ',7ch,'_',7ch,' ',7ch,'_','_','_',')',' ',7ch,' ',7ch,'_','_','_',' ',' ',7ch,'_',7ch,0
loseDraw5 BYTE '|','_','_','_','_','_',5ch,'_','_','_','/',7ch,'_','_','_','_','/',7ch,'_','_','_','_','_',7ch,' ','(','_',')',0


; Define others
outputHandle DWORD 0
bytesWritten DWORD 0
screenBuffer COORD <130,30>
count DWORD 0

; Define lives
life DWORD 3
lifeSymbol1 BYTE 'H','P',':',03h,0
lifeSymbol2 BYTE 'H','P',':',03h, 03h, 0
lifeSymbol3 BYTE 'H','P',':',03h, 03h, 03h, 0
lifePos COORD <5, 3>

main EQU start@0

.code
SetConsoleOutputCP PROTO STDCALL :DWORD
GetAsyncKeyState PROTO STDCALL :DWORD
Random PROTO min:WORD, max:WORD


main PROC
    ; Initialize console
    INVOKE SetConsoleOutputCP, 65001 ; Set console output to UTF-8
    INVOKE GetStdHandle, STD_OUTPUT_HANDLE
    mov outputHandle, eax
    call Clrscr
	
    ; Main game loop
    gameLoop:
        ; Clear screen
        call Clrscr
		
		;Draw boundary
		mov boundaryPosRight.x, ScreenWidth - 13
		mov boundaryPosLeft.y,3
		mov boundaryPosRight.y,3
		
		DrawBoundaryLeft:
			INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR boundary, 2, boundaryPosLeft, ADDR count
			inc boundaryPosLeft.y
			cmp boundaryPosLeft.y, ScreenHeight-2
			jge DrawBoundaryRight
			jmp DrawBoundaryLeft
		
		DrawBoundaryRight:
			INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR boundary, 2, boundaryPosRight, ADDR count
			inc boundaryPosRight.y
			cmp boundaryPosRight.y, ScreenHeight-2
			jge EndBoundaryDrawing
			jmp DrawBoundaryRight
			
		EndBoundaryDrawing:
		
        ; Draw life
        cmp life, 3
        je drawlife3
        cmp life, 2
        je drawlife2
        cmp life, 1
        je drawlife1

    ; Draw life
    drawlife3:
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR lifeSymbol3, 6, lifePos, ADDR count
        jmp drawAirplane
    drawlife2:
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR lifeSymbol2, 5, lifePos, ADDR count
        jmp drawAirplane
    drawlife1:
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR lifeSymbol1, 4, lifePos, ADDR count
        jmp drawAirplane
	
	

    ; Draw airplane
    drawAirplane:
        INVOKE WriteConsoleOutputCharacter,
               outputHandle, ADDR airplaneDraw5, LENGTHOF airplaneDraw5, airplanePos, ADDR count
        dec airplanePos.y
        INVOKE WriteConsoleOutputCharacter,
               outputHandle, ADDR airplaneDraw4, LENGTHOF airplaneDraw4, airplanePos, ADDR count
        dec airplanePos.y
        INVOKE WriteConsoleOutputCharacter,
               outputHandle, ADDR airplaneDraw3, LENGTHOF airplaneDraw3, airplanePos, ADDR count
        dec airplanePos.y
        INVOKE WriteConsoleOutputCharacter,
               outputHandle, ADDR airplaneDraw2, LENGTHOF airplaneDraw2, airplanePos, ADDR count
        dec airplanePos.y
        INVOKE WriteConsoleOutputCharacter,
               outputHandle, ADDR airplaneDraw1, LENGTHOF airplaneDraw1, airplanePos, ADDR count
        dec airplanePos.y
        add airplanePos.y, 5 ; Add back 5 to airplanePos.y
			

        ; Draw my bullet if active
        cmp bulletPos.y, 0
        je skipBullet
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR bullet, 1, bulletPos, ADDR count
    skipBullet:
	
	

        ; Draw enemies and their bullets
    drawenemy1:
        cmp enemyActive1, 0 ; Check if enemy is active 
        je drawEnemy2
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyShape1draw5, LENGTHOF enemyShape1draw5, enemyPos1, ADDR count
		dec enemyPos1.y
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyShape1draw4, LENGTHOF enemyShape1draw4, enemyPos1, ADDR count
		dec enemyPos1.y
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyShape1draw3, LENGTHOF enemyShape1draw3, enemyPos1, ADDR count
		dec enemyPos1.y
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyShape1draw2, LENGTHOF enemyShape1draw3, enemyPos1, ADDR count
		dec enemyPos1.y
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyShape1draw1, LENGTHOF enemyShape1draw1, enemyPos1, ADDR count
		dec enemyPos1.y
		add enemyPos1.y, 5 
		
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyBullet1, 1, enemyBulletPos1, ADDR count
        cmp enemyBulletPos1.y, ScreenHeight-5 ; Check if enemy bullet is at the bottom of the screen
        jle bulletdrop1
        mov enemyBulletPos1.x, 30 ; Reset enemyBullet1 position
        mov enemyBulletPos1.y, 5
        jmp drawEnemy2
        bulletdrop1:
        inc enemyBulletPos1.y ; Bullet drop

    drawEnemy2:
        cmp enemyActive2, 0 ; Check if enemy is active
        je drawEnemy3
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyShape2draw5, LENGTHOF enemyShape2draw5, enemyPos2, ADDR count
		dec enemyPos2.y
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyShape2draw4, LENGTHOF enemyShape2draw4, enemyPos2, ADDR count
		dec enemyPos2.y
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyShape2draw3, LENGTHOF enemyShape2draw3, enemyPos2, ADDR count
		dec enemyPos2.y
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyShape2draw2, LENGTHOF enemyShape2draw3, enemyPos2, ADDR count
		dec enemyPos2.y
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyShape2draw1, LENGTHOF enemyShape2draw1, enemyPos2, ADDR count
		dec enemyPos2.y
		add enemyPos2.y, 5 
		
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyBullet2, 1, enemyBulletPos2, ADDR count
        cmp enemyBulletPos2.y, ScreenHeight-5 ; Check if enemy bullet is at the bottom of the screen
        jle bulletdrop2
        mov enemyBulletPos2.x, 50 ; Reset enemyBullet2 position
        mov enemyBulletPos2.y, 5
        jmp drawEnemy3
        bulletdrop2:
        inc enemyBulletPos2.y ; Bullet drop
     
    drawEnemy3:
        cmp enemyActive3, 0 ; Check if enemy is active
        je drawEnemy4
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyShape3draw5, LENGTHOF enemyShape3draw5, enemyPos3, ADDR count
		dec enemyPos3.y
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyShape3draw4, LENGTHOF enemyShape1draw3, enemyPos3, ADDR count
		dec enemyPos3.y
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyShape3draw3, LENGTHOF enemyShape1draw3, enemyPos3, ADDR count
		dec enemyPos3.y
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyShape3draw2, LENGTHOF enemyShape1draw3, enemyPos3, ADDR count
		dec enemyPos3.y
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyShape3draw1, LENGTHOF enemyShape1draw3, enemyPos3, ADDR count
		dec enemyPos3.y
		add enemyPos3.y, 5
		
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyBullet3, 1, enemyBulletPos3, ADDR count
        cmp enemyBulletPos3.y, ScreenHeight-5 ; Check if enemy bullet is at the bottom of the screen
        jle bulletdrop3
        mov enemyBulletPos3.x, 80 ; Reset enemyBullet3 position
        mov enemyBulletPos3.y, 5
        jmp drawEnemy4
        bulletdrop3:
        inc enemyBulletPos3.y ; Bullet drop

    drawEnemy4:
        cmp enemyActive4, 0 ; Check if enemy is active
        je endDrawEnemies
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyShape4draw5, LENGTHOF enemyShape4draw5, enemyPos4, ADDR count
		dec enemyPos4.y
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyShape4draw4, LENGTHOF enemyShape4draw4, enemyPos4, ADDR count
		dec enemyPos4.y
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyShape4draw3, LENGTHOF enemyShape4draw3, enemyPos4, ADDR count
		dec enemyPos4.y
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyShape4draw2, LENGTHOF enemyShape4draw3, enemyPos4, ADDR count
		dec enemyPos4.y
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyShape4draw1, LENGTHOF enemyShape4draw1, enemyPos4, ADDR count
		dec enemyPos4.y
		add enemyPos4.y ,5
		
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyBullet4, 1, enemyBulletPos4, ADDR count
        cmp enemyBulletPos4.y, ScreenHeight-5 ; Check if enemy bullet is at the bottom of the screen
        jle bulletdrop4
        mov enemyBulletPos4.x, 100 ; Reset enemyBullet4 position
        mov enemyBulletPos4.y, 5
        jmp endDrawEnemies
        bulletdrop4:
        inc enemyBulletPos4.y ; Bullet drop

    endDrawEnemies:
	
	; Draw addLife
	GenerateLife:
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR addLife, 1, addLifePos, ADDR count
		invoke WriteConsoleOutputAttribute, outputHandle, ADDR addLifeColor, 1, addLifePos, ADDR count
		cmp addLifePos.y, ScreenHeight-5 
		jle addingLifeDrop
		cmp flag,7
		jge resetFlag
		movzx ebx ,flag
		shl ebx, 1  ;mul by 2
		mov esi, OFFSET dropPos
		inc flag 
		mov ax,[esi+ebx]
		mov addLifePos.x, ax 
		mov addLifePos.y, 5      ; Start at the top of the screen
		jmp EndGenerateLife
		
		addingLifeDrop:
		inc addLifePos.y ; drop 
		jmp EndGenerateLife
		
		resetFlag:
			mov flag,0
			mov ax,dropPos
			mov addLifePos.x, ax    
			mov addLifePos.y, 5      ; Start at the top of the screen
			jmp EndGenerateLife
		
	EndGenerateLife:
	
	; Draw bomb
	BombDraw:
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR bomb, 1, bombPos, ADDR count
		invoke WriteConsoleOutputAttribute, outputHandle, ADDR bombColor, 1, bombPos, ADDR count
		cmp bombPos.y, ScreenHeight-5 
		jle bombDrop
		cmp flagBomb,7
		jge resetBombFlag
		movzx ebx ,flagBomb
		shl ebx, 1  ;mul by 2
		mov esi, OFFSET dropBombPos
		inc flagBomb 
		mov ax,[esi+ebx]
		mov bombPos.x, ax 
		mov bombPos.y, 5      ; Start at the top of the screen
		jmp EndBomb
		
		bombDrop:
		inc bombPos.y ; drop 
		jmp EndBomb
		
		resetBombFlag:
			mov flagBomb,0
			mov bombPos.x, 55   
			mov bombPos.y, 5      ; Start at the top of the screen
			jmp EndBomb
		
	EndBomb:
	
	; Draw bomb
	BombDraw2:
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR bomb2, 1, bombPos2, ADDR count
		invoke WriteConsoleOutputAttribute, outputHandle, ADDR bombColor2, 1, bombPos2, ADDR count
		cmp bombPos2.y, ScreenHeight-5 
		jle bombDrop2
		cmp flagBomb2,7
		jge resetBombFlag2
		movzx ebx ,flagBomb2
		shl ebx, 1  ;mul by 2
		mov esi, OFFSET dropBombPos2
		inc flagBomb2 
		mov ax,[esi+ebx]
		mov bombPos2.x, ax 
		mov bombPos2.y, 5      ; Start at the top of the screen
		jmp EndBomb2
		
		bombDrop2:
		inc bombPos2.y ; drop 
		jmp EndBomb2
		
		resetBombFlag2:
			mov flagBomb2,0
			mov bombPos2.x,36 
			mov bombPos2.y, 5      ; Start at the top of the screen
			jmp EndBomb2
		
	EndBomb2:
	
	
	
	
        ; Handle input
        INVOKE GetAsyncKeyState, VK_LEFT
        test ax, 8000h
        jz checkRight
        cmp airplanePos.x, MarginSize ; If airplanePos.x is at the left edge of the screen, do not move right
        jle checkRight
        sub airplanePos.x, 2
        jmp checkShoot

    checkRight:
        INVOKE GetAsyncKeyState, VK_RIGHT
        test ax, 8000h
        jz checkShoot
        cmp airplanePos.x, ScreenWidth - MarginSize - 10; If airplanePos.x is at the right edge of the screen, do not move right
        jge checkShoot
        add airplanePos.x, 2
        jmp checkShoot
		
		
		
	checkShoot:
        INVOKE GetAsyncKeyState, VK_SPACE
        test ax, 8000h
        jz updateBullet
        mov bx, airplanePos.x
        add bx, 5 ; Adjust bullet position x
        mov bulletPos.x, bx
        mov bx, airplanePos.y
        sub bx, 3 ; Adjust bullet position y
        mov bulletPos.y, bx
        dec bulletPos.y

    updateBullet:
        ; Update bullet position
        cmp bulletPos.y, 0
        je endUpdate
        dec bulletPos.y
    endUpdate:

        ; Delay for a short period
        INVOKE Sleep, 50
		
	checkGetBomb:    
        cmp bombPos.y, ScreenHeight-5 
        jl checkGetBomb2 
		mov ax, airplanePos.x
        sub ax, 1
        cmp bombPos.x, ax 
        jl checkGetBomb2 ; skip
        mov ax, airplanePos.x
        add ax, 10
        cmp bombPos.x, ax 
        jg checkGetBomb2 ; skip
        sub life,2   ; If no skip, then collision happen
		cmp flagBomb,7
		jge resetBombFlag3
		movzx ebx ,flagBomb
		shl ebx, 1  ;mul by 2
		mov esi, OFFSET dropBombPos
		inc flagBomb 
		mov ax,[esi+ebx]
		mov bombPos.x, ax 
		mov bombPos.y, 5  
		
		jmp checkGetBomb2   
		
		resetBombFlag3:
			mov flagBomb,0
			mov bombPos.x, 54
			mov bombPos.y, 5 
			
	checkGetBomb2:    
        cmp bombPos2.y, ScreenHeight-5 
        jl checkGetAddLife 
		mov ax, airplanePos.x
        sub ax, 1
        cmp bombPos2.x, ax 
        jl checkGetAddLife ; skip
        mov ax, airplanePos.x
        add ax, 10
        cmp bombPos2.x, ax 
        jg checkGetAddLife ; skip
        dec life   ; If no skip, then collision happen
		cmp flagBomb2,7
		jge resetBombFlag4
		movzx ebx ,flagBomb2
		shl ebx, 1  ;mul by 2
		mov esi, OFFSET dropBombPos2
		inc flagBomb2 
		mov ax,[esi+ebx]
		mov bombPos2.x, ax 
		mov bombPos2.y, 5  
		
		jmp checkGetAddLife   
		
		resetBombFlag4:
			mov flagBomb2,0
			mov bombPos2.x,77
			mov bombPos2.y, 5 
	
   
    checkGetAddLife:    
        cmp addLifePos.y, ScreenHeight-5 
        jl checkEnemyCollision1 
		mov ax, airplanePos.x
        sub ax, 1
        cmp addLifePos.x, ax 
        jl checkEnemyCollision1 ; skip
        mov ax, airplanePos.x
        add ax, 10
        cmp addLifePos.x, ax 
        jg checkEnemyCollision1 ; skip
		cmp life,3
		jge checkEnemyCollision1 
        inc life    ; If no skip, then collision happen
		cmp flag,7
		jge resetFlag2
		movzx ebx ,flag
		shl ebx, 1  ;mul by 2
		mov esi, OFFSET dropPos
		inc flag 
		mov ax,[esi+ebx]
		mov addLifePos.x, ax 
		mov addLifePos.y, 5  
		
		jmp checkEnemyCollision1   
		
		resetFlag2:
			mov flag,0
			mov cx,dropPos
			mov addLifePos.x, cx
			mov addLifePos.y, 5 
	
	; Check if airplane is shot
    checkEnemyCollision1:    
        cmp enemyActive1, 0 ; If equal, enemy1 already died
        je checkEnemyCollision2
       cmp enemyBulletPos1.y, ScreenHeight-5 ; Check1: enemyBullet.y and plane.y
        jl checkEnemyCollision2 ; Bullet still up in sky, skip
        mov ax, airplanePos.x
        sub ax, 1
        cmp enemyBulletPos1.x, ax ; Check2: enemyBullet.x is between the range of plane.x
        jl checkEnemyCollision2 ; skip
        mov ax, airplanePos.x
        add ax, 10
        cmp enemyBulletPos1.x, ax ; Check3: enemyBullet.x is between the range of plane.x
        jg checkEnemyCollision2 ; skip
        dec life    ; If no skip, then collision happen
        mov enemyBulletPos1.x, 30 ; Reset enemyBullet1 position
        mov enemyBulletPos1.y, 5
  

    checkEnemyCollision2:
    cmp enemyActive2, 0 ; If equal, enemy2 already died
        je checkEnemyCollision3
        cmp enemyBulletPos2.y, ScreenHeight-5 ; Check1: enemyBullet.y and plane.y
        jl checkEnemyCollision3 ; Bullet still up in sky, skip
        mov ax, airplanePos.x
        sub ax, 1
        cmp enemyBulletPos2.x, ax ; Check2: enemyBullet.x is between the range of plane.x
        jl checkEnemyCollision3 ; skip
        mov ax, airplanePos.x
        add ax, 10
        cmp enemyBulletPos2.x, ax ; Check3: enemyBullet.x is between the range of plane.x
        jg checkEnemyCollision3 ; skip
        dec life    ; If no skip, then collision happen
        mov enemyBulletPos2.x, 50 ; Reset enemyBullet2 position
        mov enemyBulletPos2.y, 5

    checkEnemyCollision3:
    cmp enemyActive3, 0 ; If equal, enemy3 already died
        je checkEnemyCollision4
        cmp enemyBulletPos3.y, ScreenHeight-5 ; Check1: enemyBullet.y and plane.y
        jl checkEnemyCollision4 ; Bullet still up in sky, skip
        mov ax, airplanePos.x
        sub ax, 1
        cmp enemyBulletPos3.x, ax ; Check2: enemyBullet.x is between the range of plane.x
        jl checkEnemyCollision4 ; skip
        mov ax, airplanePos.x
        add ax, 10
        cmp enemyBulletPos3.x, ax ; Check3: enemyBullet.x is between the range of plane.x
        jg checkEnemyCollision4 ; skip
        dec life    ; If no skip, then collision happen
        mov enemyBulletPos3.x, 80 ; Reset enemyBullet3 position
        mov enemyBulletPos3.y, 5

    checkEnemyCollision4:
    cmp enemyActive4, 0 ; If equal, enemy4 already died
        je endEnemyCollision
        cmp enemyBulletPos4.y, ScreenHeight-5 ; Check1: enemyBullet.y and plane.y
        jl endEnemyCollision ; Bullet still up in sky, skip
        mov ax, airplanePos.x
        sub ax, 1
        cmp enemyBulletPos4.x, ax ; Check2: enemyBullet.x is between the range of plane.x
        jl endEnemyCollision ; skip
        mov ax, airplanePos.x
        add ax, 10
        cmp enemyBulletPos4.x, ax ; Check3: enemyBullet.x is between the range of plane.x
        jg endEnemyCollision ; skip
        dec life    ; If no skip, then collision happen
        mov enemyBulletPos4.x, 100 ; Reset enemyBullet4 position
        mov enemyBulletPos4.y, 5
    endEnemyCollision:
              
    
    ;Check if enemy1 is shot
    checkBulletCollision1:
        cmp bulletPos.y, 5 ; If bullet is at the top of the screen, skip
        jne checkBulletCollision2
        mov ecx,8
		mov ax, enemyPos1.x
		L1:
			cmp bulletPos.x, ax ; Check1: bullet.x and enemy.x
			je bulletHitEnemy1 ; skip
			inc ax
			loop L1
			jmp checkBulletCollision2
		bulletHitEnemy1:
			mov enemyActive1, 0 ; If no skip, then collision happen, enemy2 died
			mov bulletPos.y, 0 ; Reset bullet position
			jmp checkBulletCollision2

    ; Check if enemy2 is shot
    checkBulletCollision2:
        cmp bulletPos.y, 5 ; If bullet is at the top of the screen, skip
        jne checkBulletCollision3
		mov ecx,9
		mov ax, enemyPos2.x
		L2:
			cmp bulletPos.x, ax ; Check1: bullet.x and enemy.x
			je bulletHitEnemy2 ; skip
			inc ax
			loop L2
			jmp checkBulletCollision3
		bulletHitEnemy2:
			mov enemyActive2, 0 ; If no skip, then collision happen, enemy2 died
			mov bulletPos.y, 0 ; Reset bullet position
			jmp checkBulletCollision3

    ; Check if enemy3 is shot
    checkBulletCollision3:
        cmp bulletPos.y, 5 ; If bullet is at the top of the screen, skip
        jne checkBulletCollision4
        mov ecx,8
		mov ax, enemyPos3.x
		L3:
			cmp bulletPos.x, ax ; Check1: bullet.x and enemy.x
			je bulletHitEnemy3 ; skip
			inc ax
			loop L3
			jmp checkBulletCollision4
		bulletHitEnemy3:
			mov enemyActive3, 0 ; If no skip, then collision happen, enemy2 died
			mov bulletPos.y, 0 ; Reset bullet position
			jmp checkBulletCollision4
     
    ; Check if enemy4 is shot
    checkBulletCollision4:
        cmp bulletPos.y, 5 ; If bullet is at the top of the screen, skip
        jne endBulletCollision
        mov ecx,8
		mov ax, enemyPos4.x
		L4:
			cmp bulletPos.x, ax ; Check1: bullet.x and enemy.x
			je bulletHitEnemy4 ; skip
			inc ax
			loop L4
			jmp endBulletCollision
		bulletHitEnemy4:
			mov enemyActive4, 0 ; If no skip, then collision happen, enemy2 died
			mov bulletPos.y, 0 ; Reset bullet position
			jmp endBulletCollision
    endBulletCollision:

     ; If lose
    lose:
        cmp life, 0
        jne checkWin
        ;;;TODO DRAW LOSE;;;
        call Clrscr
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR loseDraw1, LENGTHOF loseDraw1, losePos, ADDR count
        inc losePos.y
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR loseDraw2, LENGTHOF loseDraw2, losePos, ADDR count
        inc losePos.y
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR loseDraw3, LENGTHOF loseDraw3, losePos, ADDR count
        inc losePos.y
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR loseDraw4, LENGTHOF loseDraw4, losePos, ADDR count
        inc losePos.y
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR loseDraw5, LENGTHOF loseDraw5, losePos, ADDR count
        INVOKE sleep, 5000
        jmp exitGame


    ; If win
    checkWin:
        mov al, enemyActive1
        or al, enemyActive2
        or al, enemyActive3
        or al, enemyActive4
        cmp al,0
        jne gameLoop
   
        ; Draw "WIN!"
        call Clrscr
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR winDraw1, LENGTHOF winDraw1, winPos, ADDR count
        inc winPos.y
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR winDraw2, LENGTHOF winDraw2, winPos, ADDR count
        inc winPos.y
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR winDraw3, LENGTHOF winDraw3, winPos, ADDR count
        inc winPos.y
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR winDraw4, LENGTHOF winDraw4, winPos, ADDR count
        inc winPos.y
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR winDraw5, LENGTHOF winDraw5, winPos, ADDR count      
        INVOKE Sleep, 5000
        jmp exitGame
   
    exitGame:
        exit

main ENDP

END main

