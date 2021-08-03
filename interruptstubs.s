.set IRQ_BASE, 0x20
.section .text

.extern _Z15handleInterrupthj

.macro HandleException num
.global _Z1516handleException\num\()v
  movb $\num, (interruptnumber)
  jmp int bottom
.endm


.macro HandleInterruptRequest num
.global _Z1526handleInterruptRequest\num\()v
  movb $\num + IRQ_BASE, (interruptnumber)
  jmp int bottom
.endm



HandleInterruptRequest 0x00
HandleInterruptRequest 0x01

int_bottom:
  pusha
  pushl %ds
  pushl %es
  pushl %fs
  pushl %gs



  pushl %esp 
  push (interruptnumber)
  call _Z15handleInterrupthj
  #addl $5, %esp
  movl %eax, %esp

  popl %gs
  popl %fs
  popl %es 
  popl %ds
  popa
  

  iret 
.data
  interruptnumber: .byte 0
  

