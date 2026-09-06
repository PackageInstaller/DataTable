local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SLightInvitationRedPoint = dataclass("SLightInvitationRedPoint", require("framework.net.protocol"))
SLightInvitationRedPoint.ProtocolType = 2464
SLightInvitationRedPoint.MaxSize = 65535
SLightInvitationRedPoint.weekshare = 1
SLightInvitationRedPoint.award = 2

function SLightInvitationRedPoint:Ctor(client)
  SLightInvitationRedPoint.super.Ctor(self, client)
  self.redpoint = {}
end

function SLightInvitationRedPoint:Marshal(buffer)
  local length = table.slen(self.redpoint)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.redpoint[i]) then
      return false
    end
  end
  return true
end

function SLightInvitationRedPoint:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    ret, self.redpoint[i] = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SLightInvitationRedPoint
