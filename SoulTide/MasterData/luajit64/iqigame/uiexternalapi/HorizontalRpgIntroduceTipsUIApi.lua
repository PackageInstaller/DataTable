-- chunkname: @IQIGame\\UIExternalApi\\HorizontalRpgIntroduceTipsUIApi.lua

HorizontalRpgIntroduceTipsUIApi = BaseLangApi:Extend()

function HorizontalRpgIntroduceTipsUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("DescTexts", self.GetDescTexts)
end

function HorizontalRpgIntroduceTipsUIApi:GetTitleText(cid)
	return self:GetCfgText(5100001)
end

function HorizontalRpgIntroduceTipsUIApi:GetDescTexts(cid)
	return {
		self:GetCfgText(3430013),
		self:GetCfgText(3430014),
		self:GetCfgText(3430015),
		self:GetCfgText(3430016),
		self:GetCfgText(3430017)
	}
end

HorizontalRpgIntroduceTipsUIApi:Init()
