local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CPreviewEquipAttrs = dataclass("CPreviewEquipAttrs", require("framework.net.protocol"))
CPreviewEquipAttrs.ProtocolType = 1238
CPreviewEquipAttrs.MaxSize = 65535
CPreviewEquipAttrs.key = 0

function CPreviewEquipAttrs:Ctor(client)
  CPreviewEquipAttrs.super.Ctor(self, client)
end

function CPreviewEquipAttrs:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.key) then
    return false
  end
  return true
end

function CPreviewEquipAttrs:Unmarshal(buffer)
  local ret = true
  ret, self.key = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CPreviewEquipAttrs
