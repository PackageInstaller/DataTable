-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/stransaction.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local STransaction = dataclass("STransaction", require("framework.net.protocol"))
STransaction.ProtocolType = 1942
STransaction.MaxSize = 65535
STransaction.kind = 0
STransaction.value = 0
STransaction.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : STransaction
  ((STransaction.super).Ctor)(self, client)
end

STransaction.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.kind) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.value) then
    return false
  end
  return true
end

STransaction.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return STransaction

