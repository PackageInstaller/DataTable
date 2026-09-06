local DM_SEnterMainCity = class("DM_SEnterMainCity")

function DM_SEnterMainCity:Ctor()
  self._senterMainCityInfo = NekoData.Data.senterMainCityInfo
end

function DM_SEnterMainCity:Clear()
  for k, v in pairs(self._senterMainCityInfo) do
    self._senterMainCityInfo[k] = nil
  end
end

function DM_SEnterMainCity:OnSEnterMainCity(protocol)
  self._senterMainCityInfo.curBattleInfo = protocol.curBattleInfo
end

function DM_SEnterMainCity:SetMainCityCurBattleInfo(value)
  self._senterMainCityInfo.curBattleInfo = value
end

return DM_SEnterMainCity
