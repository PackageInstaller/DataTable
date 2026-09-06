local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SRune = dataclass("SRune", require("framework.net.protocol"))
SRune.ProtocolType = 3703
SRune.MaxSize = 65535
SRune.runeId = 0

function SRune:Ctor(client)
  SRune.super.Ctor(self, client)
  self.itemList = {}
end

function SRune:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.runeId) then
    return false
  end
  local length = table.slen(self.itemList)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, length) then
    return false
  end
  for i = 1, length do
    if not self.itemList[i]:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SRune:Unmarshal(buffer)
  local ret = true
  ret, self.runeId = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret, length = ProtocolBufferStaticFunctions.ReadCompactUInt32(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    self.itemList[i] = require("protocols.bean.protocol.item.beans.iteminfo").Create()
    if not self.itemList[i]:Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SRune
