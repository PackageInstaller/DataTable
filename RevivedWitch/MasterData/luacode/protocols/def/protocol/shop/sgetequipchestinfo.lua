-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/sgetequipchestinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SGetEquipChestInfo = dataclass("SGetEquipChestInfo", require("framework.net.protocol"))
SGetEquipChestInfo.ProtocolType = 3636
SGetEquipChestInfo.MaxSize = 65535
SGetEquipChestInfo.chestID = 0
SGetEquipChestInfo.realBox = 0
SGetEquipChestInfo.currencyType = 0
SGetEquipChestInfo.price = 0
SGetEquipChestInfo.ddlTime = 0
SGetEquipChestInfo.remainChance = 0
SGetEquipChestInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SGetEquipChestInfo
  ((SGetEquipChestInfo.super).Ctor)(self, client)
end

SGetEquipChestInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.chestID) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.realBox) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.currencyType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.price) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.ddlTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.remainChance) then
    return false
  end
  return true
end

SGetEquipChestInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SGetEquipChestInfo

