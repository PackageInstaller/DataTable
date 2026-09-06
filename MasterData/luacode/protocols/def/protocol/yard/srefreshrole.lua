local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRefreshRole = dataclass("SRefreshRole", require("framework.net.protocol"))
SRefreshRole.ProtocolType = 2317
SRefreshRole.MaxSize = 65535

function SRefreshRole:Ctor(client)
  SRefreshRole.super.Ctor(self, client)
  self.list = {}
end

function SRefreshRole:Marshal(buffer)
  local length = table.slen(self.list)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.list[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SRefreshRole:Unmarshal(buffer)
  local ret = true
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.list[i] = require("protocols.bean.protocol.login.role").Create()
    if not self.list[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SRefreshRole
