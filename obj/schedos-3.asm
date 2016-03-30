
obj/schedos-3:     file format elf32-i386


Disassembly of section .text:

00400000 <start>:
// #define __EXERCISE_8__


void
start(void)
{
  400000:	31 d2                	xor    %edx,%edx
}

static inline void
sys_atomic_char(int cursorChar)
{
	asm volatile("int %0\n"
  400002:	b8 33 09 00 00       	mov    $0x933,%eax
  400007:	cd 34                	int    $0x34
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  400009:	42                   	inc    %edx
  40000a:	81 fa 40 01 00 00    	cmp    $0x140,%edx
  400010:	75 f5                	jne    400007 <start+0x7>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  400012:	31 c0                	xor    %eax,%eax
  400014:	cd 31                	int    $0x31
  400016:	eb fe                	jmp    400016 <start+0x16>
