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


;Blueprint to draw a bigger plane (not yet used, maybe used in next chapter?)
;airplaneBiggerDraw1 BYTE ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','/',5ch,0
;airplaneBiggerDraw2 BYTE ' ','_','_','_','_','_','_','_','_','_','_','/',' ',' ',5ch,'_','_','_','_','_','_','_','_','_','_',0
;airplaneBiggerDraw3 BYTE '/','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_','_',5ch,0
;airplaneBiggerDraw4 BYTE ' ',' ',' ','_','_','|','_','_','|','_','/','.','-','-','.',5ch,'_','|','_','_','|','_','_',' ',' ',' ',' ',' ',' ',' ',0
;airplaneBiggerDraw5 BYTE ' ',' ','/','_','_','|','_','|','_','_','(',' ', '>', '<', ' ',')','_','_','|','_','|','_','_',5ch,' ',' ',' ',' ',' ',' ',0
;airplaneBiggerDraw6 BYTE ' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','_','/','-','-',5ch,'_',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',0
;airplaneBiggerDraw7 BYTE ' ',' ',' ',' ',' ',' ',' ',' ',' ','(','/','-','-','-','-',5ch,')',' ',' ',' ',' ',' ',' ',' ',' ',0

bullet BYTE '**'
enemy BYTE 'O'


; Define positions
initialAirplanePos COORD <ScreenWidth / 2, ScreenHeight - 2>
airplanePos COORD <ScreenWidth / 2, ScreenHeight - 2>
bulletPos COORD <0, 0>
enemyPos COORD <ScreenWidth / 2, 1>
lifePos COORD <5, 5>

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

       drawlife3:
       INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR lifeSymbol3, 3, lifePos, ADDR count
       jmp drawScore

       drawlife2:
       INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR lifeSymbol2, 2, lifePos, ADDR count
       jmp drawScore

       drawlife1:
       INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR lifeSymbol1, 1, lifePos, ADDR count
       jmp drawScore

       drawScore:
       ;;;TODO;;
       
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

        add airplanePos.y,5; Add back 5 to airplanePos.y
        
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
        add airplanePos.x,2
        jmp checkShoot


        checkShoot:
        INVOKE GetAsyncKeyState, VK_SPACE
        test ax, 8000h
        jz updateBullet
        mov bx, airplanePos.x
        add bx,5 ; Adjust bullet position x
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

        ; Check for collision with enemy
        mov bx, bulletPos.x
        cmp bx, enemyPos.x
        jne gameLoop
        mov bx, bulletPos.y
        cmp bx, enemyPos.y
        jne gameLoop

        ; If collision, reset enemy position with random x
        mov ax, ScreenWidth
        sub ax, 10 ; RandomRange will generate a number between 0 and the value in ax(i.e. ScreenWidth - 10) and store back in ax
        INVOKE RandomRange
        mov enemyPos.x, ax
        mov enemyPos.y, 1

        jmp gameLoop

    exit
main ENDP
END main
