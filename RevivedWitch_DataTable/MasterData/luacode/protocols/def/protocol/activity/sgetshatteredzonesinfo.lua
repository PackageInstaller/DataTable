-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sgetshatteredzonesinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SGetShatteredZonesInfo = dataclass("SGetShatteredZonesInfo", require("framework.net.protocol"))
SGetShatteredZonesInfo.ProtocolType = 2411
SGetShatteredZonesInfo.MaxSize = 65535
SGetShatteredZonesInfo.reloadInfoTime = 0
SGetShatteredZonesInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SGetShatteredZonesInfo
  ((SGetShatteredZonesInfo.super).Ctor)(self, client)
  self.zones = {}
  self.zonesClearReward = {}
end

SGetShatteredZonesInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.zones)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.zones)[i]):Marshal(buffer) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, (table.nums)(self.zonesClearReward)) then
    return false
  end
  for key,value in pairs(self.zonesClearReward) do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC44) then
      return false
    end
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, R10_PC44) then
      return false
    end
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.reloadInfoTime) then
    return false
  end
  return true
end

SGetShatteredZonesInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    (self.zones)[i] = ((require("protocols.bean.protocol.activity.shatteredzone")).Create)()
    if not ((self.zones)[i]):Unmarshal(buffer) then
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
    -- DECOMPILER ERROR at PC59: Overwrote pending register: R6 in 'AssignReg'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (self.zonesClearReward)[key] = value
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SGetShatteredZonesInfo

