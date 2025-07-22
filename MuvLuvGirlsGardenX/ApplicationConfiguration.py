import struct
import sys
import os

class BinaryParser:

    def __init__(self, data: bytes):
        self.data = data
        self.offset = 0

    def _align(self):
        """将当前偏移量移动到最近的4字节边界。"""
        self.offset = (self.offset + 3) & ~3

    def read_int(self) -> int:
        """读取一个4字节的小端序整数。"""
        val = struct.unpack('<i', self.data[self.offset:self.offset+4])[0]
        self.offset += 4
        return val

    def read_long(self) -> int:
        """读取一个8字节的小端序长整数。"""
        val = struct.unpack('<q', self.data[self.offset:self.offset+8])[0]
        self.offset += 8
        return val

    def read_bool(self) -> bool:
        """读取一个1字节的布尔值，然后对齐。"""
        val = self.data[self.offset] != 0
        self.offset += 1
        self._align()
        return val

    def read_string(self) -> str:
        """读取一个Unity标准的长度前缀字符串。"""
        length = self.read_int()
        if not (0 <= length <= len(self.data) - self.offset):
            return f"[错误：无效或过长的字符串长度 {length}]"
        
        string_data = self.data[self.offset : self.offset + length]
        self.offset += length
        self._align()
        
        return string_data.decode('utf-8', errors='ignore')

def parse():

    with open("3760a0d964c927a40a0f991ebe420461", 'rb') as f:
        raw_bytes = f.read()
    parser = BinaryParser(raw_bytes)
    parser.offset = 0x10C


    config = {
        "GameRating": parser.read_int(),
        "DisplayVersion": parser.read_string(),
        "VersionCode": parser.read_int(),
        "GamePlatform": parser.read_int(),
        "GameEnvironment": parser.read_int(),
        "ServerEnvironmentUrl": parser.read_string(),
        "InstanceLifetime": parser.read_int(),
        "InstanceQuantityAllowance": parser.read_int(),
        "IsSandbox": parser.read_bool(),
        "DmmNormalApplicationId": parser.read_string(),
        "DmmRatedApplicationId": parser.read_string(),
        "GooglePlayApplicationId": parser.read_string(),
        "dmmWebglXApplicationId": parser.read_long(),
        "dmmWebglApplicationId": parser.read_long(),
        "dmmWebglXIAPToken": parser.read_string(),
        "dmmWebglIAPToken": parser.read_string(),
        "dmmAndroidXApplicationId": parser.read_string(),
        "dmmAndroidApplicationId": parser.read_string(),
        "dmmAndroidXIAPToken": parser.read_string(),
        "dmmAndroidIAPToken": parser.read_string(),
        "dmmClientXIAPToken": parser.read_string(),
        "dmmClientIAPToken": parser.read_string(),
        "dmmAndroidXConsumerKey": parser.read_string(),
        "dmmAndroidXConsumerSecret": parser.read_string(),
        "dmmAndroidConsumerKey": parser.read_string(),
        "dmmAndroidConsumerSecret": parser.read_string(),
        "appsFlyerAndroidDevKey": parser.read_string(), # 这里到后面的还没填进去所以是空的
        "appsFlyerIOSDevKey": parser.read_string(),
        "appsFlyerIOSAppId": parser.read_string(),
        "azureApplicationInsightsInstrumentationKey": parser.read_string(),
    }

    for key, value in config.items():
        print(f"{key}: {value}")

if __name__ == "__main__":
    parse()