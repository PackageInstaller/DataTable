local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CAddTheme = dataclass("CAddTheme", require("framework.net.protocol"))
CAddTheme.ProtocolType = 2361
CAddTheme.MaxSize = 65535
CAddTheme.name = ""

function CAddTheme:Ctor(client)
  CAddTheme.super.Ctor(self, client)
  self.furniture = {}
end

function CAddTheme:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteProtocolString(buffer, self.name) then
    return false
  end
  local length = table.slen(self.furniture)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.furniture[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function CAddTheme:Unmarshal(buffer)
  local ret = true
  ret, self.name = ProtocolBufferStaticFunctions.ReadProtocolString(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.furniture[i] = require("protocols.bean.protocol.yard.furnitureposition").Create()
    if not self.furniture[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return CAddTheme
