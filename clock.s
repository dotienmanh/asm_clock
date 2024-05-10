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
add t0,zero,a0

bne t0,s7,target0 #if(minute_up)
jal minute
add t1,zero,a0

target0:
bne t1,s7,target1 #if(hour_up)
jal hour
add t2,zero,a0

target1:
bne t2,s7,target2 #if(day_up)
jal day 
add t3,zero,a0

target2:
bne t3,s7,target3 #if(month_up)
jal month
add t4,zero,a0

target3:
bne t4,s7, endloop #if(year_up)
jal year

endloop:
j loop


second:
addi a1,zero,59
bne s0,a1,else_sec
addi s0,zero,0
addi a0,zero,1
j return_sec
else_sec:
addi s0,s0,1
addi a0,zero,0
return_sec:
addi a1,zero,0
jr ra

minute:
addi a1,zero,59
bne s1,a1,else_min
addi s1,zero,0
addi a0,zero,1
j return_min
else_min:
addi s1,s1,1
addi a0,zero,0
return_min:
addi a1,zero,0
jr ra

hour:
addi a1,zero,23
bne s2,a1,else_hour
addi s2,zero,0
addi a0,zero,1
j return_hour
else_hour:
addi s2,s2,1
addi a0,zero,0
return_hour:
addi a1,zero,0
jr ra

day:
add t5,s6,s4
lw t5,0(t5) #max day should implement code update value of month if leap year
bne s3,t5,else_day
addi s3,zero,0
addi a0,zero,1
j return_day
else_day:
addi s3,s3,1
addi a0,zero,0
return_day:
jr ra



month:
addi a1,zero,12
bne s4,a1,else_month
addi s4,zero,1
addi a0,zero,1
j return_month
else_month:
addi s4,s4,1
addi a0,zero,0
return_month:
addi a1,zero,0
jr ra

year:
addi a1,zero,99
bne s5,a1,else_year
addi s5,zero,00
j return_month
else_year:
addi s5,s5,1
return_year:
addi a1,zero,0
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