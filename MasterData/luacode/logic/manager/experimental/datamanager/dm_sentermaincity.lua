-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_sentermaincity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_SEnterMainCity = class("DM_SEnterMainCity")
DM_SEnterMainCity.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._senterMainCityInfo = (NekoData.Data).senterMainCityInfo
end

DM_SEnterMainCity.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for k,v in pairs(self._senterMainCityInfo) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

    (self._senterMainCityInfo)[k] = nil
  end
end

DM_SEnterMainCity.OnSEnterMainCity = function(self, protocol)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._senterMainCityInfo).curBattleInfo = protocol.curBattleInfo
end

DM_SEnterMainCity.SetMainCityCurBattleInfo = function(self, value)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._senterMainCityInfo).curBattleInfo = value
end

return DM_SEnterMainCity

