.model small
.data
    
    x db 110,110,109,109,108,106,105,103,100,98,95,92,89,86,83,79,75,72,68,64,60,56,52,48,45,41,37,34,31,28,25,22,20,17,15,14,12,11,11,10,10,10,11,11,12,14,15,17,20,22,25,28,31,34,37,41,45,48,52,56,60,64,68,72,75,79,83,86,89,92,95,98,100,103,105,106,108,109,109,110,110
    y db 60,64,68,72,75,79,83,86,89,92,95,98,100,103,105,106,108,109,109,110,110,110,109,109,108,106,105,103,100,98,95,92,89,86,83,79,75,72,68,64,60,56,52,48,45,41,37,34,31,28,25,22,20,17,15,14,12,11,11,10,10,10,11,11,12,14,15,17,20,22,25,28,31,34,37,41,45,48,52,56,60
    
    color equ 0Ah
    
    coordx db ?
    coordy db ? 
    
    r equ 50
    
.code

pixel macro x,y,color
    mov cl,x            ; cl = x
    add cl,coordx       ; cl = coordx
    add cl,r
    
    mov dl,y            ; dl = y
    add dl,coordy       ; dl = coordy
    
    mov al,color        ; al = 0Ah
    mov ah,0Ch          ; ah = 0Ch
    
    int 10h
endm    

inicio:
    lea ax,data
    mov ds,ax
     
    ;Establecer el modo de video
    mov ah,0       ; ah = 0
    mov al,13h     ; al = 13h
    int 10h    
    
    ;Activar el mouse
    mov ax, 0      ; ax = 0
    int 33h 

mouse:      
    mov ax,3
    int 33h
    shr cx,1       ; x/2 -> en este modo el valor de x es doble 
    
    test bx,1      ; click izquierdo -> 1
    jz mouse       ; si no es click izquierdo
    
    mov al,0Fh     ; al = 0fh
    mov ah,0Ch     ; ah = 0Ch

    int 10h
      
    mov al,cl  ; (x) del click  
    sub al,x[0]    ; al = al - x[0]
    mov coordx,al
    
    
    mov cl,dl  ; (y) del click
    sub cl,y[0]    ; cl = cl - y[0] 
    mov coordy,cl
    
    mov bx,0       ; bx = 0
    
punto:           
    pixel x[bx],y[bx],color
    
    inc bx         ; bx = bx + 1
    cmp bx,80      ; flags = bx - 80
    jne punto      ; jnz punto
      
    mov ah,4Ch     ; ah = 04Ch
    int 21h
    
    ret



