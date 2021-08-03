#ifdef __INTERRUPTS_H
#define __INTERRUPTS_H

#include "gdt.h"
#include "port.h"
#include "types.h"

class InterruptManager {
protected:
  struct GateDescriptor {
    uint16_t handlerAddressLowBits;
    uint16_t gdt_CodeSegmentSelector;
    uint8_t reserved;
    uint8_t access;
    uint16_t handlerAddressHighBits;

  } __attribute__((packed));

  static GateDescriptor interruptDesciptorTable[256];
  static void SetInterruptDescriptorTableEntry(
      uint8_t interruptNumber, uint16_t codeSegmentSelectorOffset,
      void (*handler)(), uint8_t DescriptorPrivilegeLevel,
      uint8_t DescriptorType);

public:
  InterruptManager(GlobalDescriptorTable *gdt);
  ~InterruptManager();

  static uint32_t handleInterrupt(uint8_t interruptNumber, uint32_t esp);
  static void IgnoreInterruptRequest();
  static void HandleInterruptRequest0x00();
  static void HandleInterruptRequest0x01();
}
#endif
