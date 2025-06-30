-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/user/ssendmailcode.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSendMailCode = dataclass("SSendMailCode", require("framework.net.protocol"))
SSendMailCode.ProtocolType = 2256
SSendMailCode.MaxSize = 65535
SSendMailCode.result = 0
SSendMailCode.time = 0
SSendMailCode.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSendMailCode
  ((SSendMailCode.super).Ctor)(self, client)
end

SSendMailCode.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt16)(buffer, self.result) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.time) then
    return false
  end
  return true
end

SSendMailCode.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt16)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSendMailCode

