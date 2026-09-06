local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SEnter = dataclass("SEnter", require("framework.net.protocol"))
SEnter.ProtocolType = 2202
SEnter.MaxSize = 655350

function SEnter:Ctor(client)
  SEnter.super.Ctor(self, client)
  self.userInfo = require("protocols.bean.protocol.user.userinfo").Create()
  self.bags = {}
end

function SEnter:Marshal(buffer)
  if not self.userInfo:Marshal(buffer) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.bags)) then
    return false
  end
  for key, value in pairs(self.bags) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SEnter:Unmarshal(buffer)
  local ret = true
  if not self.userInfo:Unmarshal(buffer) then
    return false
  end
  local length, key, value = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key, value = nil, nil
    ret, key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    value = require("protocols.bean.protocol.item.beans.bag").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.bags[key] = value
  end
  return ret
end

return SEnter
