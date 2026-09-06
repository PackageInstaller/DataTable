local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SPreviewEquipAttrs = dataclass("SPreviewEquipAttrs", require("framework.net.protocol"))
SPreviewEquipAttrs.ProtocolType = 1239
SPreviewEquipAttrs.MaxSize = 65535
SPreviewEquipAttrs.key = 0

function SPreviewEquipAttrs:Ctor(client)
  SPreviewEquipAttrs.super.Ctor(self, client)
  self.lvAttrs = {}
end

function SPreviewEquipAttrs:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.key) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.lvAttrs)) then
    return false
  end
  for key, value in pairs(self.lvAttrs) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not value:Marshal(buffer) then
      return false
    end
  end
  return true
end

function SPreviewEquipAttrs:Unmarshal(buffer)
  local ret = true
  ret, self.key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
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
    value = require("protocols.bean.protocol.item.previewattrs").Create()
    if not value:Unmarshal(buffer) then
      return false
    end
    self.lvAttrs[key] = value
  end
  return ret
end

return SPreviewEquipAttrs
