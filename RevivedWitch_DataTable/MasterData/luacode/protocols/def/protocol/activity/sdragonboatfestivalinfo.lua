-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sdragonboatfestivalinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SDragonBoatFestivalInfo = dataclass("SDragonBoatFestivalInfo", require("framework.net.protocol"))
SDragonBoatFestivalInfo.ProtocolType = 2653
SDragonBoatFestivalInfo.MaxSize = 65535
SDragonBoatFestivalInfo.leftTime = 0
SDragonBoatFestivalInfo.actOpen = 0
SDragonBoatFestivalInfo.wishOpen = 0
SDragonBoatFestivalInfo.shopOpen = 0
SDragonBoatFestivalInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SDragonBoatFestivalInfo
  ((SDragonBoatFestivalInfo.super).Ctor)(self, client)
  self.redpoint = {}
end

SDragonBoatFestivalInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.actOpen) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.wishOpen) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.shopOpen) then
    return false
  end
  local length = (table.slen)(self.redpoint)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.redpoint)[i]) then
      return false
    end
  end
  return true
end

SDragonBoatFestivalInfo.Unmarshal = function(self, buffer)
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
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R8 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SDragonBoatFestivalInfo

