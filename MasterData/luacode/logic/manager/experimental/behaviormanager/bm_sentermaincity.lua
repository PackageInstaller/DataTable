local BM_SEnterMainCity = class("BM_SEnterMainCity")

function BM_SEnterMainCity:Ctor()
  self._senterMainCityInfo = NekoData.Data.senterMainCityInfo
end

function BM_SEnterMainCity:GetCurBattleInfo()
  return self._senterMainCityInfo.curBattleInfo
end

return BM_SEnterMainCity
