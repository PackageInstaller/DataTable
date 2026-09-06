local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local CGetEquipChestInfo = dataclass("CGetEquipChestInfo", require("framework.net.protocol"))
CGetEquipChestInfo.ProtocolType = 3635
CGetEquipChestInfo.MaxSize = 65535
CGetEquipChestInfo.chestID = 0

function CGetEquipChestInfo:Ctor(client)
  CGetEquipChestInfo.super.Ctor(self, client)
end

function CGetEquipChestInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.chestID) then
    return false
  end
  return true
end

function CGetEquipChestInfo:Unmarshal(buffer)
  local ret = true
  ret, self.chestID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetEquipChestInfo
