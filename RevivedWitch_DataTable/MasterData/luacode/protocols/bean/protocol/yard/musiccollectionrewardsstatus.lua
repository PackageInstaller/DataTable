-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/yard/musiccollectionrewardsstatus.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local MusicCollectionRewardsStatus = dataclass("MusicCollectionRewardsStatus")
MusicCollectionRewardsStatus.UNFINISHED = 1
MusicCollectionRewardsStatus.AVAILABLE = 2
MusicCollectionRewardsStatus.RECEIVED = 3
MusicCollectionRewardsStatus.Ctor = function(self)
  -- function num : 0_0
end

MusicCollectionRewardsStatus.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

MusicCollectionRewardsStatus.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return MusicCollectionRewardsStatus

