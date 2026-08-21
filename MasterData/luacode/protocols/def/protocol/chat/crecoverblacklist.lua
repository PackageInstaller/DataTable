-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/crecoverblacklist.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRecoverBlackList = dataclass("CRecoverBlackList", require("framework.net.protocol"))
CRecoverBlackList.ProtocolType = 1127
CRecoverBlackList.MaxSize = 65535
CRecoverBlackList.userId = 0
CRecoverBlackList.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRecoverBlackList
  ((CRecoverBlackList.super).Ctor)(self, client)
end

CRecoverBlackList.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.userId) then
    return false
  end
  return true
end

CRecoverBlackList.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CRecoverBlackList

