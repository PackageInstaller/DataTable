from unicorn import Uc, UC_ARCH_ARM64, UC_MODE_ARM
from unicorn.arm64_const import (
    UC_ARM64_REG_X0, UC_ARM64_REG_X1, UC_ARM64_REG_X2,
    UC_ARM64_REG_X3, UC_ARM64_REG_X4, UC_ARM64_REG_SP, UC_ARM64_REG_LR,
)

SO = "libil2cpp.so"
VM_FUNC = 0x2CEFF80 # 自己改位置，CODEPHIL

class VMLite:
    def __init__(self, so_path=SO):
        blob = open(so_path, "rb").read()
        self.mu = Uc(UC_ARCH_ARM64, UC_MODE_ARM)
        for off, vaddr, size in ((0, 0, 229381588), (229381592, 229447128, 19550408)):
            base = vaddr & ~0xFFF
            end = (vaddr + size + 0xFFF) & ~0xFFF
            self.mu.mem_map(base, end - base)
            self.mu.mem_write(vaddr, blob[off:off + size])
        self.prog_a = 0x1000000000
        self.key_a = 0x1000100000
        self.state_a = 0x1000200000
        self.stack = 0x1000300000
        self.sent = 0x1000400000
        self.mu.mem_map(0x1000000000, 0x100000)
        self.mu.mem_map(0x1000100000, 0x100000)
        self.mu.mem_map(0x1000200000, 0x100000)
        self.mu.mem_map(0x1000300000, 0x100000)
        self.mu.mem_map(0x1000400000, 0x1000)
        self._prog = None

    def set_program(self, prog: bytes):
        self.mu.mem_write(self.prog_a, prog)
        self._prog = prog

    def set_key(self, key: bytes):
        self.mu.mem_write(self.key_a, key)

    def run(self, state: bytearray):
        mu = self.mu
        n = len(state)
        mu.mem_write(self.state_a, bytes(state))
        mu.reg_write(UC_ARM64_REG_X0, self.prog_a)
        mu.reg_write(UC_ARM64_REG_X1, len(self._prog))
        mu.reg_write(UC_ARM64_REG_X2, self.key_a)
        mu.reg_write(UC_ARM64_REG_X3, self.state_a)
        mu.reg_write(UC_ARM64_REG_X4, n)
        mu.reg_write(UC_ARM64_REG_SP, self.stack + 0x80000)
        mu.reg_write(UC_ARM64_REG_LR, self.sent)
        mu.emu_start(VM_FUNC, self.sent, count=100_000_000)
        state[:] = mu.mem_read(self.state_a, n)
        return state


def decrypt_chunked(vm: VMLite, data: bytes, key: bytes, prog: bytes, chunk=0x100) -> bytes:
    vm.set_program(prog)
    vm.set_key(key)
    buf = bytearray(data)
    for i in range(0, len(buf), chunk):
        c = buf[i:i + chunk]
        vm.run(c)
        buf[i:i + len(c)] = c
    return bytes(buf)
