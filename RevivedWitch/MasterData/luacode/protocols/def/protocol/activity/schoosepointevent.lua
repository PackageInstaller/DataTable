-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/schoosepointevent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SChoosePointEvent = dataclass("SChoosePointEvent", require("framework.net.protocol"))
SChoosePointEvent.ProtocolType = 2419
SChoosePointEvent.MaxSize = 65535
SChoosePointEvent.pointIndex = 0
SChoosePointEvent.pointID = 0
SChoosePointEvent.EventID = 0
SChoosePointEvent.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SChoosePointEvent
  ((SChoosePointEvent.super).Ctor)(self, client)
  self.items = {}
  self.updateBuff = {}
  self.rolesState = {}
end

SChoosePointEvent.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.pointIndex) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.pointID) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.EventID) then
    return false
  end
  local length = (table.slen)(self.items)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.items)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.updateBuff)) then
    return false
  end
  for key,value in pairs(self.updateBuff) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC68) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC68) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.rolesState)) then
    return false
  end
  for key,value in pairs(self.rolesState) do
    -- DECOMPILER ERROR at PC100: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC68) then
      return false
    end
    -- DECOMPILER ERROR at PC108: Overwrote pending register: R10 in 'AssignReg'

    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC68) then
      return false
    end
  end
  return true
end

SChoosePointEvent.Unmarshal = function(self, buffer)
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

    (self.items)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.items)[i]):Unmarshal(buffer) then
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

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC89: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (self.updateBuff)[key] = value
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
    -- DECOMPILER ERROR at PC119: Overwrote pending register: R9 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC125: Confused about usage of register: R14 in 'UnsetPending'

    ;
    (self.rolesState)[key] = value
  end
  return ret
end

return SChoosePointEvent

