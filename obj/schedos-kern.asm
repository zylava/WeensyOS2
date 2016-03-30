
obj/schedos-kern:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
# The multiboot_start routine sets the stack pointer to the top of the
# SchedOS's kernel stack, then jumps to the 'start' routine in schedos-kern.c.

.globl multiboot_start
multiboot_start:
	movl $0x180000, %esp
  10000c:	bc 00 00 18 00       	mov    $0x180000,%esp
	pushl $0
  100011:	6a 00                	push   $0x0
	popfl
  100013:	9d                   	popf   
	call start
  100014:	e8 b6 02 00 00       	call   1002cf <start>
  100019:	90                   	nop

0010001a <clock_int_handler>:
# Interrupt handlers
.align 2

	.globl clock_int_handler
clock_int_handler:
	pushl $0		// error code
  10001a:	6a 00                	push   $0x0
	pushl $32		// trap number
  10001c:	6a 20                	push   $0x20
	jmp _generic_int_handler
  10001e:	eb 40                	jmp    100060 <_generic_int_handler>

00100020 <sys_int48_handler>:

sys_int48_handler:
	pushl $0
  100020:	6a 00                	push   $0x0
	pushl $48
  100022:	6a 30                	push   $0x30
	jmp _generic_int_handler
  100024:	eb 3a                	jmp    100060 <_generic_int_handler>

00100026 <sys_int49_handler>:

sys_int49_handler:
	pushl $0
  100026:	6a 00                	push   $0x0
	pushl $49
  100028:	6a 31                	push   $0x31
	jmp _generic_int_handler
  10002a:	eb 34                	jmp    100060 <_generic_int_handler>

0010002c <sys_int50_handler>:

sys_int50_handler:
	pushl $0
  10002c:	6a 00                	push   $0x0
	pushl $50
  10002e:	6a 32                	push   $0x32
	jmp _generic_int_handler
  100030:	eb 2e                	jmp    100060 <_generic_int_handler>

00100032 <sys_int51_handler>:

sys_int51_handler:
	pushl $0
  100032:	6a 00                	push   $0x0
	pushl $51
  100034:	6a 33                	push   $0x33
	jmp _generic_int_handler
  100036:	eb 28                	jmp    100060 <_generic_int_handler>

00100038 <sys_int52_handler>:

sys_int52_handler:
	pushl $0
  100038:	6a 00                	push   $0x0
	pushl $52
  10003a:	6a 34                	push   $0x34
	jmp _generic_int_handler
  10003c:	eb 22                	jmp    100060 <_generic_int_handler>

0010003e <sys_int53_handler>:

sys_int53_handler:
	pushl $0
  10003e:	6a 00                	push   $0x0
	pushl $53
  100040:	6a 35                	push   $0x35
	jmp _generic_int_handler
  100042:	eb 1c                	jmp    100060 <_generic_int_handler>

00100044 <sys_int54_handler>:

sys_int54_handler:
	pushl $0
  100044:	6a 00                	push   $0x0
	pushl $54
  100046:	6a 36                	push   $0x36
	jmp _generic_int_handler
  100048:	eb 16                	jmp    100060 <_generic_int_handler>

0010004a <sys_int55_handler>:

sys_int55_handler:
	pushl $0
  10004a:	6a 00                	push   $0x0
	pushl $55
  10004c:	6a 37                	push   $0x37
	jmp _generic_int_handler
  10004e:	eb 10                	jmp    100060 <_generic_int_handler>

00100050 <sys_int56_handler>:

sys_int56_handler:
	pushl $0
  100050:	6a 00                	push   $0x0
	pushl $56
  100052:	6a 38                	push   $0x38
	jmp _generic_int_handler
  100054:	eb 0a                	jmp    100060 <_generic_int_handler>

00100056 <sys_int57_handler>:

sys_int57_handler:
	pushl $0
  100056:	6a 00                	push   $0x0
	pushl $57
  100058:	6a 39                	push   $0x39
	jmp _generic_int_handler
  10005a:	eb 04                	jmp    100060 <_generic_int_handler>

0010005c <default_int_handler>:

	.globl default_int_handler
default_int_handler:
	pushl $0
  10005c:	6a 00                	push   $0x0
	jmp _generic_int_handler
  10005e:	eb 00                	jmp    100060 <_generic_int_handler>

00100060 <_generic_int_handler>:
	# When we get here, the processor's interrupt mechanism has
	# pushed the old task status and stack registers onto the kernel stack.
	# Then one of the specific handlers pushed the trap number.
	# Now, we complete the 'registers_t' structure by pushing the extra
	# segment definitions and the general CPU registers.
	pushl %ds
  100060:	1e                   	push   %ds
	pushl %es
  100061:	06                   	push   %es
	pushal
  100062:	60                   	pusha  

	# Load the kernel's data segments into the extra segment registers
	# (although we don't use those extra segments!).
	movl $0x10, %eax
  100063:	b8 10 00 00 00       	mov    $0x10,%eax
	movw %ax, %ds
  100068:	8e d8                	mov    %eax,%ds
	movw %ax, %es
  10006a:	8e c0                	mov    %eax,%es

	# Call the kernel's 'interrupt' function.
	pushl %esp
  10006c:	54                   	push   %esp
	call interrupt
  10006d:	e8 ca 01 00 00       	call   10023c <interrupt>

00100072 <sys_int_handlers>:
  100072:	20 00                	and    %al,(%eax)
  100074:	10 00                	adc    %al,(%eax)
  100076:	26 00 10             	add    %dl,%es:(%eax)
  100079:	00 2c 00             	add    %ch,(%eax,%eax,1)
  10007c:	10 00                	adc    %al,(%eax)
  10007e:	32 00                	xor    (%eax),%al
  100080:	10 00                	adc    %al,(%eax)
  100082:	38 00                	cmp    %al,(%eax)
  100084:	10 00                	adc    %al,(%eax)
  100086:	3e 00 10             	add    %dl,%ds:(%eax)
  100089:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
  10008d:	00 4a 00             	add    %cl,0x0(%edx)
  100090:	10 00                	adc    %al,(%eax)
  100092:	50                   	push   %eax
  100093:	00 10                	add    %dl,(%eax)
  100095:	00 56 00             	add    %dl,0x0(%esi)
  100098:	10 00                	adc    %al,(%eax)
  10009a:	90                   	nop
  10009b:	90                   	nop

0010009c <schedule>:
 *
 *****************************************************************************/

void
schedule(void)
{
  10009c:	57                   	push   %edi
  10009d:	56                   	push   %esi
  10009e:	53                   	push   %ebx
  10009f:	83 ec 20             	sub    $0x20,%esp
	pid_t pid = current->p_pid;
  1000a2:	a1 a0 76 10 00       	mov    0x1076a0,%eax
  1000a7:	8b 10                	mov    (%eax),%edx
	unsigned int lowestPri = 0xffffffff;

	if (scheduling_algorithm == 0)
  1000a9:	a1 a4 76 10 00       	mov    0x1076a4,%eax
  1000ae:	85 c0                	test   %eax,%eax
  1000b0:	75 1c                	jne    1000ce <schedule+0x32>
	{
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000b2:	b9 05 00 00 00       	mov    $0x5,%ecx
  1000b7:	8d 42 01             	lea    0x1(%edx),%eax
  1000ba:	99                   	cltd   
  1000bb:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000bd:	6b c2 5c             	imul   $0x5c,%edx,%eax
  1000c0:	83 b8 b4 6c 10 00 01 	cmpl   $0x1,0x106cb4(%eax)
  1000c7:	75 ee                	jne    1000b7 <schedule+0x1b>
				run(&proc_array[pid]);
  1000c9:	83 ec 0c             	sub    $0xc,%esp
  1000cc:	eb 78                	jmp    100146 <schedule+0xaa>
		}
	}

	else if (scheduling_algorithm == 1)
  1000ce:	83 f8 01             	cmp    $0x1,%eax
  1000d1:	0f 85 91 00 00 00    	jne    100168 <schedule+0xcc>
	{
		int not_run[NPROCS];
		int i;
		for (i = 0; i < NPROCS; i++)
			not_run[i] = 0;
  1000d7:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1000de:	00 
  1000df:	ba 01 00 00 00       	mov    $0x1,%edx

		while (1)
		{
			if (proc_array[pid].p_state != P_RUNNABLE){
				not_run[pid] = 1;
				pid = (pid + 1) % NPROCS;
  1000e4:	b9 05 00 00 00       	mov    $0x5,%ecx
	else if (scheduling_algorithm == 1)
	{
		int not_run[NPROCS];
		int i;
		for (i = 0; i < NPROCS; i++)
			not_run[i] = 0;
  1000e9:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  1000f0:	00 
  1000f1:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1000f8:	00 
  1000f9:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  100100:	00 
  100101:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  100108:	00 

		pid = 1;

		while (1)
		{
			if (proc_array[pid].p_state != P_RUNNABLE){
  100109:	6b c2 5c             	imul   $0x5c,%edx,%eax
  10010c:	83 b8 b4 6c 10 00 01 	cmpl   $0x1,0x106cb4(%eax)
  100113:	75 10                	jne    100125 <schedule+0x89>
  100115:	b9 10 6d 10 00       	mov    $0x106d10,%ecx
  10011a:	b8 01 00 00 00       	mov    $0x1,%eax
				pid = (pid + 1) % NPROCS;
			}
			else {
				i = 1;
				while(i < pid){
					if (not_run[i] == 1 && proc_array[i].p_state == P_RUNNABLE)
  10011f:	8d 5c 24 0c          	lea    0xc(%esp),%ebx
  100123:	eb 30                	jmp    100155 <schedule+0xb9>

		while (1)
		{
			if (proc_array[pid].p_state != P_RUNNABLE){
				not_run[pid] = 1;
				pid = (pid + 1) % NPROCS;
  100125:	8d 42 01             	lea    0x1(%edx),%eax
		pid = 1;

		while (1)
		{
			if (proc_array[pid].p_state != P_RUNNABLE){
				not_run[pid] = 1;
  100128:	c7 44 94 0c 01 00 00 	movl   $0x1,0xc(%esp,%edx,4)
  10012f:	00 
				pid = (pid + 1) % NPROCS;
  100130:	99                   	cltd   
  100131:	f7 f9                	idiv   %ecx
					i++;
				}
				run(&proc_array[pid]);
			}
			
		}
  100133:	eb d4                	jmp    100109 <schedule+0x6d>
				pid = (pid + 1) % NPROCS;
			}
			else {
				i = 1;
				while(i < pid){
					if (not_run[i] == 1 && proc_array[i].p_state == P_RUNNABLE)
  100135:	83 3c 83 01          	cmpl   $0x1,(%ebx,%eax,4)
  100139:	75 16                	jne    100151 <schedule+0xb5>
  10013b:	83 39 01             	cmpl   $0x1,(%ecx)
  10013e:	75 11                	jne    100151 <schedule+0xb5>
					{
						run(&proc_array[i]);
  100140:	6b c0 5c             	imul   $0x5c,%eax,%eax
  100143:	83 ec 0c             	sub    $0xc,%esp
  100146:	05 6c 6c 10 00       	add    $0x106c6c,%eax
  10014b:	50                   	push   %eax
  10014c:	e8 ec 04 00 00       	call   10063d <run>
					}
					i++;
  100151:	40                   	inc    %eax
  100152:	83 c1 5c             	add    $0x5c,%ecx
				not_run[pid] = 1;
				pid = (pid + 1) % NPROCS;
			}
			else {
				i = 1;
				while(i < pid){
  100155:	39 d0                	cmp    %edx,%eax
  100157:	7c dc                	jl     100135 <schedule+0x99>
					{
						run(&proc_array[i]);
					}
					i++;
				}
				run(&proc_array[pid]);
  100159:	6b d2 5c             	imul   $0x5c,%edx,%edx
  10015c:	83 ec 0c             	sub    $0xc,%esp
  10015f:	81 c2 6c 6c 10 00    	add    $0x106c6c,%edx
  100165:	52                   	push   %edx
  100166:	eb e4                	jmp    10014c <schedule+0xb0>
			}
			
		}
			
	}
	else if (scheduling_algorithm == 2)//4A. higheest Priority first 
  100168:	83 f8 02             	cmp    $0x2,%eax
  10016b:	75 68                	jne    1001d5 <schedule+0x139>
  10016d:	eb 08                	jmp    100177 <schedule+0xdb>
		int i;
		int highestPriority;
		int nextPid;

		while(proc_array[pid].p_state != P_RUNNABLE)
			pid = (pid + 1) % NPROCS;
  10016f:	8d 42 01             	lea    0x1(%edx),%eax
  100172:	99                   	cltd   
  100173:	f7 f9                	idiv   %ecx
  100175:	eb 05                	jmp    10017c <schedule+0xe0>
  100177:	b9 05 00 00 00       	mov    $0x5,%ecx
	{
		int i;
		int highestPriority;
		int nextPid;

		while(proc_array[pid].p_state != P_RUNNABLE)
  10017c:	6b c2 5c             	imul   $0x5c,%edx,%eax
  10017f:	83 b8 b4 6c 10 00 01 	cmpl   $0x1,0x106cb4(%eax)
  100186:	75 e7                	jne    10016f <schedule+0xd3>
			pid = (pid + 1) % NPROCS;

		nextPid = pid;
		highestPriority = proc_array[pid].p_priority;
  100188:	8b 98 bc 6c 10 00    	mov    0x106cbc(%eax),%ebx
  10018e:	89 d6                	mov    %edx,%esi
  100190:	31 c9                	xor    %ecx,%ecx
		
		for (i = 0; i < NPROCS - 1; i++)
		{	
			pid = (pid + 1) % NPROCS;//starting from the next and check for equal priority so that same priority can share the CPU
  100192:	bf 05 00 00 00       	mov    $0x5,%edi
  100197:	8d 42 01             	lea    0x1(%edx),%eax
  10019a:	99                   	cltd   
  10019b:	f7 ff                	idiv   %edi
	
			if (proc_array[pid].p_state == P_RUNNABLE && proc_array[pid].p_priority <= highestPriority)
  10019d:	6b c2 5c             	imul   $0x5c,%edx,%eax
  1001a0:	83 b8 b4 6c 10 00 01 	cmpl   $0x1,0x106cb4(%eax)
  1001a7:	75 0e                	jne    1001b7 <schedule+0x11b>
  1001a9:	8b 80 bc 6c 10 00    	mov    0x106cbc(%eax),%eax
  1001af:	39 d8                	cmp    %ebx,%eax
  1001b1:	7f 04                	jg     1001b7 <schedule+0x11b>
  1001b3:	89 d6                	mov    %edx,%esi
  1001b5:	eb 02                	jmp    1001b9 <schedule+0x11d>
  1001b7:	89 d8                	mov    %ebx,%eax
			pid = (pid + 1) % NPROCS;

		nextPid = pid;
		highestPriority = proc_array[pid].p_priority;
		
		for (i = 0; i < NPROCS - 1; i++)
  1001b9:	41                   	inc    %ecx
  1001ba:	83 f9 04             	cmp    $0x4,%ecx
  1001bd:	74 04                	je     1001c3 <schedule+0x127>
  1001bf:	89 c3                	mov    %eax,%ebx
  1001c1:	eb d4                	jmp    100197 <schedule+0xfb>
				nextPid = pid;
			}	

		}

		run(&proc_array[nextPid]);
  1001c3:	6b f6 5c             	imul   $0x5c,%esi,%esi
  1001c6:	83 ec 0c             	sub    $0xc,%esp
  1001c9:	81 c6 6c 6c 10 00    	add    $0x106c6c,%esi
  1001cf:	56                   	push   %esi
  1001d0:	e9 77 ff ff ff       	jmp    10014c <schedule+0xb0>
	}	
	
	else if (scheduling_algorithm == 3)//4B. Proportional-share scheduling
  1001d5:	83 f8 03             	cmp    $0x3,%eax
  1001d8:	75 41                	jne    10021b <schedule+0x17f>
					run(&proc_array[pid]);
			}
			else
			{
				proc_array[pid].p_shareCount = 0;
				pid = (pid + 1) % NPROCS;
  1001da:	b9 05 00 00 00       	mov    $0x5,%ecx
	
	else if (scheduling_algorithm == 3)//4B. Proportional-share scheduling
	{
		while (1)
		{
			if (proc_array[pid].p_shareCount < proc_array[pid].p_share)
  1001df:	6b da 5c             	imul   $0x5c,%edx,%ebx
  1001e2:	8d 83 74 6c 10 00    	lea    0x106c74(%ebx),%eax
  1001e8:	8b 70 50             	mov    0x50(%eax),%esi
  1001eb:	3b b3 c0 6c 10 00    	cmp    0x106cc0(%ebx),%esi
  1001f1:	7d 19                	jge    10020c <schedule+0x170>
			{
				proc_array[pid].p_shareCount++;
  1001f3:	46                   	inc    %esi
				if (proc_array[pid].p_state == P_RUNNABLE)
  1001f4:	83 78 40 01          	cmpl   $0x1,0x40(%eax)
	{
		while (1)
		{
			if (proc_array[pid].p_shareCount < proc_array[pid].p_share)
			{
				proc_array[pid].p_shareCount++;
  1001f8:	89 70 50             	mov    %esi,0x50(%eax)
				if (proc_array[pid].p_state == P_RUNNABLE)
  1001fb:	75 e2                	jne    1001df <schedule+0x143>
					run(&proc_array[pid]);
  1001fd:	83 ec 0c             	sub    $0xc,%esp
  100200:	81 c3 6c 6c 10 00    	add    $0x106c6c,%ebx
  100206:	53                   	push   %ebx
  100207:	e9 40 ff ff ff       	jmp    10014c <schedule+0xb0>
			}
			else
			{
				proc_array[pid].p_shareCount = 0;
  10020c:	c7 40 50 00 00 00 00 	movl   $0x0,0x50(%eax)
				pid = (pid + 1) % NPROCS;
  100213:	8d 42 01             	lea    0x1(%edx),%eax
  100216:	99                   	cltd   
  100217:	f7 f9                	idiv   %ecx
  100219:	eb c4                	jmp    1001df <schedule+0x143>
			}
		}
		
	}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  10021b:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100221:	50                   	push   %eax
  100222:	68 fc 0b 10 00       	push   $0x100bfc
  100227:	68 00 01 00 00       	push   $0x100
  10022c:	52                   	push   %edx
  10022d:	e8 b0 09 00 00       	call   100be2 <console_printf>
  100232:	83 c4 10             	add    $0x10,%esp
  100235:	a3 00 80 19 00       	mov    %eax,0x198000
  10023a:	eb fe                	jmp    10023a <schedule+0x19e>

0010023c <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  10023c:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10023d:	a1 a0 76 10 00       	mov    0x1076a0,%eax
  100242:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100247:	56                   	push   %esi
  100248:	53                   	push   %ebx
  100249:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  10024d:	8d 78 04             	lea    0x4(%eax),%edi
  100250:	89 de                	mov    %ebx,%esi
  100252:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  100254:	8b 53 28             	mov    0x28(%ebx),%edx
  100257:	83 fa 32             	cmp    $0x32,%edx
  10025a:	74 38                	je     100294 <interrupt+0x58>
  10025c:	77 0e                	ja     10026c <interrupt+0x30>
  10025e:	83 fa 30             	cmp    $0x30,%edx
  100261:	74 15                	je     100278 <interrupt+0x3c>
  100263:	77 18                	ja     10027d <interrupt+0x41>
  100265:	83 fa 20             	cmp    $0x20,%edx
  100268:	74 5e                	je     1002c8 <interrupt+0x8c>
  10026a:	eb 61                	jmp    1002cd <interrupt+0x91>
  10026c:	83 fa 33             	cmp    $0x33,%edx
  10026f:	74 30                	je     1002a1 <interrupt+0x65>
  100271:	83 fa 34             	cmp    $0x34,%edx
  100274:	74 3a                	je     1002b0 <interrupt+0x74>
  100276:	eb 55                	jmp    1002cd <interrupt+0x91>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  100278:	e8 1f fe ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  10027d:	a1 a0 76 10 00       	mov    0x1076a0,%eax
		current->p_exit_status = reg->reg_eax;
  100282:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100285:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  10028c:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  10028f:	e8 08 fe ff ff       	call   10009c <schedule>

	case INT_SYS_SHARE:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		/* Your code here (if you want). */
		current->p_share = reg->reg_eax;
  100294:	a1 a0 76 10 00       	mov    0x1076a0,%eax
  100299:	8b 53 1c             	mov    0x1c(%ebx),%edx
  10029c:	89 50 54             	mov    %edx,0x54(%eax)
  10029f:	eb 06                	jmp    1002a7 <interrupt+0x6b>
		run(current);

	case INT_SYS_PRIORITIZE:
		/* Your code here (if you want). */
		current->p_priority = reg->reg_eax;
  1002a1:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1002a4:	89 50 50             	mov    %edx,0x50(%eax)
		run(current);
  1002a7:	83 ec 0c             	sub    $0xc,%esp
  1002aa:	50                   	push   %eax
  1002ab:	e8 8d 03 00 00       	call   10063d <run>

	case INT_SYS_ATOMIC_CHAR:
		*cursorpos++ = reg->reg_eax;
  1002b0:	a1 00 80 19 00       	mov    0x198000,%eax
  1002b5:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1002b8:	66 89 10             	mov    %dx,(%eax)
  1002bb:	83 c0 02             	add    $0x2,%eax
  1002be:	a3 00 80 19 00       	mov    %eax,0x198000
		schedule();
  1002c3:	e8 d4 fd ff ff       	call   10009c <schedule>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  1002c8:	e8 cf fd ff ff       	call   10009c <schedule>
  1002cd:	eb fe                	jmp    1002cd <interrupt+0x91>

001002cf <start>:
 *
 *****************************************************************************/

void
start(void)
{
  1002cf:	57                   	push   %edi

	proc_array[0].p_share = 0;
	proc_array[1].p_share = 1;
	proc_array[2].p_share = 2;
	proc_array[3].p_share = 3;
	proc_array[4].p_share = 4;
  1002d0:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  1002d5:	56                   	push   %esi

	proc_array[0].p_share = 0;
	proc_array[1].p_share = 1;
	proc_array[2].p_share = 2;
	proc_array[3].p_share = 3;
	proc_array[4].p_share = 4;
  1002d6:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  1002d8:	53                   	push   %ebx

	proc_array[0].p_share = 0;
	proc_array[1].p_share = 1;
	proc_array[2].p_share = 2;
	proc_array[3].p_share = 3;
	proc_array[4].p_share = 4;
  1002d9:	bb c8 6c 10 00       	mov    $0x106cc8,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  1002de:	e8 39 01 00 00       	call   10041c <segments_init>
	interrupt_controller_init(0);
  1002e3:	83 ec 0c             	sub    $0xc,%esp
  1002e6:	6a 00                	push   $0x0
  1002e8:	e8 2a 02 00 00       	call   100517 <interrupt_controller_init>
	console_clear();
  1002ed:	e8 ae 02 00 00       	call   1005a0 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  1002f2:	83 c4 0c             	add    $0xc,%esp
  1002f5:	68 cc 01 00 00       	push   $0x1cc
  1002fa:	6a 00                	push   $0x0
  1002fc:	68 6c 6c 10 00       	push   $0x106c6c
  100301:	e8 7a 04 00 00       	call   100780 <memset>

	proc_array[0].p_share = 0;
	proc_array[1].p_share = 1;
	proc_array[2].p_share = 2;
	proc_array[3].p_share = 3;
	proc_array[4].p_share = 4;
  100306:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100309:	c7 05 6c 6c 10 00 00 	movl   $0x0,0x106c6c
  100310:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100313:	c7 05 b4 6c 10 00 00 	movl   $0x0,0x106cb4
  10031a:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10031d:	c7 05 c8 6c 10 00 01 	movl   $0x1,0x106cc8
  100324:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100327:	c7 05 10 6d 10 00 00 	movl   $0x0,0x106d10
  10032e:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100331:	c7 05 24 6d 10 00 02 	movl   $0x2,0x106d24
  100338:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10033b:	c7 05 6c 6d 10 00 00 	movl   $0x0,0x106d6c
  100342:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100345:	c7 05 80 6d 10 00 03 	movl   $0x3,0x106d80
  10034c:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10034f:	c7 05 c8 6d 10 00 00 	movl   $0x0,0x106dc8
  100356:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100359:	c7 05 dc 6d 10 00 04 	movl   $0x4,0x106ddc
  100360:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100363:	c7 05 24 6e 10 00 00 	movl   $0x0,0x106e24
  10036a:	00 00 00 
	}
	
	proc_array[1].p_priority = 2;
  10036d:	c7 05 18 6d 10 00 02 	movl   $0x2,0x106d18
  100374:	00 00 00 
	proc_array[2].p_priority = 1;
  100377:	c7 05 74 6d 10 00 01 	movl   $0x1,0x106d74
  10037e:	00 00 00 
	proc_array[3].p_priority = 1;
  100381:	c7 05 d0 6d 10 00 01 	movl   $0x1,0x106dd0
  100388:	00 00 00 
	proc_array[4].p_priority = 0;
  10038b:	c7 05 2c 6e 10 00 00 	movl   $0x0,0x106e2c
  100392:	00 00 00 

	proc_array[0].p_share = 0;
  100395:	c7 05 c0 6c 10 00 00 	movl   $0x0,0x106cc0
  10039c:	00 00 00 
	proc_array[1].p_share = 1;
  10039f:	c7 05 1c 6d 10 00 01 	movl   $0x1,0x106d1c
  1003a6:	00 00 00 
	proc_array[2].p_share = 2;
  1003a9:	c7 05 78 6d 10 00 02 	movl   $0x2,0x106d78
  1003b0:	00 00 00 
	proc_array[3].p_share = 3;
  1003b3:	c7 05 d4 6d 10 00 03 	movl   $0x3,0x106dd4
  1003ba:	00 00 00 
	proc_array[4].p_share = 4;
  1003bd:	c7 05 30 6e 10 00 04 	movl   $0x4,0x106e30
  1003c4:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  1003c7:	83 ec 0c             	sub    $0xc,%esp
  1003ca:	53                   	push   %ebx
  1003cb:	e8 84 02 00 00       	call   100654 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1003d0:	58                   	pop    %eax
  1003d1:	5a                   	pop    %edx
  1003d2:	8d 43 34             	lea    0x34(%ebx),%eax

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  1003d5:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1003d8:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1003de:	50                   	push   %eax
  1003df:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1003e0:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1003e1:	e8 aa 02 00 00       	call   100690 <program_loader>
	proc_array[1].p_share = 1;
	proc_array[2].p_share = 2;
	proc_array[3].p_share = 3;
	proc_array[4].p_share = 4;
	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1003e6:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1003e9:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)
  1003f0:	83 c3 5c             	add    $0x5c,%ebx
	proc_array[1].p_share = 1;
	proc_array[2].p_share = 2;
	proc_array[3].p_share = 3;
	proc_array[4].p_share = 4;
	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1003f3:	83 fe 04             	cmp    $0x4,%esi
  1003f6:	75 cf                	jne    1003c7 <start+0xf8>
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	scheduling_algorithm = 2;

	// Switch to the first process.
	run(&proc_array[1]);
  1003f8:	83 ec 0c             	sub    $0xc,%esp
  1003fb:	68 c8 6c 10 00       	push   $0x106cc8
		proc->p_state = P_RUNNABLE;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  100400:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100407:	80 0b 00 
	//    0 = the initial algorithm
	//    2 = strict priority scheduling (exercise 2)
	//   41 = p_priority algorithm (exercise 4.a)
	//   42 = p_share algorithm (exercise 4.b)
	//    7 = any algorithm that you may implement for exercise 7
	scheduling_algorithm = 2;
  10040a:	c7 05 a4 76 10 00 02 	movl   $0x2,0x1076a4
  100411:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  100414:	e8 24 02 00 00       	call   10063d <run>
  100419:	90                   	nop
  10041a:	90                   	nop
  10041b:	90                   	nop

0010041c <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10041c:	b8 38 6e 10 00       	mov    $0x106e38,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100421:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100426:	89 c2                	mov    %eax,%edx
  100428:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  10042b:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10042c:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  100431:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100434:	66 a3 3a 10 10 00    	mov    %ax,0x10103a
  10043a:	c1 e8 18             	shr    $0x18,%eax
  10043d:	88 15 3c 10 10 00    	mov    %dl,0x10103c
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100443:	ba a0 6e 10 00       	mov    $0x106ea0,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100448:	a2 3f 10 10 00       	mov    %al,0x10103f
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10044d:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10044f:	66 c7 05 38 10 10 00 	movw   $0x68,0x101038
  100456:	68 00 
  100458:	c6 05 3e 10 10 00 40 	movb   $0x40,0x10103e
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  10045f:	c6 05 3d 10 10 00 89 	movb   $0x89,0x10103d

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  100466:	c7 05 3c 6e 10 00 00 	movl   $0x180000,0x106e3c
  10046d:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100470:	66 c7 05 40 6e 10 00 	movw   $0x10,0x106e40
  100477:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100479:	66 89 0c c5 a0 6e 10 	mov    %cx,0x106ea0(,%eax,8)
  100480:	00 
  100481:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100488:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10048d:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  100492:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  100497:	40                   	inc    %eax
  100498:	3d 00 01 00 00       	cmp    $0x100,%eax
  10049d:	75 da                	jne    100479 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  10049f:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004a4:	ba a0 6e 10 00       	mov    $0x106ea0,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1004a9:	66 a3 a0 6f 10 00    	mov    %ax,0x106fa0
  1004af:	c1 e8 10             	shr    $0x10,%eax
  1004b2:	66 a3 a6 6f 10 00    	mov    %ax,0x106fa6
  1004b8:	b8 30 00 00 00       	mov    $0x30,%eax
  1004bd:	66 c7 05 a2 6f 10 00 	movw   $0x8,0x106fa2
  1004c4:	08 00 
  1004c6:	c6 05 a4 6f 10 00 00 	movb   $0x0,0x106fa4
  1004cd:	c6 05 a5 6f 10 00 8e 	movb   $0x8e,0x106fa5

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004d4:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  1004db:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1004e2:	66 89 0c c5 a0 6e 10 	mov    %cx,0x106ea0(,%eax,8)
  1004e9:	00 
  1004ea:	c1 e9 10             	shr    $0x10,%ecx
  1004ed:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1004f2:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  1004f7:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  1004fc:	40                   	inc    %eax
  1004fd:	83 f8 3a             	cmp    $0x3a,%eax
  100500:	75 d2                	jne    1004d4 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  100502:	b0 28                	mov    $0x28,%al
  100504:	0f 01 15 00 10 10 00 	lgdtl  0x101000
  10050b:	0f 00 d8             	ltr    %ax
  10050e:	0f 01 1d 08 10 10 00 	lidtl  0x101008
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100515:	5b                   	pop    %ebx
  100516:	c3                   	ret    

00100517 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  100517:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100518:	b0 ff                	mov    $0xff,%al
  10051a:	57                   	push   %edi
  10051b:	56                   	push   %esi
  10051c:	53                   	push   %ebx
  10051d:	bb 21 00 00 00       	mov    $0x21,%ebx
  100522:	89 da                	mov    %ebx,%edx
  100524:	ee                   	out    %al,(%dx)
  100525:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  10052a:	89 ca                	mov    %ecx,%edx
  10052c:	ee                   	out    %al,(%dx)
  10052d:	be 11 00 00 00       	mov    $0x11,%esi
  100532:	bf 20 00 00 00       	mov    $0x20,%edi
  100537:	89 f0                	mov    %esi,%eax
  100539:	89 fa                	mov    %edi,%edx
  10053b:	ee                   	out    %al,(%dx)
  10053c:	b0 20                	mov    $0x20,%al
  10053e:	89 da                	mov    %ebx,%edx
  100540:	ee                   	out    %al,(%dx)
  100541:	b0 04                	mov    $0x4,%al
  100543:	ee                   	out    %al,(%dx)
  100544:	b0 03                	mov    $0x3,%al
  100546:	ee                   	out    %al,(%dx)
  100547:	bd a0 00 00 00       	mov    $0xa0,%ebp
  10054c:	89 f0                	mov    %esi,%eax
  10054e:	89 ea                	mov    %ebp,%edx
  100550:	ee                   	out    %al,(%dx)
  100551:	b0 28                	mov    $0x28,%al
  100553:	89 ca                	mov    %ecx,%edx
  100555:	ee                   	out    %al,(%dx)
  100556:	b0 02                	mov    $0x2,%al
  100558:	ee                   	out    %al,(%dx)
  100559:	b0 01                	mov    $0x1,%al
  10055b:	ee                   	out    %al,(%dx)
  10055c:	b0 68                	mov    $0x68,%al
  10055e:	89 fa                	mov    %edi,%edx
  100560:	ee                   	out    %al,(%dx)
  100561:	be 0a 00 00 00       	mov    $0xa,%esi
  100566:	89 f0                	mov    %esi,%eax
  100568:	ee                   	out    %al,(%dx)
  100569:	b0 68                	mov    $0x68,%al
  10056b:	89 ea                	mov    %ebp,%edx
  10056d:	ee                   	out    %al,(%dx)
  10056e:	89 f0                	mov    %esi,%eax
  100570:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  100571:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  100576:	89 da                	mov    %ebx,%edx
  100578:	19 c0                	sbb    %eax,%eax
  10057a:	f7 d0                	not    %eax
  10057c:	05 ff 00 00 00       	add    $0xff,%eax
  100581:	ee                   	out    %al,(%dx)
  100582:	b0 ff                	mov    $0xff,%al
  100584:	89 ca                	mov    %ecx,%edx
  100586:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  100587:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  10058c:	74 0d                	je     10059b <interrupt_controller_init+0x84>
  10058e:	b2 43                	mov    $0x43,%dl
  100590:	b0 34                	mov    $0x34,%al
  100592:	ee                   	out    %al,(%dx)
  100593:	b0 8e                	mov    $0x8e,%al
  100595:	b2 40                	mov    $0x40,%dl
  100597:	ee                   	out    %al,(%dx)
  100598:	b0 01                	mov    $0x1,%al
  10059a:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  10059b:	5b                   	pop    %ebx
  10059c:	5e                   	pop    %esi
  10059d:	5f                   	pop    %edi
  10059e:	5d                   	pop    %ebp
  10059f:	c3                   	ret    

001005a0 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  1005a0:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1005a1:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  1005a3:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1005a4:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1005ab:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  1005ae:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1005b4:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  1005ba:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  1005bd:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  1005c2:	75 ea                	jne    1005ae <console_clear+0xe>
  1005c4:	be d4 03 00 00       	mov    $0x3d4,%esi
  1005c9:	b0 0e                	mov    $0xe,%al
  1005cb:	89 f2                	mov    %esi,%edx
  1005cd:	ee                   	out    %al,(%dx)
  1005ce:	31 c9                	xor    %ecx,%ecx
  1005d0:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  1005d5:	88 c8                	mov    %cl,%al
  1005d7:	89 da                	mov    %ebx,%edx
  1005d9:	ee                   	out    %al,(%dx)
  1005da:	b0 0f                	mov    $0xf,%al
  1005dc:	89 f2                	mov    %esi,%edx
  1005de:	ee                   	out    %al,(%dx)
  1005df:	88 c8                	mov    %cl,%al
  1005e1:	89 da                	mov    %ebx,%edx
  1005e3:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  1005e4:	5b                   	pop    %ebx
  1005e5:	5e                   	pop    %esi
  1005e6:	c3                   	ret    

001005e7 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  1005e7:	ba 64 00 00 00       	mov    $0x64,%edx
  1005ec:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  1005ed:	a8 01                	test   $0x1,%al
  1005ef:	74 45                	je     100636 <console_read_digit+0x4f>
  1005f1:	b2 60                	mov    $0x60,%dl
  1005f3:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  1005f4:	8d 50 fe             	lea    -0x2(%eax),%edx
  1005f7:	80 fa 08             	cmp    $0x8,%dl
  1005fa:	77 05                	ja     100601 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  1005fc:	0f b6 c0             	movzbl %al,%eax
  1005ff:	48                   	dec    %eax
  100600:	c3                   	ret    
	else if (data == 0x0B)
  100601:	3c 0b                	cmp    $0xb,%al
  100603:	74 35                	je     10063a <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100605:	8d 50 b9             	lea    -0x47(%eax),%edx
  100608:	80 fa 02             	cmp    $0x2,%dl
  10060b:	77 07                	ja     100614 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  10060d:	0f b6 c0             	movzbl %al,%eax
  100610:	83 e8 40             	sub    $0x40,%eax
  100613:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100614:	8d 50 b5             	lea    -0x4b(%eax),%edx
  100617:	80 fa 02             	cmp    $0x2,%dl
  10061a:	77 07                	ja     100623 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  10061c:	0f b6 c0             	movzbl %al,%eax
  10061f:	83 e8 47             	sub    $0x47,%eax
  100622:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  100623:	8d 50 b1             	lea    -0x4f(%eax),%edx
  100626:	80 fa 02             	cmp    $0x2,%dl
  100629:	77 07                	ja     100632 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  10062b:	0f b6 c0             	movzbl %al,%eax
  10062e:	83 e8 4e             	sub    $0x4e,%eax
  100631:	c3                   	ret    
	else if (data == 0x53)
  100632:	3c 53                	cmp    $0x53,%al
  100634:	74 04                	je     10063a <console_read_digit+0x53>
  100636:	83 c8 ff             	or     $0xffffffff,%eax
  100639:	c3                   	ret    
  10063a:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  10063c:	c3                   	ret    

0010063d <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  10063d:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100641:	a3 a0 76 10 00       	mov    %eax,0x1076a0

	asm volatile("movl %0,%%esp\n\t"
  100646:	83 c0 04             	add    $0x4,%eax
  100649:	89 c4                	mov    %eax,%esp
  10064b:	61                   	popa   
  10064c:	07                   	pop    %es
  10064d:	1f                   	pop    %ds
  10064e:	83 c4 08             	add    $0x8,%esp
  100651:	cf                   	iret   
  100652:	eb fe                	jmp    100652 <run+0x15>

00100654 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100654:	53                   	push   %ebx
  100655:	83 ec 0c             	sub    $0xc,%esp
  100658:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  10065c:	6a 44                	push   $0x44
  10065e:	6a 00                	push   $0x0
  100660:	8d 43 04             	lea    0x4(%ebx),%eax
  100663:	50                   	push   %eax
  100664:	e8 17 01 00 00       	call   100780 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100669:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  10066f:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100675:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  10067b:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  100681:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  100688:	83 c4 18             	add    $0x18,%esp
  10068b:	5b                   	pop    %ebx
  10068c:	c3                   	ret    
  10068d:	90                   	nop
  10068e:	90                   	nop
  10068f:	90                   	nop

00100690 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100690:	55                   	push   %ebp
  100691:	57                   	push   %edi
  100692:	56                   	push   %esi
  100693:	53                   	push   %ebx
  100694:	83 ec 1c             	sub    $0x1c,%esp
  100697:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  10069b:	83 f8 03             	cmp    $0x3,%eax
  10069e:	7f 04                	jg     1006a4 <program_loader+0x14>
  1006a0:	85 c0                	test   %eax,%eax
  1006a2:	79 02                	jns    1006a6 <program_loader+0x16>
  1006a4:	eb fe                	jmp    1006a4 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  1006a6:	8b 34 c5 40 10 10 00 	mov    0x101040(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  1006ad:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  1006b3:	74 02                	je     1006b7 <program_loader+0x27>
  1006b5:	eb fe                	jmp    1006b5 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1006b7:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  1006ba:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1006be:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  1006c0:	c1 e5 05             	shl    $0x5,%ebp
  1006c3:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  1006c6:	eb 3f                	jmp    100707 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  1006c8:	83 3b 01             	cmpl   $0x1,(%ebx)
  1006cb:	75 37                	jne    100704 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  1006cd:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1006d0:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  1006d3:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1006d6:	01 c7                	add    %eax,%edi
	memsz += va;
  1006d8:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  1006da:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  1006df:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  1006e3:	52                   	push   %edx
  1006e4:	89 fa                	mov    %edi,%edx
  1006e6:	29 c2                	sub    %eax,%edx
  1006e8:	52                   	push   %edx
  1006e9:	8b 53 04             	mov    0x4(%ebx),%edx
  1006ec:	01 f2                	add    %esi,%edx
  1006ee:	52                   	push   %edx
  1006ef:	50                   	push   %eax
  1006f0:	e8 27 00 00 00       	call   10071c <memcpy>
  1006f5:	83 c4 10             	add    $0x10,%esp
  1006f8:	eb 04                	jmp    1006fe <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  1006fa:	c6 07 00             	movb   $0x0,(%edi)
  1006fd:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  1006fe:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  100702:	72 f6                	jb     1006fa <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100704:	83 c3 20             	add    $0x20,%ebx
  100707:	39 eb                	cmp    %ebp,%ebx
  100709:	72 bd                	jb     1006c8 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  10070b:	8b 56 18             	mov    0x18(%esi),%edx
  10070e:	8b 44 24 34          	mov    0x34(%esp),%eax
  100712:	89 10                	mov    %edx,(%eax)
}
  100714:	83 c4 1c             	add    $0x1c,%esp
  100717:	5b                   	pop    %ebx
  100718:	5e                   	pop    %esi
  100719:	5f                   	pop    %edi
  10071a:	5d                   	pop    %ebp
  10071b:	c3                   	ret    

0010071c <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  10071c:	56                   	push   %esi
  10071d:	31 d2                	xor    %edx,%edx
  10071f:	53                   	push   %ebx
  100720:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100724:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100728:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  10072c:	eb 08                	jmp    100736 <memcpy+0x1a>
		*d++ = *s++;
  10072e:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100731:	4e                   	dec    %esi
  100732:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100735:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100736:	85 f6                	test   %esi,%esi
  100738:	75 f4                	jne    10072e <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  10073a:	5b                   	pop    %ebx
  10073b:	5e                   	pop    %esi
  10073c:	c3                   	ret    

0010073d <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  10073d:	57                   	push   %edi
  10073e:	56                   	push   %esi
  10073f:	53                   	push   %ebx
  100740:	8b 44 24 10          	mov    0x10(%esp),%eax
  100744:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100748:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  10074c:	39 c7                	cmp    %eax,%edi
  10074e:	73 26                	jae    100776 <memmove+0x39>
  100750:	8d 34 17             	lea    (%edi,%edx,1),%esi
  100753:	39 c6                	cmp    %eax,%esi
  100755:	76 1f                	jbe    100776 <memmove+0x39>
		s += n, d += n;
  100757:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  10075a:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  10075c:	eb 07                	jmp    100765 <memmove+0x28>
			*--d = *--s;
  10075e:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  100761:	4a                   	dec    %edx
  100762:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  100765:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  100766:	85 d2                	test   %edx,%edx
  100768:	75 f4                	jne    10075e <memmove+0x21>
  10076a:	eb 10                	jmp    10077c <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  10076c:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  10076f:	4a                   	dec    %edx
  100770:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  100773:	41                   	inc    %ecx
  100774:	eb 02                	jmp    100778 <memmove+0x3b>
  100776:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100778:	85 d2                	test   %edx,%edx
  10077a:	75 f0                	jne    10076c <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  10077c:	5b                   	pop    %ebx
  10077d:	5e                   	pop    %esi
  10077e:	5f                   	pop    %edi
  10077f:	c3                   	ret    

00100780 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100780:	53                   	push   %ebx
  100781:	8b 44 24 08          	mov    0x8(%esp),%eax
  100785:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100789:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  10078d:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  10078f:	eb 04                	jmp    100795 <memset+0x15>
		*p++ = c;
  100791:	88 1a                	mov    %bl,(%edx)
  100793:	49                   	dec    %ecx
  100794:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100795:	85 c9                	test   %ecx,%ecx
  100797:	75 f8                	jne    100791 <memset+0x11>
		*p++ = c;
	return v;
}
  100799:	5b                   	pop    %ebx
  10079a:	c3                   	ret    

0010079b <strlen>:

size_t
strlen(const char *s)
{
  10079b:	8b 54 24 04          	mov    0x4(%esp),%edx
  10079f:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1007a1:	eb 01                	jmp    1007a4 <strlen+0x9>
		++n;
  1007a3:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1007a4:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  1007a8:	75 f9                	jne    1007a3 <strlen+0x8>
		++n;
	return n;
}
  1007aa:	c3                   	ret    

001007ab <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  1007ab:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1007af:	31 c0                	xor    %eax,%eax
  1007b1:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1007b5:	eb 01                	jmp    1007b8 <strnlen+0xd>
		++n;
  1007b7:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1007b8:	39 d0                	cmp    %edx,%eax
  1007ba:	74 06                	je     1007c2 <strnlen+0x17>
  1007bc:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  1007c0:	75 f5                	jne    1007b7 <strnlen+0xc>
		++n;
	return n;
}
  1007c2:	c3                   	ret    

001007c3 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1007c3:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  1007c4:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1007c9:	53                   	push   %ebx
  1007ca:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  1007cc:	76 05                	jbe    1007d3 <console_putc+0x10>
  1007ce:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  1007d3:	80 fa 0a             	cmp    $0xa,%dl
  1007d6:	75 2c                	jne    100804 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1007d8:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1007de:	be 50 00 00 00       	mov    $0x50,%esi
  1007e3:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  1007e5:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1007e8:	99                   	cltd   
  1007e9:	f7 fe                	idiv   %esi
  1007eb:	89 de                	mov    %ebx,%esi
  1007ed:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  1007ef:	eb 07                	jmp    1007f8 <console_putc+0x35>
			*cursor++ = ' ' | color;
  1007f1:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1007f4:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  1007f5:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1007f8:	83 f8 50             	cmp    $0x50,%eax
  1007fb:	75 f4                	jne    1007f1 <console_putc+0x2e>
  1007fd:	29 d0                	sub    %edx,%eax
  1007ff:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  100802:	eb 0b                	jmp    10080f <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100804:	0f b6 d2             	movzbl %dl,%edx
  100807:	09 ca                	or     %ecx,%edx
  100809:	66 89 13             	mov    %dx,(%ebx)
  10080c:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  10080f:	5b                   	pop    %ebx
  100810:	5e                   	pop    %esi
  100811:	c3                   	ret    

00100812 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  100812:	56                   	push   %esi
  100813:	53                   	push   %ebx
  100814:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100818:	8d 58 ff             	lea    -0x1(%eax),%ebx
  10081b:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  10081f:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100824:	75 04                	jne    10082a <fill_numbuf+0x18>
  100826:	85 d2                	test   %edx,%edx
  100828:	74 10                	je     10083a <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  10082a:	89 d0                	mov    %edx,%eax
  10082c:	31 d2                	xor    %edx,%edx
  10082e:	f7 f1                	div    %ecx
  100830:	4b                   	dec    %ebx
  100831:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100834:	88 13                	mov    %dl,(%ebx)
			val /= base;
  100836:	89 c2                	mov    %eax,%edx
  100838:	eb ec                	jmp    100826 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  10083a:	89 d8                	mov    %ebx,%eax
  10083c:	5b                   	pop    %ebx
  10083d:	5e                   	pop    %esi
  10083e:	c3                   	ret    

0010083f <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  10083f:	55                   	push   %ebp
  100840:	57                   	push   %edi
  100841:	56                   	push   %esi
  100842:	53                   	push   %ebx
  100843:	83 ec 38             	sub    $0x38,%esp
  100846:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  10084a:	8b 7c 24 54          	mov    0x54(%esp),%edi
  10084e:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100852:	e9 60 03 00 00       	jmp    100bb7 <console_vprintf+0x378>
		if (*format != '%') {
  100857:	80 fa 25             	cmp    $0x25,%dl
  10085a:	74 13                	je     10086f <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  10085c:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100860:	0f b6 d2             	movzbl %dl,%edx
  100863:	89 f0                	mov    %esi,%eax
  100865:	e8 59 ff ff ff       	call   1007c3 <console_putc>
  10086a:	e9 45 03 00 00       	jmp    100bb4 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10086f:	47                   	inc    %edi
  100870:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  100877:	00 
  100878:	eb 12                	jmp    10088c <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  10087a:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  10087b:	8a 11                	mov    (%ecx),%dl
  10087d:	84 d2                	test   %dl,%dl
  10087f:	74 1a                	je     10089b <console_vprintf+0x5c>
  100881:	89 e8                	mov    %ebp,%eax
  100883:	38 c2                	cmp    %al,%dl
  100885:	75 f3                	jne    10087a <console_vprintf+0x3b>
  100887:	e9 3f 03 00 00       	jmp    100bcb <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10088c:	8a 17                	mov    (%edi),%dl
  10088e:	84 d2                	test   %dl,%dl
  100890:	74 0b                	je     10089d <console_vprintf+0x5e>
  100892:	b9 20 0c 10 00       	mov    $0x100c20,%ecx
  100897:	89 d5                	mov    %edx,%ebp
  100899:	eb e0                	jmp    10087b <console_vprintf+0x3c>
  10089b:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  10089d:	8d 42 cf             	lea    -0x31(%edx),%eax
  1008a0:	3c 08                	cmp    $0x8,%al
  1008a2:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1008a9:	00 
  1008aa:	76 13                	jbe    1008bf <console_vprintf+0x80>
  1008ac:	eb 1d                	jmp    1008cb <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  1008ae:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  1008b3:	0f be c0             	movsbl %al,%eax
  1008b6:	47                   	inc    %edi
  1008b7:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  1008bb:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  1008bf:	8a 07                	mov    (%edi),%al
  1008c1:	8d 50 d0             	lea    -0x30(%eax),%edx
  1008c4:	80 fa 09             	cmp    $0x9,%dl
  1008c7:	76 e5                	jbe    1008ae <console_vprintf+0x6f>
  1008c9:	eb 18                	jmp    1008e3 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  1008cb:	80 fa 2a             	cmp    $0x2a,%dl
  1008ce:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  1008d5:	ff 
  1008d6:	75 0b                	jne    1008e3 <console_vprintf+0xa4>
			width = va_arg(val, int);
  1008d8:	83 c3 04             	add    $0x4,%ebx
			++format;
  1008db:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1008dc:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1008df:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1008e3:	83 cd ff             	or     $0xffffffff,%ebp
  1008e6:	80 3f 2e             	cmpb   $0x2e,(%edi)
  1008e9:	75 37                	jne    100922 <console_vprintf+0xe3>
			++format;
  1008eb:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  1008ec:	31 ed                	xor    %ebp,%ebp
  1008ee:	8a 07                	mov    (%edi),%al
  1008f0:	8d 50 d0             	lea    -0x30(%eax),%edx
  1008f3:	80 fa 09             	cmp    $0x9,%dl
  1008f6:	76 0d                	jbe    100905 <console_vprintf+0xc6>
  1008f8:	eb 17                	jmp    100911 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  1008fa:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  1008fd:	0f be c0             	movsbl %al,%eax
  100900:	47                   	inc    %edi
  100901:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100905:	8a 07                	mov    (%edi),%al
  100907:	8d 50 d0             	lea    -0x30(%eax),%edx
  10090a:	80 fa 09             	cmp    $0x9,%dl
  10090d:	76 eb                	jbe    1008fa <console_vprintf+0xbb>
  10090f:	eb 11                	jmp    100922 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  100911:	3c 2a                	cmp    $0x2a,%al
  100913:	75 0b                	jne    100920 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100915:	83 c3 04             	add    $0x4,%ebx
				++format;
  100918:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100919:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  10091c:	85 ed                	test   %ebp,%ebp
  10091e:	79 02                	jns    100922 <console_vprintf+0xe3>
  100920:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  100922:	8a 07                	mov    (%edi),%al
  100924:	3c 64                	cmp    $0x64,%al
  100926:	74 34                	je     10095c <console_vprintf+0x11d>
  100928:	7f 1d                	jg     100947 <console_vprintf+0x108>
  10092a:	3c 58                	cmp    $0x58,%al
  10092c:	0f 84 a2 00 00 00    	je     1009d4 <console_vprintf+0x195>
  100932:	3c 63                	cmp    $0x63,%al
  100934:	0f 84 bf 00 00 00    	je     1009f9 <console_vprintf+0x1ba>
  10093a:	3c 43                	cmp    $0x43,%al
  10093c:	0f 85 d0 00 00 00    	jne    100a12 <console_vprintf+0x1d3>
  100942:	e9 a3 00 00 00       	jmp    1009ea <console_vprintf+0x1ab>
  100947:	3c 75                	cmp    $0x75,%al
  100949:	74 4d                	je     100998 <console_vprintf+0x159>
  10094b:	3c 78                	cmp    $0x78,%al
  10094d:	74 5c                	je     1009ab <console_vprintf+0x16c>
  10094f:	3c 73                	cmp    $0x73,%al
  100951:	0f 85 bb 00 00 00    	jne    100a12 <console_vprintf+0x1d3>
  100957:	e9 86 00 00 00       	jmp    1009e2 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  10095c:	83 c3 04             	add    $0x4,%ebx
  10095f:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  100962:	89 d1                	mov    %edx,%ecx
  100964:	c1 f9 1f             	sar    $0x1f,%ecx
  100967:	89 0c 24             	mov    %ecx,(%esp)
  10096a:	31 ca                	xor    %ecx,%edx
  10096c:	55                   	push   %ebp
  10096d:	29 ca                	sub    %ecx,%edx
  10096f:	68 28 0c 10 00       	push   $0x100c28
  100974:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100979:	8d 44 24 40          	lea    0x40(%esp),%eax
  10097d:	e8 90 fe ff ff       	call   100812 <fill_numbuf>
  100982:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  100986:	58                   	pop    %eax
  100987:	5a                   	pop    %edx
  100988:	ba 01 00 00 00       	mov    $0x1,%edx
  10098d:	8b 04 24             	mov    (%esp),%eax
  100990:	83 e0 01             	and    $0x1,%eax
  100993:	e9 a5 00 00 00       	jmp    100a3d <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100998:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  10099b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1009a0:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009a3:	55                   	push   %ebp
  1009a4:	68 28 0c 10 00       	push   $0x100c28
  1009a9:	eb 11                	jmp    1009bc <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  1009ab:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  1009ae:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009b1:	55                   	push   %ebp
  1009b2:	68 3c 0c 10 00       	push   $0x100c3c
  1009b7:	b9 10 00 00 00       	mov    $0x10,%ecx
  1009bc:	8d 44 24 40          	lea    0x40(%esp),%eax
  1009c0:	e8 4d fe ff ff       	call   100812 <fill_numbuf>
  1009c5:	ba 01 00 00 00       	mov    $0x1,%edx
  1009ca:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1009ce:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  1009d0:	59                   	pop    %ecx
  1009d1:	59                   	pop    %ecx
  1009d2:	eb 69                	jmp    100a3d <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  1009d4:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  1009d7:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009da:	55                   	push   %ebp
  1009db:	68 28 0c 10 00       	push   $0x100c28
  1009e0:	eb d5                	jmp    1009b7 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  1009e2:	83 c3 04             	add    $0x4,%ebx
  1009e5:	8b 43 fc             	mov    -0x4(%ebx),%eax
  1009e8:	eb 40                	jmp    100a2a <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  1009ea:	83 c3 04             	add    $0x4,%ebx
  1009ed:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009f0:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  1009f4:	e9 bd 01 00 00       	jmp    100bb6 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  1009f9:	83 c3 04             	add    $0x4,%ebx
  1009fc:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  1009ff:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100a03:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100a08:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100a0c:	88 44 24 24          	mov    %al,0x24(%esp)
  100a10:	eb 27                	jmp    100a39 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  100a12:	84 c0                	test   %al,%al
  100a14:	75 02                	jne    100a18 <console_vprintf+0x1d9>
  100a16:	b0 25                	mov    $0x25,%al
  100a18:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100a1c:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100a21:	80 3f 00             	cmpb   $0x0,(%edi)
  100a24:	74 0a                	je     100a30 <console_vprintf+0x1f1>
  100a26:	8d 44 24 24          	lea    0x24(%esp),%eax
  100a2a:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a2e:	eb 09                	jmp    100a39 <console_vprintf+0x1fa>
				format--;
  100a30:	8d 54 24 24          	lea    0x24(%esp),%edx
  100a34:	4f                   	dec    %edi
  100a35:	89 54 24 04          	mov    %edx,0x4(%esp)
  100a39:	31 d2                	xor    %edx,%edx
  100a3b:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100a3d:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100a3f:	83 fd ff             	cmp    $0xffffffff,%ebp
  100a42:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100a49:	74 1f                	je     100a6a <console_vprintf+0x22b>
  100a4b:	89 04 24             	mov    %eax,(%esp)
  100a4e:	eb 01                	jmp    100a51 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100a50:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100a51:	39 e9                	cmp    %ebp,%ecx
  100a53:	74 0a                	je     100a5f <console_vprintf+0x220>
  100a55:	8b 44 24 04          	mov    0x4(%esp),%eax
  100a59:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100a5d:	75 f1                	jne    100a50 <console_vprintf+0x211>
  100a5f:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100a62:	89 0c 24             	mov    %ecx,(%esp)
  100a65:	eb 1f                	jmp    100a86 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100a67:	42                   	inc    %edx
  100a68:	eb 09                	jmp    100a73 <console_vprintf+0x234>
  100a6a:	89 d1                	mov    %edx,%ecx
  100a6c:	8b 14 24             	mov    (%esp),%edx
  100a6f:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100a73:	8b 44 24 04          	mov    0x4(%esp),%eax
  100a77:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100a7b:	75 ea                	jne    100a67 <console_vprintf+0x228>
  100a7d:	8b 44 24 08          	mov    0x8(%esp),%eax
  100a81:	89 14 24             	mov    %edx,(%esp)
  100a84:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100a86:	85 c0                	test   %eax,%eax
  100a88:	74 0c                	je     100a96 <console_vprintf+0x257>
  100a8a:	84 d2                	test   %dl,%dl
  100a8c:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100a93:	00 
  100a94:	75 24                	jne    100aba <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100a96:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100a9b:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100aa2:	00 
  100aa3:	75 15                	jne    100aba <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100aa5:	8b 44 24 14          	mov    0x14(%esp),%eax
  100aa9:	83 e0 08             	and    $0x8,%eax
  100aac:	83 f8 01             	cmp    $0x1,%eax
  100aaf:	19 c9                	sbb    %ecx,%ecx
  100ab1:	f7 d1                	not    %ecx
  100ab3:	83 e1 20             	and    $0x20,%ecx
  100ab6:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100aba:	3b 2c 24             	cmp    (%esp),%ebp
  100abd:	7e 0d                	jle    100acc <console_vprintf+0x28d>
  100abf:	84 d2                	test   %dl,%dl
  100ac1:	74 40                	je     100b03 <console_vprintf+0x2c4>
			zeros = precision - len;
  100ac3:	2b 2c 24             	sub    (%esp),%ebp
  100ac6:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100aca:	eb 3f                	jmp    100b0b <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100acc:	84 d2                	test   %dl,%dl
  100ace:	74 33                	je     100b03 <console_vprintf+0x2c4>
  100ad0:	8b 44 24 14          	mov    0x14(%esp),%eax
  100ad4:	83 e0 06             	and    $0x6,%eax
  100ad7:	83 f8 02             	cmp    $0x2,%eax
  100ada:	75 27                	jne    100b03 <console_vprintf+0x2c4>
  100adc:	45                   	inc    %ebp
  100add:	75 24                	jne    100b03 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100adf:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100ae1:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100ae4:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100ae9:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100aec:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100aef:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100af3:	7d 0e                	jge    100b03 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100af5:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100af9:	29 ca                	sub    %ecx,%edx
  100afb:	29 c2                	sub    %eax,%edx
  100afd:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b01:	eb 08                	jmp    100b0b <console_vprintf+0x2cc>
  100b03:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100b0a:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b0b:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100b0f:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b11:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b15:	2b 2c 24             	sub    (%esp),%ebp
  100b18:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b1d:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b20:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b23:	29 c5                	sub    %eax,%ebp
  100b25:	89 f0                	mov    %esi,%eax
  100b27:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b2b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100b2f:	eb 0f                	jmp    100b40 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100b31:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b35:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b3a:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100b3b:	e8 83 fc ff ff       	call   1007c3 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b40:	85 ed                	test   %ebp,%ebp
  100b42:	7e 07                	jle    100b4b <console_vprintf+0x30c>
  100b44:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100b49:	74 e6                	je     100b31 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100b4b:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b50:	89 c6                	mov    %eax,%esi
  100b52:	74 23                	je     100b77 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100b54:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100b59:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b5d:	e8 61 fc ff ff       	call   1007c3 <console_putc>
  100b62:	89 c6                	mov    %eax,%esi
  100b64:	eb 11                	jmp    100b77 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100b66:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b6a:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100b6f:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100b70:	e8 4e fc ff ff       	call   1007c3 <console_putc>
  100b75:	eb 06                	jmp    100b7d <console_vprintf+0x33e>
  100b77:	89 f0                	mov    %esi,%eax
  100b79:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100b7d:	85 f6                	test   %esi,%esi
  100b7f:	7f e5                	jg     100b66 <console_vprintf+0x327>
  100b81:	8b 34 24             	mov    (%esp),%esi
  100b84:	eb 15                	jmp    100b9b <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100b86:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100b8a:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100b8b:	0f b6 11             	movzbl (%ecx),%edx
  100b8e:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b92:	e8 2c fc ff ff       	call   1007c3 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100b97:	ff 44 24 04          	incl   0x4(%esp)
  100b9b:	85 f6                	test   %esi,%esi
  100b9d:	7f e7                	jg     100b86 <console_vprintf+0x347>
  100b9f:	eb 0f                	jmp    100bb0 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100ba1:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100ba5:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100baa:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100bab:	e8 13 fc ff ff       	call   1007c3 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100bb0:	85 ed                	test   %ebp,%ebp
  100bb2:	7f ed                	jg     100ba1 <console_vprintf+0x362>
  100bb4:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100bb6:	47                   	inc    %edi
  100bb7:	8a 17                	mov    (%edi),%dl
  100bb9:	84 d2                	test   %dl,%dl
  100bbb:	0f 85 96 fc ff ff    	jne    100857 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100bc1:	83 c4 38             	add    $0x38,%esp
  100bc4:	89 f0                	mov    %esi,%eax
  100bc6:	5b                   	pop    %ebx
  100bc7:	5e                   	pop    %esi
  100bc8:	5f                   	pop    %edi
  100bc9:	5d                   	pop    %ebp
  100bca:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100bcb:	81 e9 20 0c 10 00    	sub    $0x100c20,%ecx
  100bd1:	b8 01 00 00 00       	mov    $0x1,%eax
  100bd6:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100bd8:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100bd9:	09 44 24 14          	or     %eax,0x14(%esp)
  100bdd:	e9 aa fc ff ff       	jmp    10088c <console_vprintf+0x4d>

00100be2 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100be2:	8d 44 24 10          	lea    0x10(%esp),%eax
  100be6:	50                   	push   %eax
  100be7:	ff 74 24 10          	pushl  0x10(%esp)
  100beb:	ff 74 24 10          	pushl  0x10(%esp)
  100bef:	ff 74 24 10          	pushl  0x10(%esp)
  100bf3:	e8 47 fc ff ff       	call   10083f <console_vprintf>
  100bf8:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100bfb:	c3                   	ret    
