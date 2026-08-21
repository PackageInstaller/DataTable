-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/mail/creceiveone.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveOne = dataclass("CReceiveOne", require("framework.net.protocol"))
CReceiveOne.ProtocolType = 1406
CReceiveOne.MaxSize = 65535
CReceiveOne.uniqueId = 0
CReceiveOne.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveOne
  ((CReceiveOne.super).Ctor)(self, client)
end

CReceiveOne.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.uniqueId) then
    return false
  end
  return true
end

CReceiveOne.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveOne

