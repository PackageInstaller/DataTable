-- chunkname: @IQIGame\\UIExternalApi\\HomeLandManufactureDecomposeUIApi.lua

HomeLandManufactureDecomposeUIApi = BaseLangApi:Extend()

function HomeLandManufactureDecomposeUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("TextLabel", self.GetTextLabel)
	self:RegisterApi("ToggleTitle", self.GetToggleTitle)
	self:RegisterApi("TextHave", self.GetTextHave)
	self:RegisterApi("BtnDecomposeLabel", self.GetBtnDecomposeLabel)
	self:RegisterApi("BtnDecomposeAllLabel", self.GetBtnDecomposeAllLabel)
	self:RegisterApi("TextResult", self.GetTextResult)
	self:RegisterApi("EmptyText", self.GetEmptyText)
end

function HomeLandManufactureDecomposeUIApi:GetEmptyText()
	return self:GetCfgText(1015351)
end

function HomeLandManufactureDecomposeUIApi:GetTextResult(name, num)
	return string.format(self:GetCfgText(1015352), num, name)
end

function HomeLandManufactureDecomposeUIApi:GetBtnDecomposeAllLabel()
	return self:GetCfgText(1015353)
end

function HomeLandManufactureDecomposeUIApi:GetBtnDecomposeLabel()
	return self:GetCfgText(1015354)
end

function HomeLandManufactureDecomposeUIApi:GetTextHave(num)
	return string.format("x%s", num)
end

function HomeLandManufactureDecomposeUIApi:GetToggleTitle()
	return {
		{
			0,
			""
		},
		{
			1,
			self:GetCfgText(1015161)
		},
		{
			2,
			self:GetCfgText(1015162)
		},
		{
			3,
			self:GetCfgText(1015163)
		},
		{
			4,
			self:GetCfgText(1015164)
		},
		{
			5,
			self:GetCfgText(1015165)
		},
		{
			7,
			self:GetCfgText(1015178)
		}
	}
end

function HomeLandManufactureDecomposeUIApi:GetTextLabel()
	return self:GetCfgText(1240002)
end

function HomeLandManufactureDecomposeUIApi:GetTitleText()
	return self:GetCfgText(1015355)
end

HomeLandManufactureDecomposeUIApi:Init()
