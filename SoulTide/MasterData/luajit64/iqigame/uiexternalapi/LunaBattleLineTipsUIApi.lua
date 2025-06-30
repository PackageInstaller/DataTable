-- chunkname: @IQIGame\\UIExternalApi\\LunaBattleLineTipsUIApi.lua

LunaBattleLineTipsUIApi = BaseLangApi:Extend()

function LunaBattleLineTipsUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
end

function LunaBattleLineTipsUIApi:GetTitleText()
	return self:GetCfgText(3600100)
end

LunaBattleLineTipsUIApi:Init()
