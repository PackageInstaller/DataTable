-- chunkname: @IQIGame\\UIExternalApi\\EndlessMazeRuneFilterUIApi.lua

EndlessMazeRuneFilterUIApi = BaseLangApi:Extend()

function EndlessMazeRuneFilterUIApi:Init()
	self:RegisterApi("QualityOptions", self.GetQualityOptions)
	self:RegisterApi("TagOptions", self.GetTagOptions)
	self:RegisterApi("QualityTexts", self.GetQualityTexts)
	self:RegisterApi("TagTexts", self.GetTagTexts)
	self:RegisterApi("FilterTypeLabel", self.GetFilterTypeLabel)
	self:RegisterApi("ClearBtnText", self.GetClearBtnText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
end

function EndlessMazeRuneFilterUIApi:GetQualityOptions()
	return {
		3,
		2,
		1
	}
end

function EndlessMazeRuneFilterUIApi:GetTagOptions()
	return {
		{
			11,
			12,
			13,
			14,
			15
		},
		{
			16,
			17,
			18,
			19,
			20
		},
		{
			8,
			9,
			5,
			6,
			7
		},
		{
			1,
			2,
			3,
			4,
			10
		},
		{
			21,
			22,
			23,
			24
		}
	}
end

function EndlessMazeRuneFilterUIApi:GetQualityTexts()
	return {
		self:GetCfgText(2200022),
		self:GetCfgText(2200023),
		self:GetCfgText(2200024)
	}
end

function EndlessMazeRuneFilterUIApi:GetTagTexts()
	return {
		{
			self:GetCfgText(1318034),
			self:GetCfgText(1318035),
			self:GetCfgText(1318033),
			self:GetCfgText(1318032),
			self:GetCfgText(1318031)
		},
		{
			self:GetCfgText(2200025),
			self:GetCfgText(2200026),
			self:GetCfgText(2200027),
			self:GetCfgText(2200029),
			self:GetCfgText(2200028)
		},
		{
			self:GetCfgText(2200030),
			self:GetCfgText(2200031),
			self:GetCfgText(1318023),
			self:GetCfgText(2200032),
			self:GetCfgText(2200036)
		},
		{
			self:GetCfgText(2200034),
			self:GetCfgText(2200035),
			self:GetCfgText(2200038),
			self:GetCfgText(2200037),
			self:GetCfgText(2200039)
		},
		{
			self:GetCfgText(2200078),
			self:GetCfgText(2200079),
			self:GetCfgText(2200080),
			self:GetCfgText(2200081)
		}
	}
end

function EndlessMazeRuneFilterUIApi:GetFilterTypeLabel(type)
	if type == 1 then
		return self:GetCfgText(2200019), self:GetCfgText(2200021)
	elseif type == 2 then
		return self:GetCfgText(2200020), self:GetCfgText(2200021)
	end
end

function EndlessMazeRuneFilterUIApi:GetClearBtnText()
	return self:GetCfgText(2000001)
end

function EndlessMazeRuneFilterUIApi:GetConfirmBtnText()
	return self:GetCfgText(2000002)
end

EndlessMazeRuneFilterUIApi:Init()
