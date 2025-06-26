-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sgetpointscollection.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SGetPointsCollection = dataclass("SGetPointsCollection", require("framework.net.protocol"))
SGetPointsCollection.ProtocolType = 2437
SGetPointsCollection.MaxSize = 65535
SGetPointsCollection.activityID = 0
SGetPointsCollection.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SGetPointsCollection
  ((SGetPointsCollection.super).Ctor)(self, client)
  self.tasks = {}
  self.points = {}
end

SGetPointsCollection.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityID) then
    return false
  end
  local length = (table.slen)(self.tasks)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.tasks)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.points)) then
    return false
  end
  for key,value in pairs(self.points) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC52) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, R10_PC52) then
      return false
    end
  end
  return true
end

SGetPointsCollection.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
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
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

    (self.tasks)[i] = ((require("protocols.bean.protocol.activity.collectiontask")).Create)()
    if not ((self.tasks)[i]):Unmarshal(buffer) then
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
    -- DECOMPILER ERROR at PC67: Overwrote pending register: R6 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC73: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (self.points)[key] = value
  end
  return ret
end

return SGetPointsCollection

