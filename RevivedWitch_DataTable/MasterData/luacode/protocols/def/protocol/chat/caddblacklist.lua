-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/caddblacklist.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CAddBlackList = dataclass("CAddBlackList", require("framework.net.protocol"))
CAddBlackList.ProtocolType = 1126
CAddBlackList.MaxSize = 65535
CAddBlackList.userId = 0
CAddBlackList.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CAddBlackList
  ((CAddBlackList.super).Ctor)(self, client)
end

CAddBlackList.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.userId) then
    return false
  end
  return true
end

CAddBlackList.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CAddBlackList

