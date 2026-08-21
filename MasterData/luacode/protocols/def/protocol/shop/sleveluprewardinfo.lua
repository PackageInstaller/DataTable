-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/sleveluprewardinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SLevelUpRewardInfo = dataclass("SLevelUpRewardInfo", require("framework.net.protocol"))
SLevelUpRewardInfo.ProtocolType = 3638
SLevelUpRewardInfo.MaxSize = 65535
SLevelUpRewardInfo.unlock = 0
SLevelUpRewardInfo.goodId = 0
SLevelUpRewardInfo.chargeNum = 0
SLevelUpRewardInfo.UN_CHARGE = 0
SLevelUpRewardInfo.CHARGE = 1
SLevelUpRewardInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SLevelUpRewardInfo
  ((SLevelUpRewardInfo.super).Ctor)(self, client)
  self.ids = {}
end

SLevelUpRewardInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.unlock) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.goodId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.chargeNum) then
    return false
  end
  local length = (table.slen)(self.ids)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.ids)[i]) then
      return false
    end
  end
  return true
end

SLevelUpRewardInfo.Unmarshal = function(self, buffer)
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
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R8 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SLevelUpRewardInfo

