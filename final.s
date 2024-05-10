start:
addi s0,zero,0
addi s1,zero,0
addi s2,zero,0
addi s3,zero,5
addi s4,zero,10
addi s5,zero,24
la s6,max_day
addi s7,zero,1
li a0, 0x100

loop:
addi t0,zero,0 #minute_up,...,year_up
addi t1,zero,0
addi t2,zero,0
addi t3,zero,0
addi t4,zero,0
jal led_print
jal second
bne t0,s7,target0 #if(minute_up)
jal minute
target0:
bne t1,s7,target1 #if(hour_up)
jal hour #increment hour
target1:
bne t2,s7,target2 #if(day_up)
jal day 
target2:
bne t3,s7,target3 #if(month_up)
jal month
target3:
bne t4,s7, endloop #if(year_up)
jal year

endloop:
j loop


second:
addi t6,zero,59 
bne s0,t6,else_sec #check limit
addi s0,zero,0 #reset
addi t0,zero,1
j return_sec
else_sec:
addi s0,s0,1 #if not reach limit just increment
addi t0,zero,0
return_sec:
jr ra

minute:
addi t6,zero,59
bne s1,t6,else_min
addi s1,zero,0
addi t1,zero,1
j return_min
else_min:
addi s1,s1,1
addi t1,zero,0
return_min:
jr ra

hour:
addi t6,zero,23
bne s2,t6,else_hour
addi s2,zero,0
addi t2,zero,1
j return_hour
else_hour:
addi s2,s2,1
addi t2,zero,0
return_hour:
jr ra

day:
slli t5,s4,2# shift
add t5,s6,t5
lw t5,0(t5) #max day should implement code update value of month if leap year
li a4,3
and a4,s5,a4 #check remainder 
bne a4,zero,continue
addi a4,zero,2
bne a4,s4,continue
addi t5,t5,1
continue:
bne s3,t5,else_day
addi s3,zero,1
addi t3,zero,1
j return_day
else_day:
addi s3,s3,1
addi t3,zero,0
return_day:
jr ra



month:
addi t6,zero,12
bne s4,t6,else_month
addi s4,zero,1
addi t4,zero,1
j return_month
else_month:
addi s4,s4,1
addi t4,zero,0
return_month:
jr ra

year:
addi t6,zero,99
bne s5,t6,else_year
addi s5,zero,00
j return_month
else_year:
addi s5,s5,1
return_year:
jr ra


#lưu lần lượt giá trị ngày tháng năm vào s0, s1, s2, s3, s4, s5
#hàm loop chính
led_print:
#li s0, 0x12
#li s1, 0x01
#li s2, 0x02
#li s3, 0x03
#li s4, 0x04
#li s5, 0x05

#second
addi sp,sp,-4
sw ra,0(sp)
li t1, 10
rem s10, s0, t1 
li s8, 0x00370000
jal print
li t1, 10
div s10, s0, t1 
li s8, 0x00300000
jal print
#minute
li t1, 10
rem s10, s1, t1 
li s8, 0x00270000
jal print
li t1, 10
div s10, s1, t1 
li s8, 0x00200000
jal print
#hour
li t1, 10
rem s10, s2, t1 
li s8, 0x00170000
jal print
li t1, 10
div s10, s2, t1 
li s8, 0x00100000
jal print
#year
li t1, 10
rem s10, s5, t1 
li s8, 0x00370008
jal print
li t1, 10
div s10, s5, t1 
li s8, 0x00300008
jal print
#month
li t1, 10
rem s10, s4, t1 
li s8, 0x00270008
jal print
li t1, 10
div s10, s4, t1 
li s8, 0x00200008
jal print
#day
li t1, 10
rem s10, s3, t1 
li s8, 0x00170008
jal print
li t1, 10
div s10, s3, t1 
li s8, 0x00100008
jal print

lw ra,0(sp) 
addi sp,sp,4
jr ra

#print giá trị
print:
beq s10, zero, set_0
li t0, 1
beq s10, t0, set_1
li t0, 2
beq s10, t0, set_2
li t0, 3
beq s10, t0, set_3
li t0, 4
beq s10, t0, set_4
li t0, 5
beq s10, t0, set_5
li t0, 6
beq s10, t0, set_6
li t0, 7
beq s10, t0, set_7
li t0, 8
beq s10, t0, set_8
li t0, 9
beq s10, t0, set_9
jr ra

#set output
set_0:
addi sp,sp,-4
sw ra,0(sp)
la s9, display_0
jal change_number
lw ra,0(sp) 
addi sp,sp,4
jr ra

set_1:
addi sp,sp,-4
sw ra,0(sp)
la s9, display_1
jal change_number
lw ra,0(sp) 
addi sp,sp,4
jr ra

set_2:
addi sp,sp,-4
sw ra,0(sp)
la s9, display_2
jal change_number
lw ra,0(sp) 
addi sp,sp,4
jr ra

set_3:
addi sp,sp,-4
sw ra,0(sp)
la s9, display_3
jal change_number
lw ra,0(sp) 
addi sp,sp,4
jr ra

set_4:
addi sp,sp,-4
sw ra,0(sp)
la s9, display_4
jal change_number
lw ra,0(sp) 
addi sp,sp,4
jr ra

set_5:
addi sp,sp,-4
sw ra,0(sp)
la s9, display_5
jal change_number
lw ra,0(sp) 
addi sp,sp,4
jr ra

set_6:
addi sp,sp,-4
sw ra,0(sp)
la s9, display_6
jal change_number
lw ra,0(sp) 
addi sp,sp,4
jr ra

set_7:
addi sp,sp,-4
sw ra,0(sp)
la s9, display_7
jal change_number
lw ra,0(sp) 
addi sp,sp,4
jr ra

set_8:
addi sp,sp,-4
sw ra,0(sp)
la s9, display_8
jal change_number
lw ra,0(sp) 
addi sp,sp,4
jr ra

set_9:
addi sp,sp,-4
sw ra,0(sp)
la s9, display_9
jal change_number
lw ra,0(sp) 
addi sp,sp,4
jr ra

#thay đổi led
change_number:

li t2, 0
li t3, 7
outer:
li t1, 0
inner:
lw a2, 0(s9)
slli a1, t2, 16
mv t4, s8
add a1,a1,t4
or a1, a1, t1
ecall
addi s9, s9, 4
addi t1, t1, 1
bne t1, t3, inner
addi t2, t2, 1
bne t2, t3, outer
and s9,s9,zero

jr ra

#config led
.data
display_0:
#1
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#2
.word 0x000EFF06
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
.word 0x000EFF06
#3
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
#4
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
#5
.word 0x000EFF06
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
.word 0x000EFF06
#6
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#7
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000

.data
display_1:
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#1
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#2
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#3
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#4
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
#5
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#6
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000

.data
display_2:
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#1
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
.word 0x00FF0606
#2
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
.word 0x00FF0606
#3
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
#4
.word 0x000EFF06
.word 0x00FF0606
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
#5
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#6
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000

.data
display_3:
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#1
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
#2
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
#3
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
#4
.word 0x000EFF06
.word 0x00FF0606
.word 0x00FF0606
.word 0x000EFF06
.word 0x00FF0606
.word 0x00FF0606
.word 0x000EFF06
#5
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#6
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000

.data
display_4:
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#1
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
#2
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
#3
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
#4
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
#5
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
#6
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000

.data
display_5:
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#1
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
#2
.word 0x00FF0606
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
#3
.word 0x00FF0606
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
#4
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
.word 0x000EFF06
#5
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#6
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000

.data
display_6:
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#1
.word 0x000EFF06
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
.word 0x000EFF06
#2
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
#3
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
#4
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
.word 0x00FF0606
.word 0x000EFF06
#5
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#6
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000

.data
display_7:
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#1
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#2
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606

#3
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#4
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#5
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#6
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000

.data
display_8:
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#1
.word 0x000EFF06
.word 0x00FF0606
.word 0x00FF0606
.word 0x000EFF06
.word 0x00FF0606
.word 0x00FF0606
.word 0x000EFF06
#2
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
#3
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
#4
.word 0x000EFF06
.word 0x00FF0606
.word 0x00FF0606
.word 0x000EFF06
.word 0x00FF0606
.word 0x00FF0606
.word 0x000EFF06
#5
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#6
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000

.data
display_9:
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#1
.word 0x000EFF06
.word 0x00FF0606
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
#2
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
#3
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
.word 0x000EFF06
.word 0x000EFF06
.word 0x00FF0606
#4
.word 0x000EFF06
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
.word 0x00FF0606
.word 0x000EFF06
#5
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
.word 0x000EFF06
#6
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000

.data
max_day:
.word 00
.word 31
.word 28
.word 31
.word 30
.word 31
.word 30
.word 31
.word 31
.word 30
.word 31
.word 30
.word 31
