-- chunkname: @IQIGame\\UIExternalApi\\BattleWeakShieldTipsUIApi.lua

BattleWeakShieldTipsUIApi = BaseLangApi:Extend()

function BattleWeakShieldTipsUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
end

function BattleWeakShieldTipsUIApi:GetTitleText()
	return self:GetCfgText(3208001)
end

BattleWeakShieldTipsUIApi:Init()
