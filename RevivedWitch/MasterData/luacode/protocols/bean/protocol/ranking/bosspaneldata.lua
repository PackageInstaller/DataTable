-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/ranking/bosspaneldata.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local BossPanelData = dataclass("BossPanelData")
BossPanelData.passTime = 0
BossPanelData.power = 0
BossPanelData.times = 0
BossPanelData.Ctor = function(self)
  -- function num : 0_0
  self.roleIdList = {}
  self.roleLvList = {}
  self.roleBreakList = {}
  self.roleSkinList = {}
  self.runeLevelList = {}
end

BossPanelData.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.passTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.power) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.times) then
    return false
  end
  local length = (table.slen)(self.roleIdList)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.roleIdList)[i]) then
      return false
    end
  end
  local length = (table.slen)(self.roleLvList)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.roleLvList)[i]) then
      return false
    end
  end
  local length = (table.slen)(self.roleBreakList)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.roleBreakList)[i]) then
      return false
    end
  end
  local length = (table.slen)(self.roleSkinList)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.roleSkinList)[i]) then
      return false
    end
  end
  local length = (table.slen)(self.runeLevelList)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.runeLevelList)[i]) then
      return false
    end
  end
  return true
end

BossPanelData.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
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
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R8 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R9 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC88: Confused about usage of register: R10 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC111: Confused about usage of register: R11 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC134: Confused about usage of register: R12 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return BossPanelData

