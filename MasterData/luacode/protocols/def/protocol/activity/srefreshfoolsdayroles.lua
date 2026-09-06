local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshFoolsDayRoles = dataclass("SRefreshFoolsDayRoles", require("framework.net.protocol"))
SRefreshFoolsDayRoles.ProtocolType = 2629
SRefreshFoolsDayRoles.MaxSize = 65535

function SRefreshFoolsDayRoles:Ctor(client)
  SRefreshFoolsDayRoles.super.Ctor(self, client)
  self.roles = {}
end

function SRefreshFoolsDayRoles:Marshal(buffer)
  local length = table.slen(self.roles)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.roles[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SRefreshFoolsDayRoles:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.roles[i] = require("protocols.bean.protocol.activity.foolsdayrole").Create()
    if not self.roles[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SRefreshFoolsDayRoles
