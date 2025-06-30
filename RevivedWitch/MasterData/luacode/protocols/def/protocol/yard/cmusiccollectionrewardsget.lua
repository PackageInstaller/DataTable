-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/cmusiccollectionrewardsget.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CMusicCollectionRewardsGet = dataclass("CMusicCollectionRewardsGet", require("framework.net.protocol"))
CMusicCollectionRewardsGet.ProtocolType = 2387
CMusicCollectionRewardsGet.MaxSize = 65535
CMusicCollectionRewardsGet.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CMusicCollectionRewardsGet
  ((CMusicCollectionRewardsGet.super).Ctor)(self, client)
  self.musicCollectionRewardsList = {}
end

CMusicCollectionRewardsGet.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.musicCollectionRewardsList)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.musicCollectionRewardsList)[i]) then
      return false
    end
  end
  return true
end

CMusicCollectionRewardsGet.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R8 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return CMusicCollectionRewardsGet

