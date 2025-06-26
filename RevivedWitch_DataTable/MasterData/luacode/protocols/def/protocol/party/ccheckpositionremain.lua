-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/ccheckpositionremain.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CCheckPositionRemain = dataclass("CCheckPositionRemain", require("framework.net.protocol"))
CCheckPositionRemain.ProtocolType = 5024
CCheckPositionRemain.MaxSize = 65535
CCheckPositionRemain.partyId = 0
CCheckPositionRemain.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CCheckPositionRemain
  ((CCheckPositionRemain.super).Ctor)(self, client)
end

CCheckPositionRemain.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.partyId) then
    return false
  end
  return true
end

CCheckPositionRemain.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCheckPositionRemain

