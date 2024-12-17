INCLUDE Irvine32.inc

.data
; Define BoxSize
BoxWidth = 5
BoxHeight = 5
ScreenWidth = 100
ScreenHeight = 25

; Define game objects
airplaneTop BYTE ' ', ' ','A',0
airplaneMid1 BYTE  ' ', '/',' ','\\',0
airplaneMid2 BYTE  ' ', '|','_','|',0
airplaneBot BYTE '/',' ',' ',' ','\\',0

bullet BYTE '^'
enemy BYTE 'O'

;define attributes
airplaneAttr BYTE 0Fh

; Define positions
initialAirplanePos COORD <ScreenWidth / 2, ScreenHeight - 2>
airplanePos COORD <ScreenWidth / 2, ScreenHeight - 2>
bulletPos COORD <0, 0>
enemyPos COORD <ScreenWidth / 2, 1>
initialLifePos COORD <ScreenWidth - 10, 0>
lifePos COORD <ScreenWidth - 10, 0>

; Define others
outputHandle DWORD 0
bytesWritten DWORD 0
count DWORD 0
key DWORD ?
randomX DWORD ?

; Define scores and lives
score DWORD 0
life DWORD 3
lifeSymbol BYTE 03h,0




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
       mov ax, initialLifePos.x
       mov lifePos.x, ax
       mov ax, initialLifePos.y
       mov lifePos.y, ax

       mov ecx, life ; set loop counter
       drawLifeLoop:              
       INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR lifeSymbol, 1, lifePos, ADDR count
       inc lifePos.x
       loop drawLifeLoop

       

       ; Draw airplane
        INVOKE WriteConsoleOutputCharacter,
        outputHandle, ADDR airplaneBot, 5, airplanePos, ADDR count
        dec airplanePos.y

        INVOKE WriteConsoleOutputCharacter,
        outputHandle, ADDR airplaneMid2, 4, airplanePos, ADDR count
        dec airplanePos.y

        INVOKE WriteConsoleOutputCharacter,
        outputHandle, ADDR airplaneMid1, 4, airplanePos, ADDR count
        dec airplanePos.y

        INVOKE WriteConsoleOutputCharacter,
        outputHandle, ADDR airplaneTop, 3, airplanePos, ADDR count
        dec airplanePos.y

        add airplanePos.y, 4
        
        ; Draw bullet if active
        cmp bulletPos.y, 0
        je skipBullet
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR bullet, 1, bulletPos, ADDR count
        skipBullet:

        ; Draw enemy
        INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR enemy, 1, enemyPos, ADDR count

        ; Handle input
        INVOKE GetAsyncKeyState, VK_LEFT
        test ax, 8000h
        jz checkRight
        dec airplanePos.x
        jmp checkShoot

        checkRight:
        INVOKE GetAsyncKeyState, VK_RIGHT
        test ax, 8000h
        jz checkShoot
        inc airplanePos.x
        jmp checkShoot

        checkShoot:
        INVOKE GetAsyncKeyState, VK_SPACE
        test ax, 8000h
        jz updateBullet
        mov bx, airplanePos.x
        add bx,2 ; Adjust bullet position x
        mov bulletPos.x, bx
        mov bx, airplanePos.y
        sub bx, 2 ; Adjust bullet position y
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

        ; Check for collision with enemy
        mov bx, bulletPos.x
        cmp bx, enemyPos.x
        jne gameLoop
        mov bx, bulletPos.y
        cmp bx, enemyPos.y
        jne gameLoop

        ; If collision, reset enemy position with random x
        mov ax, ScreenWidth
        INVOKE RandomRange
        mov enemyPos.x, ax
        mov enemyPos.y, 1

        jmp gameLoop

    exit
main ENDP
END main
