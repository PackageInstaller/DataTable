local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetSkinOverview = dataclass("SGetSkinOverview", require("framework.net.protocol"))
SGetSkinOverview.ProtocolType = 1269
SGetSkinOverview.MaxSize = 65535

function SGetSkinOverview:Ctor(client)
  SGetSkinOverview.super.Ctor(self, client)
  self.skins = {}
end

function SGetSkinOverview:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteCompactUInt32(buffer, table.nums(self.skins)) then
    return false
  end
  for key, value in pairs(self.skins) do
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, key) then
      return false
    end
    if not ProtocolBufferStaticFunctions.WriteInt32(buffer, value) then
      return false
    end
  end
  return true
end

function SGetSkinOverview:Unmarshal(buffer)
  local ret = true
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
    ret, value = ProtocolBufferStaticFunctions.ReadInt32(buffer)
    if not ret then
      return ret
    end
    self.skins[key] = value
  end
  return ret
end

return SGetSkinOverview
