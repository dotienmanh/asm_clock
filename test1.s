start:
addi s0,zero,0
addi s1,zero,0
addi s2,zero,0
addi s3,zero,1
addi s4,zero,1
addi s5,zero,0
la s6,max_day
addi s7,zero,1

loop:
addi t0,zero,0 #minute_up,...,year_up
addi t1,zero,0
addi t2,zero,0
addi t3,zero,0
addi t4,zero,0
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
addi s3,zero,0
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


.data
max_day:
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
