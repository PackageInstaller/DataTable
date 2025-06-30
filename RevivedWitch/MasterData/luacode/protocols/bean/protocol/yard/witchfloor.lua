-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/yard/witchfloor.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local WitchFloor = dataclass("WitchFloor")
WitchFloor.id = 0
WitchFloor.recovery = 0
WitchFloor.good = 0
WitchFloor.Ctor = function(self)
  -- function num : 0_0
  self.furniture = {}
  self.rolesLeftRecoveryTime = {}
end

WitchFloor.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.recovery) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.good) then
    return false
  end
  local length = (table.slen)(self.furniture)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.furniture)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.rolesLeftRecoveryTime)) then
    return false
  end
  for key,value in pairs(self.rolesLeftRecoveryTime) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC68) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, R10_PC68) then
      return false
    end
  end
  return true
end

WitchFloor.Unmarshal = function(self, buffer)
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

    (self.furniture)[i] = ((require("protocols.bean.protocol.yard.furniture")).Create)()
    if not ((self.furniture)[i]):Unmarshal(buffer) then
      return false
    end
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
    -- DECOMPILER ERROR at PC83: Overwrote pending register: R6 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC89: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (self.rolesLeftRecoveryTime)[key] = value
  end
  return ret
end

return WitchFloor

