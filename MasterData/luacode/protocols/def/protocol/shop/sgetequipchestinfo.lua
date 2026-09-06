local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local SGetEquipChestInfo = dataclass("SGetEquipChestInfo", require("framework.net.protocol"))
SGetEquipChestInfo.ProtocolType = 3636
SGetEquipChestInfo.MaxSize = 65535
SGetEquipChestInfo.chestID = 0
SGetEquipChestInfo.realBox = 0
SGetEquipChestInfo.currencyType = 0
SGetEquipChestInfo.price = 0
SGetEquipChestInfo.ddlTime = 0
SGetEquipChestInfo.remainChance = 0

function SGetEquipChestInfo:Ctor(client)
  SGetEquipChestInfo.super.Ctor(self, client)
end

function SGetEquipChestInfo:Marshal(buffer)
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.chestID) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.realBox) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.currencyType) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.price) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt64(buffer, self.ddlTime) then
    return false
  end
  if not ProtocolBufferStaticFunctions.WriteInt32(buffer, self.remainChance) then
    return false
  end
  return true
end

function SGetEquipChestInfo:Unmarshal(buffer)
  local ret = true
  ret, self.chestID = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.realBox = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.currencyType = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.price = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  ret, self.ddlTime = ProtocolBufferStaticFunctions.ReadInt64(buffer)
  if not ret then
    return ret
  end
  ret, self.remainChance = ProtocolBufferStaticFunctions.ReadInt32(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SGetEquipChestInfo
