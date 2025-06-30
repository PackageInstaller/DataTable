-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/soldplayerwelfare.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOldPlayerWelfare = dataclass("SOldPlayerWelfare", require("framework.net.protocol"))
SOldPlayerWelfare.ProtocolType = 2734
SOldPlayerWelfare.MaxSize = 65535
SOldPlayerWelfare.isPay = 0
SOldPlayerWelfare.totalSignNum = 0
SOldPlayerWelfare.endTime = 0
SOldPlayerWelfare.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOldPlayerWelfare
  ((SOldPlayerWelfare.super).Ctor)(self, client)
  self.commonReceiveList = {}
  self.highReceiveList = {}
end

SOldPlayerWelfare.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.isPay) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.totalSignNum) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.endTime) then
    return false
  end
  local length = (table.slen)(self.commonReceiveList)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.commonReceiveList)[i]) then
      return false
    end
  end
  local length = (table.slen)(self.highReceiveList)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.highReceiveList)[i]) then
      return false
    end
  end
  return true
end

SOldPlayerWelfare.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
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
  return ret
end

return SOldPlayerWelfare

