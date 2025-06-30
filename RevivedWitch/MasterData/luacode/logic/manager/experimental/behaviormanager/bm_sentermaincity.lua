-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_sentermaincity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_SEnterMainCity = class("BM_SEnterMainCity")
BM_SEnterMainCity.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._senterMainCityInfo = (NekoData.Data).senterMainCityInfo
end

BM_SEnterMainCity.GetCurBattleInfo = function(self)
  -- function num : 0_1
  return (self._senterMainCityInfo).curBattleInfo
end

return BM_SEnterMainCity

