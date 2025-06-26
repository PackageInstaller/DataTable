-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sgetshatteredzonesclear.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SGetShatteredZonesClear = dataclass("SGetShatteredZonesClear", require("framework.net.protocol"))
SGetShatteredZonesClear.ProtocolType = 2413
SGetShatteredZonesClear.MaxSize = 65535
SGetShatteredZonesClear.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SGetShatteredZonesClear
  ((SGetShatteredZonesClear.super).Ctor)(self, client)
  self.clearRewards = {}
end

SGetShatteredZonesClear.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.clearRewards)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.clearRewards)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

SGetShatteredZonesClear.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    (self.clearRewards)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.clearRewards)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return SGetShatteredZonesClear

