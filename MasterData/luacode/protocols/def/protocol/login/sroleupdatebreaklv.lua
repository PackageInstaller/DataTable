local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRoleUpdateBreakLv = dataclass("SRoleUpdateBreakLv", require("framework.net.protocol"))
SRoleUpdateBreakLv.ProtocolType = 1017
SRoleUpdateBreakLv.MaxSize = 65535
SRoleUpdateBreakLv.roleId = 0
SRoleUpdateBreakLv.breakLv = 0
SRoleUpdateBreakLv.gainSkin = 0
SRoleUpdateBreakLv.breakType = 0

function SRoleUpdateBreakLv:Ctor(client)
  SRoleUpdateBreakLv.super.Ctor(self, client)
  self.passiveskill = {}
end

function SRoleUpdateBreakLv:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.roleId) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt16(buffer, self.breakLv) then
    return false
  end
  local length = table.slen(self.passiveskill)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.passiveskill[i]:Marshal(buffer) then
      return false
    end
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.gainSkin) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.breakType) then
    return false
  end
  return true
end

function SRoleUpdateBreakLv:Unmarshal(buffer)
  local ret = true
  ret, self.roleId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.breakLv = ProtocolBufferStaticFunctions.ReadInt16(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.passiveskill[i] = require("protocols.bean.protocol.login.passiveskill").Create()
    if not self.passiveskill[i]:Unmarshal(buffer) then
      return false
    end
  end
  ret, self.gainSkin = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.breakType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SRoleUpdateBreakLv
