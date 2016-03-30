
obj/schedos-1:     file format elf32-i386


Disassembly of section .text:

00200000 <start>:
// #define __EXERCISE_8__


void
start(void)
{
  200000:	31 d2                	xor    %edx,%edx
}

static inline void
sys_atomic_char(int cursorChar)
{
	asm volatile("int %0\n"
  200002:	b8 31 0c 00 00       	mov    $0xc31,%eax
  200007:	cd 34                	int    $0x34
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  200009:	42                   	inc    %edx
  20000a:	81 fa 40 01 00 00    	cmp    $0x140,%edx
  200010:	75 f5                	jne    200007 <start+0x7>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  200012:	31 c0                	xor    %eax,%eax
  200014:	cd 31                	int    $0x31
  200016:	eb fe                	jmp    200016 <start+0x16>
