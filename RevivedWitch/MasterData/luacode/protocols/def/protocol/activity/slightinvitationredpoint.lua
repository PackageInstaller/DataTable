-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/slightinvitationredpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SLightInvitationRedPoint = dataclass("SLightInvitationRedPoint", require("framework.net.protocol"))
SLightInvitationRedPoint.ProtocolType = 2464
SLightInvitationRedPoint.MaxSize = 65535
SLightInvitationRedPoint.weekshare = 1
SLightInvitationRedPoint.award = 2
SLightInvitationRedPoint.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SLightInvitationRedPoint
  ((SLightInvitationRedPoint.super).Ctor)(self, client)
  self.redpoint = {}
end

SLightInvitationRedPoint.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.redpoint)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.redpoint)[i]) then
      return false
    end
  end
  return true
end

SLightInvitationRedPoint.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R8 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SLightInvitationRedPoint

