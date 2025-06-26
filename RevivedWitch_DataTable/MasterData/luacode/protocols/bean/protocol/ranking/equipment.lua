-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/ranking/equipment.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local Equipment = dataclass("Equipment")
Equipment.itemId = 0
Equipment.equipType = 0
Equipment.level = 0
Equipment.power = 0
Equipment.recommend = 0
Equipment.stage = 0
Equipment.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.baseAttr = {}
  self.finalAttr = {}
  self.randomEntry = {}
  self.skillRandomEntry = ((require("protocols.bean.protocol.item.beans.randomentry")).Create)()
  self.finalAttrRandomEntry = ((require("protocols.bean.protocol.item.beans.randomentry")).Create)()
  self.range = {}
end

Equipment.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.itemId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.equipType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.level) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.power) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.baseAttr)) then
    return false
  end
  for key,value in pairs(self.baseAttr) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC50) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC50) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.finalAttr)) then
    return false
  end
  for key,value in pairs(self.finalAttr) do
    -- DECOMPILER ERROR at PC82: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC50) then
      return false
    end
    -- DECOMPILER ERROR at PC90: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC50) then
      return false
    end
  end
  local length = (table.slen)(self.randomEntry)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC117: Overwrote pending register: R9 in 'AssignReg'

    if not ((self.randomEntry)[i]):Marshal(R9_PC50) then
      return false
    end
  end
  if not (self.skillRandomEntry):Marshal(buffer) then
    return false
  end
  if not (self.finalAttrRandomEntry):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.range)) then
    return false
  end
  for key,value in pairs(self.range) do
    -- DECOMPILER ERROR at PC156: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(R9_PC50, R10_PC158) then
      return false
    end
    -- DECOMPILER ERROR at PC164: Overwrote pending register: R9 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteProtocolString)(R9_PC50, R10_PC158) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.recommend) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.stage) then
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
    -- DECOMPILER ERROR at PC61: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC67: Confused about usage of register: R10 in 'UnsetPending'

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
    -- DECOMPILER ERROR at PC97: Overwrote pending register: R8 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC103: Confused about usage of register: R13 in 'UnsetPending'

    ;
    (self.finalAttr)[key] = value
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC124: Confused about usage of register: R14 in 'UnsetPending'

    (self.randomEntry)[i] = ((require("protocols.bean.protocol.item.beans.randomentry")).Create)()
    if not ((self.randomEntry)[i]):Unmarshal(buffer) then
      return false
    end
  end
  if not (self.skillRandomEntry):Unmarshal(buffer) then
    return false
  end
  if not (self.finalAttrRandomEntry):Unmarshal(buffer) then
    return false
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
    -- DECOMPILER ERROR at PC179: Overwrote pending register: R12 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC185: Confused about usage of register: R17 in 'UnsetPending'

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
  return ret
end

return Equipment

