-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/scompletezone.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SCompleteZone = dataclass("SCompleteZone", require("framework.net.protocol"))
SCompleteZone.ProtocolType = 1958
SCompleteZone.MaxSize = 65535
SCompleteZone.zoneId = 0
SCompleteZone.currentZone = 0
SCompleteZone.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SCompleteZone, _ENV
  ((SCompleteZone.super).Ctor)(self, client)
  self.money = {}
  self.firstPassAward = {}
  self.exploreAwards = {}
  self.topMessage = ((require("protocols.bean.protocol.notify.sendtopmessage")).Create)()
end

SCompleteZone.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.zoneId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.currentZone) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.money)) then
    return false
  end
  for key,value in pairs(self.money) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R9_PC34) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, R9_PC34) then
      return false
    end
  end
  local length = (table.slen)(self.firstPassAward)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC68: Overwrote pending register: R9 in 'AssignReg'

    if not ((self.firstPassAward)[i]):Marshal(R9_PC34) then
      return false
    end
  end
  local length = (table.slen)(self.exploreAwards)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC93: Overwrote pending register: R9 in 'AssignReg'

    if not ((self.exploreAwards)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (self.topMessage):Marshal(buffer) then
    return false
  end
  return true
end

SCompleteZone.Unmarshal = function(self, buffer)
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
    -- DECOMPILER ERROR at PC45: Overwrote pending register: R5 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.money)[key] = value
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC72: Confused about usage of register: R11 in 'UnsetPending'

    (self.firstPassAward)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.firstPassAward)[i]):Unmarshal(buffer) then
      return false
    end
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC102: Confused about usage of register: R12 in 'UnsetPending'

    (self.exploreAwards)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.exploreAwards)[i]):Unmarshal(buffer) then
      return false
    end
  end
  if not (self.topMessage):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SCompleteZone

