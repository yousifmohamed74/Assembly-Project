;This Is An Assembly Project To Convert Betwen (CM, Metre ,KM )  
;Team 43 

.model small
.stack 

.data

 cm dw 0
 metre dw 0
 km dw 0
 
 num1 db 0
 num2 dw 0
 totalnum dw ?
 
 msg0 db  0Ah,"wrong input ", 0Ah, "$"
 msg1 db "To convert From Cm To Metre Press A" , 0Ah, "$"
 msg3 db "To convert From Metre To Cm Press C " , 0Ah, "$" 
 msg4 db "To convert From Metre To KM Press D " , 0Ah, "$"
 msg6 db "To convert From KM To Metre Press F " , 0Ah, "$"
 msg7 db  0Ah,"Ok Enter Your Value in two digits ", 0Ah, "$" 
 resultmsg db 0Ah,"Result= $" ;0Ah to set new line
 result dw ?  ; value in ax
 reminder dw ? ; value in dx

.code
    main proc far
start:    
    .startup
 ;;;;;;;;;;;;;;;;;;;;;print defult msgs;;;;;;;;;;;;;;;;;;;;;;
        lea dx,msg1
        call printmsg
        
        lea dx,msg3
        call printmsg
       
        lea dx,msg4
        call printmsg
        
       
        lea dx,msg6
        call printmsg
;;;;;;;;;;;;;;;;;;;;;;;;;; end of defualt msgs;;;;;;;;;;;;;;;;;;;;;;
        
        call accchar ; accept char and store it in cl 
        xor cx,cx
        mov cl,al
        
        lea dx,msg7   ;print msg to let user enter num
        call printmsg
        
        xor ax , ax 
        call acc_two_digit
        
         sub ax ,'0'  ; to convert the enterd value to hexa decimal value  ;very true
        
       
       
;;;;;;;;;;;;;;;;;;;;;;;;;; comparing;;;;;;;;;;;;;;;;;;;;;;;
        cmp cl , 'A' 
         je cm_to_m   
        cmp cl , 'a' 
        je cm_to_m 
        cmp cl , 'C' 
        je m_to_cm
        cmp cl , 'c' 
        je m_to_cm 
        cmp cl , 'D' 
        je m_to_km
        cmp cl , 'd' 
        je m_to_km
        cmp cl , 'F' 
        je km_to_m
        cmp cl , 'f' 
        je km_to_m
        
        lea dx,msg0
        mov ah,09h
        int 21h
        jmp start
;;;;;;;;;;;;;;;;;;;;;;;; end of comparing ;;;;;;;;;;;;;;;;;;;;        
        
        .exit
 main endp 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; end of main;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;start of converter procs;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;; pointers ;;;;;;;;;;;;;;;;;;;;;;
km_to_m proc near   
      jmp km_to_m2  ; i do this because error out of range ... tha  je can not go to the proc because it is so far
ret
km_to_m endp  


m_to_km proc near  
      jmp m_to_km2  ; i do this because error out of range ... tha  je can not go to the proc because it is so far
ret
m_to_km endp 

;;;;;;;;;;;;;;;;;;;;; end of pointers ;;;;;;;;;;;;;;;;;;;;;;

cm_to_m proc near   ;div
        mov cm ,ax
        mov dx,0
        xor bx,bx
        mov bx,100  
        div bx      ;  value in ax  reminder dx
         mov result,ax ; now true value stored in result
        mov reminder,dx ;now reminder stored in reminder variable
        xor ax,ax ;0
        xor dx,dx ;0
       
        lea dx,resultmsg    ;result =
        mov ah,09h
        int 21h
         
       mov ax,result
       call printlnum_div
       
       mov dl,2Eh     ; "." ascii
       mov ah,02h
       int 21h
       
       xor ax,ax
       mov ax,reminder
       cmp ax,9h
       jg  C
       jle D
       
   D: 
      mov bx,ax 
      mov dl,"0"
      mov ah,02h
      int 21h 
      xor ax,ax 
      mov ax,bx
      call printlnum_div2
      jmp stop
      
  C:
      call printlnum_div2
      
    .exit 
         
         ret  
    cm_to_m endp;;;;;;;;;;;;;;;;;;;;;;
    
   
m_to_cm proc near      ; MUL
       mov metre ,ax
       xor bx,bx
       mov bx,100  
       mul bx      ;  value in ax  reminder dx
       mov result,ax ; now true value stored in result
       mov reminder,dx ;now reminder stored in reminder variable
       xor ax,ax ;0
       xor dx,dx ;0
       
       lea dx,resultmsg ;result =
       mov ah,09h
       int 21h
         
         mov ax,result
         call printlnum_mul
       .exit
       ret
m_to_cm endp

       
m_to_km2 proc near       ;div
       mov metre ,ax
        mov dx,0
        xor bx,bx
        mov bx,1000  
        div bx      ;  value in ax  reminder dx
         mov result,ax ; now true value stored in result
        mov reminder,dx ;now reminder stored in reminder variable
        xor ax,ax ;0
        xor dx,dx ;0
       
        lea dx,resultmsg    ;result =
        mov ah,09h
        int 21h
         
       mov ax,result
       call printlnum_div
       
       mov dl,2Eh     ; "." ascii
       mov ah,02h
       int 21h
       
        xor ax,ax
       mov ax,reminder
       cmp ax,9h
       jg  B
       jle A
       
   A: 
      mov bx,ax 
      mov dl,"0"
      mov ah,02h
      int 21h 
      xor ax,ax 
      mov ax,bx
      call printlnum_div
      jmp stop
      
  B: 
      mov bx,ax 
      mov dl,"0"                                              
      mov ah,02h  
      int 21h 
      xor ax,ax 
      mov ax,bx
      call printlnum_div2  
      jmp stop
      
    .exit
    ret
m_to_km2 endp 



km_to_m2 proc near   ; mul
       mov km ,ax  
       mov bx,1000  
       mul bx      ;  value in ax  reminder dx
       mov result,ax ; now true value stored in result
       mov reminder,dx ;now reminder stored in reminder variable
       xor ax,ax ;0
       xor dx,dx ;0
       lea dx,resultmsg
       mov ah,09h
       int 21h
       mov ax,result
       call printlnum_mul
       .exit
       ret
km_to_m2 endp        


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; end of converter procs;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
       
       
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; start of helpful procs;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
printmsg proc near 
        mov ah,09h
        int 21h
        ret
printmsg endp
     
accchar proc near
        mov ah,01h
        int 21h
        ret
accchar endp
     
printchar proc near
        mov ah,02h
        int 21h
        ret
printchar endp

;;;;;;;;;;;;;; two digit proc ;;;;;;;;
acc_two_digit proc near
        mov al,0  ; reset al
        
        mov ah,01h
        int 21h
        mov num1,al ;num1 size is db
        
        mov al,0  ; reset al
        
        mov ah,01h
        int 21h
        xor bx,bx  ; reset bx
        mov bl,al ;num 2 in bl
        mov num2,bx ;here num two is dw
        
        xor ax,ax
        mov al,num1  ; here num1 is asci
        sub al,"0"   ; to convert num1 to hexa
        xor bx,bx  
        mov bl,10
        mul bl
        
        add ax,num2
        mov totalnum,ax
        ret
acc_two_digit endp      
     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; end of helpful procs;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; start of printing procs;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
printlnum_mul proc near
     
     xor cx, cx              ; Clear digit counter
     mov bx, 10              ; Base 10 for division

    PrintLoop:
    xor dx, dx              ; Clear DX for division
    div bx                  ; AX = AX / 10, DX = remainder
    push dx                 ; Save remainder (digit) on the stack
    inc cx                  ; Increment digit counter
    cmp ax, 0             ; Check if AX is 0 and if  0 exit from looping 
    jnz PrintLoop           ; Repeat if more digits remain

    PrintDigits:
    pop dx                  ; Get the last digit
    add dl, '0'             ; Convert to ASCII  '0'=30h
    mov ah, 02h             ; DOS interrupt to print a character
    int 21h
    loop PrintDigits       

     ret
printlnum_mul endp


printlnum_div proc near      ;for printing m to km
     xor cx, cx              ; Clear digit counter
     mov bx, 10              ; Base 10 for division

 PrintLoop2:
    xor dx, dx              ; Clear DX for division
    div bx                  ; AX = AX / 10, DX = remainder
    push dx                 ; Save remainder (digit) on the stack
    inc cx                  ; Increment digit counter
    cmp ax, 0             ; Check if AX is 0
    jnz PrintLoop2           ; Repeat if more digits remain

    PrintDigits2:
    pop dx     ; Get the last digit
   
    
    mov bl,dl
    xor dl,dl
    mov dl,dh
    add dl,"0"
    mov ah,02h
    int 21h
    
    mov dl,bl
    add dl,"0"
    mov ah,02h
    int 21h
    
    loop PrintDigits2
    
ret
printlnum_div endp
     
;;;;;;;;;;;;;;;;    print proc for  cm to m  and from m to km for  numbers > 9

printlnum_div2 proc near      ;for printing cm to m
     xor cx, cx              ; Clear digit counter
     mov bx, 10              ; Base 10 for division

 PrintLoop3:
    xor dx, dx              ; Clear DX for division
    div bx                  ; AX = AX / 10, DX = remainder
    push dx                 ; Save remainder (digit) on the stack
    inc cx                  ; Increment digit counter
    cmp ax, 0             ; Check if AX is 0
    jnz PrintLoop3           ; Repeat if more digits remain

    PrintDigits3:
    pop dx     ; Get the last digit
  
    add dl,"0"
    mov ah,02h
    int 21h
    loop PrintDigits3
    
ret
printlnum_div2 endp    

;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   ending of printing procs  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    
stop proc  near
 
    .exit
    ret
stop endp
     
end main   