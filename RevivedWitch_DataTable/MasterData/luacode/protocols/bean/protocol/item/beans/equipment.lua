-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/item/beans/equipment.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local Equipment = dataclass("Equipment")
Equipment.equipType = 0
Equipment.stage = 0
Equipment.level = 0
Equipment.exp = 0
Equipment.power = 0
Equipment.roleId = 0
Equipment.lock = 0
Equipment.viewDetails = 0
Equipment.recommend = 0
Equipment.luck = 0
Equipment.nextEnchantCost = 0
Equipment.enchant = 0
Equipment.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.baseAttr = {}
  self.finalAttr = {}
  self.randomEntry = {}
  self.preRandomEntry = {}
  self.skillRandomEntry = ((require("protocols.bean.protocol.item.beans.randomentry")).Create)()
  self.finalAttrRandomEntry = ((require("protocols.bean.protocol.item.beans.randomentry")).Create)()
  self.preFinalAttrRandomEntry = ((require("protocols.bean.protocol.item.beans.randomentry")).Create)()
  self.range = {}
end

Equipment.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.equipType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.stage) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.level) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.exp) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.power) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.baseAttr)) then
    return false
  end
  for key,value in pairs(self.baseAttr) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC58) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC58) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.finalAttr)) then
    return false
  end
  for key,value in pairs(self.finalAttr) do
    -- DECOMPILER ERROR at PC90: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC58) then
      return false
    end
    -- DECOMPILER ERROR at PC98: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC58) then
      return false
    end
  end
  local length = (table.slen)(self.randomEntry)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC125: Overwrote pending register: R9 in 'AssignReg'

    if not ((self.randomEntry)[i]):Marshal(R9_PC58) then
      return false
    end
  end
  local length = (table.slen)(self.preRandomEntry)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC150: Overwrote pending register: R9 in 'AssignReg'

    if not ((self.preRandomEntry)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (self.skillRandomEntry):Marshal(buffer) then
    return false
  end
  if not (self.finalAttrRandomEntry):Marshal(buffer) then
    return false
  end
  if not (self.preFinalAttrRandomEntry):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.roleId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.lock) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.viewDetails) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.range)) then
    return false
  end
  for key,value in pairs(self.range) do
    -- DECOMPILER ERROR at PC221: Overwrote pending register: R9 in 'AssignReg'

    R9_PC58 = R9_PC58(buffer, R11_PC224)
    if not R9_PC58 then
      R9_PC58 = false
      return R9_PC58
    end
    R9_PC58 = ProtocolBufferStaticFunctions.WriteProtocolString
    R9_PC58 = R9_PC58(buffer, R11_PC224)
    if not R9_PC58 then
      R9_PC58 = false
      return R9_PC58
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.recommend) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.luck) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.nextEnchantCost) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.enchant) then
    return false
  end
  return true
end

Equipment.Unmarshal = function(self, buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
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
    -- DECOMPILER ERROR at PC69: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC75: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.baseAttr)[key] = value
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
    -- DECOMPILER ERROR at PC105: Overwrote pending register: R8 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC111: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (self.finalAttr)[key] = value
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC132: Confused about usage of register: R14 in 'UnsetPending'

    (self.randomEntry)[i] = ((require("protocols.bean.protocol.item.beans.randomentry")).Create)()
    if not ((self.randomEntry)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC162: Confused about usage of register: R15 in 'UnsetPending'

    (self.preRandomEntry)[i] = ((require("protocols.bean.protocol.item.beans.randomentry")).Create)()
    if not ((self.preRandomEntry)[i]):Unmarshal(buffer) then
      return false
    end
  end
  if not (self.skillRandomEntry):Unmarshal(buffer) then
    return false
  end
  if not (self.finalAttrRandomEntry):Unmarshal(buffer) then
    return false
  end
  if not (self.preFinalAttrRandomEntry):Unmarshal(buffer) then
    return false
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
    -- DECOMPILER ERROR at PC249: Overwrote pending register: R13 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC255: Confused about usage of register: R18 in 'UnsetPending'

    ;
    (self.range)[key] = value
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
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return Equipment

