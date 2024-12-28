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
enemyShape2draw3 BYTE '| -   - |', 0
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


;Define "PRESS TO START"
startPos COORD <50,20>
startMessage1 BYTE '+','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','+',0  ; Start message with '+' and '-'
startMessage2 BYTE '|',' ','P','R','E','S','S',' ','T','O',' ','S','T','A','R','T',' ','|',0  ; Press to start message

;Define enemy for start scene
startEnemyPos COORD <43,12>
startEnemyfacePos COORD <43,9>
startEnemy1 BYTE '           @      @',0
startEnemy2 BYTE '   / \     { _____}      / \',0    
startEnemy3 BYTE ' /  |  \___/*******\___/  |  \   ',0   
startEnemy4 BYTE '(   I  /   ~   -   ~   \  I   )',0  
startEnemyface1 BYTE ' \  |  |   0       0   |  |  /',0  
startEnemy6 BYTE '   \   |       A       |   /',0     
startEnemy7 BYTE '     \__    _______    __/',0       
startEnemy8 BYTE '        \_____________/ ',0    
startEnemyface2 BYTE ' \  |  |   >       <   |  |  /',0  

;Define boundary
boundary BYTE '||'
boundaryPosLeft COORD <13, 0>
boundaryPosRight COORD <0 , 0>
boundaryDrawn BYTE 0

;addLife
addLife BYTE '$'  ;green
addLifePos COORD <25 , 5>  
addLifeColor WORD 0A9h     
dropAddLifePos WORD 33,85,112,78,90,35,110,17
addLifeFlag WORD 0

;bomb (minus 2 life)
bomb BYTE '#'
bombPos COORD <77 , 5>  
bombColor WORD 0C9h     ;red
dropBombPos WORD 66,44,99,41,32,28,100,50
bombFlag WORD 0


; Define "WIN!" 
winPos COORD <46,10>
winDraw1 BYTE '_','_',' ',' ',' ',' ',' ',' ',' ',' ','_','_','_','_','_',' ','_',' ',' ',' ','_',' ',' ',' ','_',0 
winDraw2 BYTE 5ch,' ',5ch,' ',' ',' ',' ',' ',' ','/',' ','/','_',' ','_',7ch,' ',5ch,' ',7ch,' ',7ch,' ',7ch,' ',7ch,0
winDraw3 BYTE ' ',5ch,' ',5ch,' ','/',5ch,' ','/',' ','/',' ',7ch,' ',7ch,7ch,' ',' ',5ch,7ch,' ',7ch,' ',7ch,' ',7ch,0
winDraw4 BYTE ' ',' ',5ch,' ','V',' ',' ','V',' ','/',' ',' ',7ch,' ',7ch,7ch,' ',7ch,5ch,' ',' ',7ch,' ',7ch,'_',7ch,0
winDraw5 BYTE ' ',' ',' ',5ch,'_','/',5ch,'_','/',' ',' ',7ch,'_','_','_',7ch,'_',7ch,' ',5ch,'_',7ch,' ','(','_',')',0

; Define "LOSE"
losePos COORD <47,10>
loseDraw1 BYTE ' ','_',' ',' ',' ',' ',' ','_','_','_',' ',' ','_','_','_','_',' ',' ','_','_','_','_','_',' ',' ',' ','_',' ',0
loseDraw2 BYTE '|',' ',7ch,' ',' ',' ','/',' ','_',' ',5ch,'/',' ','_','_','_',7ch,7ch,' ','_','_','_','_',7ch,' ',7ch,' ',7ch,0
loseDraw3 BYTE '|',' ',7ch,' ',' ',7ch,' ',7ch,' ',7ch,' ',5ch,'_','_','_',' ',5ch,7ch,' ',' ','_',7ch,' ',' ',' ',7ch,' ',7ch,0
loseDraw4 BYTE '|',' ',7ch,'_','_',7ch,' ',7ch,'_',7ch,' ',7ch,'_','_','_',')',' ',7ch,' ',7ch,'_','_','_',' ',' ',7ch,'_',7ch,0
loseDraw5 BYTE '|','_','_','_','_','_',5ch,'_','_','_','/',7ch,'_','_','_','_','/',7ch,'_','_','_','_','_',7ch,' ','(','_',')',0


; Define play again or not
continueDraw BYTE 'PRESS SPACE TO CONTINUE ', 0
retryDraw BYTE 'PRESS ENTER TO PLAY AGAIN ', 0

TextContinuePos COORD <50, 25>     
TextRetryPos COORD <48, 27> 

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
    againLoop:
    
    mov enemyActive1,1
    mov enemyActive2,1
    mov enemyActive3,1
    mov enemyActive4,1


    continuePlay:
    mov life,3
    ; Initialize console
    INVOKE SetConsoleOutputCP, 65001 ; Set console output to UTF-8
    INVOKE GetStdHandle, STD_OUTPUT_HANDLE
    mov outputHandle, eax
    call Clrscr
	

    ; Draw Start Message
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR startMessage1, LENGTHOF startMessage1, startPos, ADDR count
		dec startPos.y
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR startMessage2, LENGTHOF startMessage2, startPos, ADDR count
		dec startPos.y
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR startMessage1, LENGTHOF startMessage1, startPos, ADDR count
		dec startPos.y
		add startPos.y, 3

    ;Draw enemypic
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR startEnemy8, LENGTHOF startEnemy8, startEnemyPos, ADDR count
		dec startEnemyPos.y
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR startEnemy7, LENGTHOF startEnemy7, startEnemyPos, ADDR count
		dec startEnemyPos.y
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR startEnemy6, LENGTHOF startEnemy6, startEnemyPos, ADDR count
		dec startEnemyPos.y
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR startEnemyface1, LENGTHOF startEnemyface1, startEnemyPos, ADDR count
		dec startEnemyPos.y
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR startEnemy4, LENGTHOF startEnemy4, startEnemyPos, ADDR count
		dec startEnemyPos.y
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR startEnemy3, LENGTHOF startEnemy3, startEnemyPos, ADDR count
		dec startEnemyPos.y
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR startEnemy2, LENGTHOF startEnemy2, startEnemyPos, ADDR count
		dec startEnemyPos.y
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR startEnemy1, LENGTHOF startEnemy1, startEnemyPos, ADDR count
        dec startEnemyPos.y
		add startEnemyPos.y, 8



        WaitForStart:
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR startEnemyface1, LENGTHOF startEnemyface1, startEnemyfacePos, ADDR count

        ; Get current time-stamp counter value
        rdtsc               ; edx:eax = time-stamp counter
        
        mov ecx, 500        ; Load divisor (5) into ecx
        xor edx, edx        ; Clear edx (required for division)
        div ecx             ; eax = eax / 5, edx = eax % 5 (remainder)

        cmp edx, 0          ; Compare remainder (edx) with 0
        jne continue
        
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR startEnemyface2, LENGTHOF startEnemyface2, startEnemyfacePos, ADDR count
        INVOKE Sleep, 250
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR startEnemyface1, LENGTHOF startEnemyface1, startEnemyfacePos, ADDR count
        INVOKE Sleep, 500

        continue:
        ;keep waiting for press to start 
        ; Wait for player to press space to start
        INVOKE GetAsyncKeyState, VK_SPACE ; Check if any key is pressed 
        test ax, 8000h              ; Test if the high bit is set (meaning key is pressed)
        jz WaitForStart


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
	drawAddLife:
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR addLife, 1, addLifePos, ADDR count
		INVOKE WriteConsoleOutputAttribute, outputHandle, ADDR addLifeColor, 1, addLifePos, ADDR count
		cmp addLifePos.y, ScreenHeight-5 
		jle addingLifeDrop

    setNewAddLifePos:
		movzx ebx ,addLifeFlag
		shl ebx, 1  ;mul by 2 
		mov esi, OFFSET dropAddLifePos
		inc addLifeFlag
		mov ax,[esi+ebx]    ; Ax value is the next pos
		mov addLifePos.x, ax  ; Reset the addLife pos.x
		mov addLifePos.y, 5      ; Start at the top of the screen        
		
	addingLifeDrop:
		inc addLifePos.y ; drop 
		
    checkAddLifeFlag:
        cmp addLifeFlag,7
		jl endDrawAddLife
		
		resetAddLifeFlag:
			mov addLifeFlag,0
			;mov addLifePos.x, 25    
			;mov addLifePos.y, 5      ; Start at the top of the screen
			jmp EndDrawAddLife      
		
	EndDrawAddLife:
	
	; Draw bomb
	BombDraw:
		INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR bomb, 1, bombPos, ADDR count
		INVOKE WriteConsoleOutputAttribute, outputHandle, ADDR bombColor, 1, bombPos, ADDR count
		cmp bombPos.y, ScreenHeight-5 
		jle bombDrop

    setNewBombPos:
		movzx ebx ,bombFlag
		shl ebx, 1  ;mul by 2
		mov esi, OFFSET dropBombPos
		inc bombFlag 
		mov ax,[esi+ebx]
		mov bombPos.x, ax 
		mov bombPos.y, 5      ; Start at the top of the screen
		
	bombDrop:
		inc bombPos.y ; drop 

    checkBombFlag:
        cmp bombFlag,7
        jl endBombDraw
		
		resetBombFlag:
			mov bombFlag,0
			;mov bombPos.x, 77   
			;mov bombPos.y, 5      ; Start at the top of the screen
			jmp EndBombDraw
		
	EndBombDraw:
	
	
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
		
    ; Check if plane hit bomb
	checkGetBomb:    
        cmp bombPos.y, ScreenHeight-5 
        jl checkGetAddLife  ;skip
		mov ax, airplanePos.x
        sub ax, 1
        cmp bombPos.x, ax 
        jl checkGetAddLife ; skip
        mov ax, airplanePos.x
        add ax, 10
        cmp bombPos.x, ax 
        jg checkGetAddLife ; skip
        sub life,2   
        cmp life,0
        jge skipSetLifeZero
        mov life,0

    skipSetLifeZero:
		cmp bombFlag,7
		jge resetBombFlag3
		movzx ebx ,bombFlag
		shl ebx, 1  ;mul by 2
		mov esi, OFFSET dropBombPos
		inc bombFlag 
		mov ax,[esi+ebx]
		mov bombPos.x, ax 
		mov bombPos.y, 5  
		
		jmp checkGetAddLife
		
		resetBombFlag3:
			mov bombFlag,0
			;mov bombPos.x, 54
			;mov bombPos.y, 5 
			
   
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
        inc life
        cmp life,3
        jle skipSetLifeThree
        mov life,3

    skipSetLifeThree:
		cmp addLifeFlag,7
		jge resetFlag2
		movzx ebx ,addLifeFlag
		shl ebx, 1  ;mul by 2
		mov esi, OFFSET dropAddLifePos
		inc addLifeFlag
		mov ax,[esi+ebx]
		mov addLifePos.x, ax 
		mov addLifePos.y, 5  
		
		jmp checkEnemyCollision1   
		
		resetFlag2:
			mov addLifeFlag,0
			;mov cx,dropAddLifePos
			;mov addLifePos.x, cx
			;mov addLifePos.y, 5 
	
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
        ; Draw LOSE
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
        sub losePos.y, 4
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR retryDraw, LENGTHOF retryDraw, TextRetryPos, ADDR count
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR continueDraw, LENGTHOF continueDraw, TextContinuePos, ADDR count


        waitLoop:
				; 檢查是否按下enter
				INVOKE GetAsyncKeyState, VK_RETURN  
				test eax, 8000h                     
				jnz skipSleep                     

                INVOKE GetAsyncKeyState, VK_SPACE
				test eax, 8000h                     
				jnz continuePlay      

				; 如果沒有按鍵，則執行睡眠
				INVOKE Sleep, 100                 
				sub ecx, 10000                        
				jz exitGame                      
				jnz waitLoop   
        jmp exitGame


    ; If win
    checkWin:
        ; Are all enemies died
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
        sub winPos.y, 4

        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR retryDraw, LENGTHOF retryDraw, TextRetryPos, ADDR count

        waitLoop2:
				; 檢查是否按下enter
				INVOKE GetAsyncKeyState, VK_RETURN  
				test eax, 8000h                     
				jnz skipSleep                     

				; 如果沒有按鍵，則執行睡眠
				INVOKE Sleep, 100                 
				;sub ecx, 10000       ; 減少剩餘時間
				jz exitGame                      
				jnz waitLoop   
        ;jmp exitGame
   

   skipSleep:
			jmp againLoop
            
    exitGame:
        exit

main ENDP

END main

