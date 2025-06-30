-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/supdatesummermissions.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SUpdateSummerMissions = dataclass("SUpdateSummerMissions", require("framework.net.protocol"))
SUpdateSummerMissions.ProtocolType = 2510
SUpdateSummerMissions.MaxSize = 65535
SUpdateSummerMissions.sunlight = 0
SUpdateSummerMissions.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SUpdateSummerMissions
  ((SUpdateSummerMissions.super).Ctor)(self, client)
  self.missions = {}
end

SUpdateSummerMissions.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.missions)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.missions)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.sunlight) then
    return false
  end
  return true
end

SUpdateSummerMissions.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    (self.missions)[i] = ((require("protocols.bean.protocol.activity.summermission")).Create)()
    if not ((self.missions)[i]):Unmarshal(buffer) then
      return false
    end
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SUpdateSummerMissions

