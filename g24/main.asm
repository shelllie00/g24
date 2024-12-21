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
enemy1 BYTE 'E'
enemyBullet1 BYTE 'o'
enemy2 BYTE 'E'
enemyBullet2 BYTE 'o'
enemy3 BYTE 'E'
enemyBullet3 BYTE 'o'
enemy4 BYTE 'E'
enemyBullet4 BYTE 'o'
; Define enemy positions and bullets
enemyPos1 COORD <30, 5>
enemyBulletPos1 COORD <30, 5>
enemyPos2 COORD <50, 5>
enemyBulletPos2 COORD <50, 5>
enemyPos3 COORD <90, 5>
enemyBulletPos3 COORD <90, 5>
enemyPos4 COORD <110, 5>
enemyBulletPos4 COORD <110, 5>
enemyActive1 BYTE 1
enemyActive2 BYTE 1
enemyActive3 BYTE 1
enemyActive4 BYTE 1

; Define others
outputHandle DWORD 0
bytesWritten DWORD 0
count DWORD 0
key DWORD ?
randomX DWORD ?

; Define scores and lives
score DWORD 0
life DWORD 3
lifeSymbol1 BYTE 03h,0
lifeSymbol2 BYTE 03h, 03h, 0
lifeSymbol3 BYTE 03h, 03h, 03h, 0
lifePos COORD <5, 3>

; Define words
gameOverMsg BYTE "Game Over", 0

.code
SetConsoleOutputCP PROTO STDCALL :DWORD
GetAsyncKeyState PROTO STDCALL :DWORD

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

        ; Draw life
        cmp life, 3
        je drawlife3
        cmp life, 2
        je drawlife2
        cmp life, 1
        je drawlife1

    ; Draw life
    drawlife3:
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR lifeSymbol3, 3, lifePos, ADDR count
        jmp drawAirplane
    drawlife2:
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR lifeSymbol2, 2, lifePos, ADDR count
        jmp drawAirplane
    drawlife1:
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR lifeSymbol1, 1, lifePos, ADDR count
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
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemy1, 1, enemyPos1, ADDR count
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
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemy2, 1, enemyPos2, ADDR count
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
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemy3, 1, enemyPos3, ADDR count
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyBullet3, 1, enemyBulletPos3, ADDR count
        cmp enemyBulletPos3.y, ScreenHeight-5 ; Check if enemy bullet is at the bottom of the screen
        jle bulletdrop3
        mov enemyBulletPos3.x, 90 ; Reset enemyBullet3 position
        mov enemyBulletPos3.y, 5
        jmp drawEnemy4
        bulletdrop3:
        inc enemyBulletPos3.y ; Bullet drop

    drawEnemy4:
        cmp enemyActive4, 0 ; Check if enemy is active
        je endDrawEnemies
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemy4, 1, enemyPos4, ADDR count
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemyBullet4, 1, enemyBulletPos4, ADDR count
        cmp enemyBulletPos4.y, ScreenHeight-5 ; Check if enemy bullet is at the bottom of the screen
        jle bulletdrop4
        mov enemyBulletPos4.x, 110 ; Reset enemyBullet4 position
        mov enemyBulletPos4.y, 5
        jmp endDrawEnemies
        bulletdrop4:
        inc enemyBulletPos4.y ; Bullet drop

    endDrawEnemies:

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
        cmp airplanePos.x, ScreenWidth - MarginSize ; If airplanePos.x is at the right edge of the screen, do not move right
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
        mov enemyBulletPos3.x, 90 ; Reset enemyBullet3 position
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
        mov enemyBulletPos4.x, 110 ; Reset enemyBullet4 position
        mov enemyBulletPos4.y, 5
    endEnemyCollision:
              
    
    ;Check if enemy1 is shot
    checkBulletCollision1:
        cmp bulletPos.y, 5 ; If bullet is at the top of the screen, skip
        jne checkBulletCollision2
        mov ax, enemyPos1.x
        cmp bulletPos.x, ax ; Check1: bullet.x and enemy.x
        jne checkBulletCollision2 ; skip        
        mov enemyActive1, 0 ; If no skip, then collision happen, enemy1 died
        mov bulletPos.y, 0 ; Reset bullet position
        jmp checkBulletCollision2

    ; Check if enemy2 is shot
    checkBulletCollision2:
        cmp bulletPos.y, 5 ; If bullet is at the top of the screen, skip
        jne checkBulletCollision3
        mov ax, enemyPos2.x
        cmp bulletPos.x, ax ; Check1: bullet.x and enemy.x
        jne checkBulletCollision3 ; skip
        mov enemyActive2, 0 ; If no skip, then collision happen, enemy2 died
        mov bulletPos.y, 0 ; Reset bullet position
        jmp checkBulletCollision3
        
    ; Check if enemy3 is shot
    checkBulletCollision3:
        cmp bulletPos.y, 5 ; If bullet is at the top of the screen, skip
        jne checkBulletCollision4
        mov ax, enemyPos3.x
        cmp bulletPos.x, ax ; Check1: bullet.x and enemy.x
        jne checkBulletCollision4 ; skip
        mov enemyActive3, 0 ; If no skip, then collision happen, enemy3 died
        mov bulletPos.y, 0 ; Reset bullet position
        jmp checkBulletCollision4
     
    ; Check if enemy4 is shot
    checkBulletCollision4:
        cmp bulletPos.y, 5 ; If bullet is at the top of the screen, skip
        jne endBulletCollision
        mov ax, enemyPos4.x
        cmp bulletPos.x, ax ; Check1: bullet.x and enemy.x
        jne endBulletCollision ; skip
        mov enemyActive4, 0 ; If no skip, then collision happen, enemy4 died
        mov bulletPos.y, 0 ; Reset bullet position
        jmp endBulletCollision
    endBulletCollision:






        ; If life is 0, end the game
        cmp life, 0
        jne gameLoop

    endGame:
        ; Display game over message
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR GameOverMsg, 5, lifePos, ADDR count
        INVOKE Sleep, 50
        
        
        exit
main ENDP
END main
