-- chunkname: @IQIGame\\UIExternalApi\\ItemLetterTipsUIApi.lua

ItemLetterTipsUIApi = BaseLangApi:Extend()

function ItemLetterTipsUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
end

function ItemLetterTipsUIApi:GetTitleText()
	return self:GetCfgText(1211201)
end

ItemLetterTipsUIApi:Init()
