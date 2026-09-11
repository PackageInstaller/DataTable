import sys, time, struct
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import cdph_vm, tdj_vm
from tdj_vm import VMLite

_vm = VMLite()
def run_vm(prog, key, buf):
    _vm.set_program(prog); _vm.set_key(key); _vm.run(buf); return buf

cdph_vm.run_vm = run_vm
import rebuild_all_dlls as R
R.run_vm = run_vm

TDJ = Path(sys.argv[1] if len(sys.argv) > 1 else "Assembly-CSharp.dll.bytes")
OUT = Path(sys.argv[2] if len(sys.argv) > 2 else "Assembly-CSharp.rebuilt.dll")

t0 = time.time()
res = R.rebuild_one(TDJ)
print("耗时 %.1fs" % (time.time()-t0))
if res is None:
    print("失败"); sys.exit(1)
data, name = res
print("模块名:", name, "输出大小:", len(data))
OUT.write_bytes(data)
print("写出:", OUT)
