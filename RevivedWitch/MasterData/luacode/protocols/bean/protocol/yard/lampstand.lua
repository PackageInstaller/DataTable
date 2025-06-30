-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/yard/lampstand.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local LampStand = dataclass("LampStand")
LampStand.id = 0
LampStand.level = 0
LampStand.leftRefreshTime = 0
LampStand.leftRefreshLightSpotTime = 0
LampStand.glowwormLevel = 0
LampStand.speed = 0
LampStand.white = 0
LampStand.dark = 0
LampStand.mix = 0
LampStand.Ctor = function(self)
  -- function num : 0_0
  self.lampTask = {}
  self.LightSpots = {}
end

LampStand.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.level) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftRefreshTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.lampTask)) then
    return false
  end
  for key,value in pairs(self.lampTask) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC42) then
      return false
    end
    if not value:Marshal(R9_PC42) then
      return false
    end
  end
  local length = (table.slen)(self.LightSpots)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC75: Overwrote pending register: R9 in 'AssignReg'

    if not ((self.LightSpots)[i]):Marshal(R9_PC42) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftRefreshLightSpotTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.glowwormLevel) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.speed) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.white) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.dark) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.mix) then
    return false
  end
  return true
end

LampStand.Unmarshal = function(self, buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
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
    -- DECOMPILER ERROR at PC55: Overwrote pending register: R5 in 'AssignReg'

    if not value:Unmarshal(buffer) then
      return false
    end
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.lampTask)[key] = value
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC85: Confused about usage of register: R11 in 'UnsetPending'

    (self.LightSpots)[i] = ((require("protocols.bean.protocol.yard.light")).Create)()
    if not ((self.LightSpots)[i]):Unmarshal(buffer) then
      return false
    end
  end
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
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return LampStand

