-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/ccheckmemberapply.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CCheckMemberApply = dataclass("CCheckMemberApply", require("framework.net.protocol"))
CCheckMemberApply.ProtocolType = 5010
CCheckMemberApply.MaxSize = 65535
CCheckMemberApply.partyId = 0
CCheckMemberApply.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CCheckMemberApply
  ((CCheckMemberApply.super).Ctor)(self, client)
end

CCheckMemberApply.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.partyId) then
    return false
  end
  return true
end

CCheckMemberApply.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CCheckMemberApply

