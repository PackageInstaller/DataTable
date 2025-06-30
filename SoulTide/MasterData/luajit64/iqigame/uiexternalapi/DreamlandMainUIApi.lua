-- chunkname: @IQIGame\\UIExternalApi\\DreamlandMainUIApi.lua

DreamlandMainUIApi = BaseLangApi:Extend()

function DreamlandMainUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ComboNumImagePath", self.GetComboNumImagePath)
	self:RegisterApi("OpenCellBtnText", self.GetOpenCellBtnText)
	self:RegisterApi("MarkBtnText", self.GetMarkBtnText)
	self:RegisterApi("RemoveMarkBtnText", self.GetRemoveMarkBtnText)
	self:RegisterApi("SpeRewardBtnText", self.GetSpeRewardBtnText)
	self:RegisterApi("ResetBtnText", self.GetResetBtnText)
	self:RegisterApi("TaskBtnText", self.GetTaskBtnText)
	self:RegisterApi("SpeedBtnLabel", self.GetSpeedBtnLabel)
	self:RegisterApi("SpeedText", self.GetSpeedText)
	self:RegisterApi("LeftGoodNodeLabel", self.GetLeftGoodNodeLabel)
	self:RegisterApi("LeftGoodNodeValueText", self.GetLeftGoodNodeValueText)
end

function DreamlandMainUIApi:GetTitleText()
	return self:GetCfgText(3700001)
end

function DreamlandMainUIApi:GetComboNumImagePath(type, num)
	local paths = {}

	paths[1] = {
		self:GetResUrl(4400000),
		self:GetResUrl(4400001),
		self:GetResUrl(4400002),
		self:GetResUrl(4400003),
		self:GetResUrl(4400004),
		self:GetResUrl(4400005),
		self:GetResUrl(4400006),
		self:GetResUrl(4400007),
		self:GetResUrl(4400008),
		self:GetResUrl(4400009)
	}
	paths[2] = {
		self:GetResUrl(4400020),
		self:GetResUrl(4400021),
		self:GetResUrl(4400022),
		self:GetResUrl(4400023),
		self:GetResUrl(4400024),
		self:GetResUrl(4400025),
		self:GetResUrl(4400026),
		self:GetResUrl(4400027),
		self:GetResUrl(4400028),
		self:GetResUrl(4400029)
	}

	return paths[type][num + 1]
end

function DreamlandMainUIApi:GetOpenCellBtnText()
	return self:GetCfgText(3700002)
end

function DreamlandMainUIApi:GetMarkBtnText()
	return self:GetCfgText(3700003)
end

function DreamlandMainUIApi:GetRemoveMarkBtnText()
	return self:GetCfgText(3700004)
end

function DreamlandMainUIApi:GetSpeRewardBtnText()
	return self:GetCfgText(3700005)
end

function DreamlandMainUIApi:GetResetBtnText()
	return self:GetCfgText(3700006)
end

function DreamlandMainUIApi:GetTaskBtnText()
	return self:GetCfgText(3700007)
end

function DreamlandMainUIApi:GetSpeedBtnLabel()
	return self:GetCfgText(3700008)
end

function DreamlandMainUIApi:GetSpeedText(speed)
	return "x" .. speed
end

function DreamlandMainUIApi:GetLeftGoodNodeLabel()
	return self:GetCfgText(3700009)
end

function DreamlandMainUIApi:GetLeftGoodNodeValueText(leftNum)
	if leftNum == 0 then
		return self:GetCfgText(3700011)
	else
		return string.format(self:GetCfgText(3700010), leftNum)
	end
end

DreamlandMainUIApi:Init()
