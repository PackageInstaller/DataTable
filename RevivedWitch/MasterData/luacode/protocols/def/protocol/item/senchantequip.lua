-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/item/senchantequip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SEnchantEquip = dataclass("SEnchantEquip", require("framework.net.protocol"))
SEnchantEquip.ProtocolType = 1217
SEnchantEquip.MaxSize = 65535
SEnchantEquip.equipKey = 0
SEnchantEquip.kind = 0
SEnchantEquip.luck = 0
SEnchantEquip.power = 0
SEnchantEquip.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SEnchantEquip, _ENV
  ((SEnchantEquip.super).Ctor)(self, client)
  self.randomEntry = {}
  self.finalAttrEntry = ((require("protocols.bean.protocol.item.beans.randomentry")).Create)()
  self.finalAttr = {}
end

SEnchantEquip.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.equipKey) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.kind) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.luck) then
    return false
  end
  local length = (table.slen)(self.randomEntry)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.randomEntry)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (self.finalAttrEntry):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.power) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.finalAttr)) then
    return false
  end
  for key,value in pairs(self.finalAttr) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC84) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC84) then
      return false
    end
  end
  return true
end

SEnchantEquip.Unmarshal = function(self, buffer)
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
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R8 in 'UnsetPending'

    (self.randomEntry)[i] = ((require("protocols.bean.protocol.item.beans.randomentry")).Create)()
    if not ((self.randomEntry)[i]):Unmarshal(buffer) then
      return false
    end
  end
  if not (self.finalAttrEntry):Unmarshal(buffer) then
    return false
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length, key, value = 0, nil, nil
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    key = nil
    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC99: Overwrote pending register: R6 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC105: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (self.finalAttr)[key] = value
  end
  return ret
end

return SEnchantEquip

