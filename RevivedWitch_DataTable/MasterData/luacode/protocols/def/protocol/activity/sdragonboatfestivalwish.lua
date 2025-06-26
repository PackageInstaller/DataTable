-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sdragonboatfestivalwish.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SDragonBoatFestivalWish = dataclass("SDragonBoatFestivalWish", require("framework.net.protocol"))
SDragonBoatFestivalWish.ProtocolType = 2655
SDragonBoatFestivalWish.MaxSize = 65535
SDragonBoatFestivalWish.currPoolId = 0
SDragonBoatFestivalWish.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SDragonBoatFestivalWish
  ((SDragonBoatFestivalWish.super).Ctor)(self, client)
  self.dragonBoatItemPool = {}
end

SDragonBoatFestivalWish.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.currPoolId) then
    return false
  end
  local length = (table.slen)(self.dragonBoatItemPool)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.dragonBoatItemPool)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SDragonBoatFestivalWish.Unmarshal = function(self, buffer)
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

    (self.dragonBoatItemPool)[i] = ((require("protocols.bean.protocol.activity.dragonboatitempool")).Create)()
    if not ((self.dragonBoatItemPool)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SDragonBoatFestivalWish

