-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/sbuyequipchest.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SBuyEquipChest = dataclass("SBuyEquipChest", require("framework.net.protocol"))
SBuyEquipChest.ProtocolType = 3634
SBuyEquipChest.MaxSize = 65535
SBuyEquipChest.result = 0
SBuyEquipChest.remain = 0
SBuyEquipChest.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SBuyEquipChest
  ((SBuyEquipChest.super).Ctor)(self, client)
  self.equipments = {}
end

SBuyEquipChest.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.remain) then
    return false
  end
  local length = (table.slen)(self.equipments)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.equipments)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SBuyEquipChest.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R8 in 'UnsetPending'

    (self.equipments)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.equipments)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SBuyEquipChest

