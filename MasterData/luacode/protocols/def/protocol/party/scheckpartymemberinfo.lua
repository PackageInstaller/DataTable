local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCheckPartyMemberInfo = dataclass("SCheckPartyMemberInfo", require("framework.net.protocol"))
SCheckPartyMemberInfo.ProtocolType = 5009
SCheckPartyMemberInfo.MaxSize = 65535

function SCheckPartyMemberInfo:Ctor(client)
  SCheckPartyMemberInfo.super.Ctor(self, client)
  self.allMember = {}
end

function SCheckPartyMemberInfo:Marshal(buffer)
  local length = table.slen(self.allMember)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.allMember[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SCheckPartyMemberInfo:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.allMember[i] = require("protocols.bean.protocol.party.memberinfo").Create()
    if not self.allMember[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SCheckPartyMemberInfo
