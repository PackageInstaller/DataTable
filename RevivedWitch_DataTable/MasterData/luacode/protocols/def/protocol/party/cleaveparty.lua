-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/party/cleaveparty.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CLeaveParty = dataclass("CLeaveParty", require("framework.net.protocol"))
CLeaveParty.ProtocolType = 5017
CLeaveParty.MaxSize = 65535
CLeaveParty.partyId = 0
CLeaveParty.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CLeaveParty
  ((CLeaveParty.super).Ctor)(self, client)
end

CLeaveParty.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.partyId) then
    return false
  end
  return true
end

CLeaveParty.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CLeaveParty

