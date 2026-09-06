local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SCheckMemberApply = dataclass("SCheckMemberApply", require("framework.net.protocol"))
SCheckMemberApply.ProtocolType = 5011
SCheckMemberApply.MaxSize = 65535

function SCheckMemberApply:Ctor(client)
  SCheckMemberApply.super.Ctor(self, client)
  self.applyMembers = {}
end

function SCheckMemberApply:Marshal(buffer)
  local length = table.slen(self.applyMembers)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.applyMembers[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SCheckMemberApply:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.applyMembers[i] = require("protocols.bean.protocol.party.memberinfo").Create()
    if not self.applyMembers[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SCheckMemberApply
