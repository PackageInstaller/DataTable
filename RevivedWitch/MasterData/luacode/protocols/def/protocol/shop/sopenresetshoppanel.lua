-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/sopenresetshoppanel.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOpenResetShopPanel = dataclass("SOpenResetShopPanel", require("framework.net.protocol"))
SOpenResetShopPanel.ProtocolType = 3625
SOpenResetShopPanel.MaxSize = 65535
SOpenResetShopPanel.shoptype = 0
SOpenResetShopPanel.leftChance = 0
SOpenResetShopPanel.currencyType = 0
SOpenResetShopPanel.nextTimeCost = 0
SOpenResetShopPanel.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOpenResetShopPanel
  ((SOpenResetShopPanel.super).Ctor)(self, client)
end

SOpenResetShopPanel.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.shoptype) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.leftChance) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.currencyType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.nextTimeCost) then
    return false
  end
  return true
end

SOpenResetShopPanel.Unmarshal = function(self, buffer)
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
  return ret
end

return SOpenResetShopPanel

