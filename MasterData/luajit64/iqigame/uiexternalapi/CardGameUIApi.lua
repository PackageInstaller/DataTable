-- chunkname: @IQIGame\\UIExternalApi\\CardGameUIApi.lua

CardGameUIApi = BaseLangApi:Extend()

function CardGameUIApi:Init()
	self:RegisterApi("StartButtonText", self.GetStartButtonText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("CloseBtnText", self.GetCloseBtnText)
	self:RegisterApi("SelectNoticeText", self.GetSelectNoticeText)
	self:RegisterApi("ResultEffectDelay", self.GetResultEffectDelay)
	self:RegisterApi("DisableConfirmBtnText", self.GetDisableConfirmBtnText)
end

function CardGameUIApi:GetStartButtonText()
	return self:GetCfgText(1150081)
end

function CardGameUIApi:GetConfirmBtnText()
	return self:GetCfgText(1150083)
end

function CardGameUIApi:GetCloseBtnText()
	return self:GetCfgText(1150084)
end

function CardGameUIApi:GetSelectNoticeText(selectNum, totalNum)
	local color

	color = selectNum < totalNum and "#FF0000" or "#B6F27C"

	return string.format(self:GetCfgText(1150086), color, selectNum, totalNum)
end

function CardGameUIApi:GetResultEffectDelay()
	return 1
end

function CardGameUIApi:GetDisableConfirmBtnText()
	return self:GetCfgText(1150083)
end

CardGameUIApi:Init()
