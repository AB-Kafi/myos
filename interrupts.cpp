

#include "interrupts.h"
#include "port.h"
#include "types.h"

void SetInterruptDescriptorTableEntry(uint8_t interruptNumber,
                                      uint16_t codeSegmentSelectorOffset,
                                      void (*handler)(),
                                      uint8_t DescriptorPrivilegeLevel,
                                      uint8_t DescriptorType) {}

InterruptManager(GlobalDescriptorTable *gdt) {}
~InterruptManager() {}

void printf(const char *str);

uint32_t handleInterrupt(uint8_t interruptNumber, uint32_t esp) {
  printf("interrupt");
  return esp;
}
