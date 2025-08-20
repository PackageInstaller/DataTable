import os
import struct
import csv

def decrypt(data, key="ryrs".encode('utf-8')):
    if not data:
        return b''
    dec = bytearray(len(data))
    kl = len(key)
    for i in range(len(data)):
        dec[i] = data[i] ^ key[i % kl]
    return bytes(dec)

class DotNetBinaryReader:
    def __init__(self, data):
        self.data = data
        self.index = 0

    def _read_7bit_encoded_int(self):
        v = 0
        s = 0
        while True:
            b = self.data[self.index]
            self.index += 1
            v |= (b & 0x7F) << s
            if (b & 0x80) == 0:
                return v
            s += 7

    def read_string(self):
        l = self._read_7bit_encoded_int()
        s = self.data[self.index : self.index + l]
        self.index += l
        return s.decode('utf-8', errors='ignore')

    def parse_table(self):
        rc = struct.unpack_from('<I', self.data, self.index)[0]
        self.index += 4
        cc = struct.unpack_from('<I', self.data, self.index)[0]
        self.index += 4
        ar = []
        for i in range(rc):
            r = []
            for _ in range(cc):
                r.append(self.read_string())
            ar.append(r)
        h = ar[0] if ar else []
        dr = ar[1:] if len(ar) > 1 else []
        
        return h, dr, rc, cc

def process(id, od):
    pc = 0
    for ro, _, files in os.walk(id):
        for fn in files:
            if fn.endswith(".txt"):
                ip = os.path.join(ro, fn)
                ood = os.path.join(od, os.path.relpath(ro, id))
                os.makedirs(ood, exist_ok=True)
                of = os.path.splitext(fn)[0] + '.csv'
                op = os.path.join(ood, of)
                with open(ip, 'rb') as f_in:
                    enc = f_in.read()
                h, r, rc, cc = DotNetBinaryReader(decrypt(enc)).parse_table()
                with open(op, 'w', newline='', encoding='utf-8-sig') as f_out:
                    w = csv.writer(f_out)
                    w.writerow(h)
                    w.writerows(r)
                pc += 1

if __name__ == "__main__":
    process("Table", "MasterData")