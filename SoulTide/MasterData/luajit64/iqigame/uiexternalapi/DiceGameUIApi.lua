-- chunkname: @IQIGame\\UIExternalApi\\DiceGameUIApi.lua

DiceGameUIApi = BaseLangApi:Extend()

function DiceGameUIApi:Init()
	self:RegisterApi("ReDiceCountText", self.GetReDiceCountText)
	self:RegisterApi("StartBtnText", self.GetStartBtnText)
	self:RegisterApi("IntroductionTargetLabel", self.GetIntroductionTargetLabel)
	self:RegisterApi("IntroductionWinConditionLabel", self.GetIntroductionWinConditionLabel)
	self:RegisterApi("DiceImagePath", self.GetDiceImagePath)
	self:RegisterApi("IntroductionDiceGroupLabel", self.GetIntroductionDiceGroupLabel)
	self:RegisterApi("GroupNames", self.GetGroupNames)
	self:RegisterApi("GroupDescriptions", self.GetGroupDescriptions)
	self:RegisterApi("GroupPoints", self.GetGroupPoints)
	self:RegisterApi("IntroductionForExampleLabel", self.GetIntroductionForExampleLabel)
	self:RegisterApi("ResultOrder", self.GetResultOrder)
	self:RegisterApi("ReDiceBtnText", self.GetReDiceBtnText)
	self:RegisterApi("ConfirmResultBtnText", self.GetConfirmResultBtnText)
end

function DiceGameUIApi:GetReDiceCountText(selectNum, totalNum)
	return self:GetCfgText(3000101, selectNum, totalNum)
end

function DiceGameUIApi:GetStartBtnText()
	return self:GetCfgText(3000102)
end

function DiceGameUIApi:GetIntroductionTargetLabel()
	return self:GetCfgText(3000103)
end

function DiceGameUIApi:GetIntroductionWinConditionLabel()
	return self:GetCfgText(3000104)
end

function DiceGameUIApi:GetDiceImagePath(point)
	if point == 1 then
		return self:GetResUrl(4000101)
	elseif point == 2 then
		return self:GetResUrl(4000102)
	elseif point == 3 then
		return self:GetResUrl(4000103)
	elseif point == 4 then
		return self:GetResUrl(4000104)
	elseif point == 5 then
		return self:GetResUrl(4000105)
	elseif point == 6 then
		return self:GetResUrl(4000106)
	end
end

function DiceGameUIApi:GetIntroductionDiceGroupLabel()
	return self:GetCfgText(3000105)
end

function DiceGameUIApi:GetGroupNames()
	return {
		self:GetCfgText(3000106),
		self:GetCfgText(3000107),
		self:GetCfgText(3000108),
		self:GetCfgText(3000109),
		self:GetCfgText(3000110),
		self:GetCfgText(3000111),
		self:GetCfgText(3000112),
		self:GetCfgText(3000113)
	}
end

function DiceGameUIApi:GetGroupDescriptions()
	return {
		self:GetCfgText(3000114),
		self:GetCfgText(3000115),
		self:GetCfgText(3000116),
		self:GetCfgText(3000117),
		self:GetCfgText(3000118),
		self:GetCfgText(3000119),
		self:GetCfgText(3000120),
		self:GetCfgText(3000121)
	}
end

function DiceGameUIApi:GetGroupPoints()
	return {
		{
			6,
			6,
			6,
			6,
			6
		},
		{
			6,
			6,
			6,
			6,
			1
		},
		{
			6,
			6,
			6,
			5,
			5
		},
		{
			6,
			6,
			6,
			5,
			4
		},
		{
			6,
			5,
			4,
			3,
			2
		},
		{
			6,
			6,
			5,
			5,
			2
		},
		{
			6,
			6,
			5,
			4,
			3
		},
		{
			6,
			4,
			3,
			2,
			1
		}
	}
end

function DiceGameUIApi:GetIntroductionForExampleLabel()
	return self:GetCfgText(3000122)
end

function DiceGameUIApi:GetResultOrder()
	return {
		self:GetCfgText(3000123),
		self:GetCfgText(3000124),
		self:GetCfgText(3000125),
		self:GetCfgText(3000126),
		self:GetCfgText(3000127),
		self:GetCfgText(3000128),
		self:GetCfgText(3000129),
		self:GetCfgText(3000130)
	}
end

function DiceGameUIApi:GetReDiceBtnText()
	return self:GetCfgText(3000131)
end

function DiceGameUIApi:GetConfirmResultBtnText()
	return self:GetCfgText(3000132)
end

DiceGameUIApi:Init()
