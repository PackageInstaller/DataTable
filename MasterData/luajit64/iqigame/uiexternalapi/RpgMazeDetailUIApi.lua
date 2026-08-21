-- chunkname: @IQIGame\\UIExternalApi\\RpgMazeDetailUIApi.lua

RpgMazeDetailUIApi = BaseLangApi:Extend()

function RpgMazeDetailUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("RewardLabelText", self.GetRewardLabelText)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("MazeOrderText", self.GetMazeOrderText)
	self:RegisterApi("FormationPowerText", self.GetFormationPowerText)
	self:RegisterApi("ExploreLabel", self.GetExploreLabel)
	self:RegisterApi("ExploreText", self.GetExploreText)
	self:RegisterApi("CheckPointText", self.GetCheckPointText)
	self:RegisterApi("ElementTextDes", self.GetElementTextDes)
end

function RpgMazeDetailUIApi:GetElementTextDes(type)
	local typeStr = ""

	if type == 0 then
		typeStr = ""
	elseif type == 5 then
		typeStr = self:GetCfgText(2000104)
	elseif type == 6 then
		typeStr = self:GetCfgText(2000105)
	elseif type == 1 then
		typeStr = self:GetCfgText(2000100)
	elseif type == 3 then
		typeStr = self:GetCfgText(2000102)
	elseif type == 2 then
		typeStr = self:GetCfgText(2000101)
	elseif type == 4 then
		typeStr = self:GetCfgText(2000103)
	end

	return typeStr
end

function RpgMazeDetailUIApi:GetTitleText()
	return self:GetCfgText(2100002)
end

function RpgMazeDetailUIApi:GetRewardLabelText()
	return self:GetCfgText(2300037)
end

function RpgMazeDetailUIApi:GetConfirmBtnText()
	return self:GetCfgText(2100004)
end

function RpgMazeDetailUIApi:GetMazeOrderText(chapterOrder, order)
	if order == 0 then
		return ""
	end

	if chapterOrder == 1 then
		if order <= 3 then
			return "0-" .. order
		else
			return chapterOrder .. "-" .. order - 3
		end
	end

	return chapterOrder .. "-" .. order
end

function RpgMazeDetailUIApi:GetFormationPowerText(currentPower, recommendPower)
	local rate = recommendPower / currentPower

	if rate >= 1.25 then
		return self.TextColor[203] .. currentPower .. self.TextColor[0]
	elseif rate >= 1.05 then
		return self.TextColor[218] .. currentPower .. self.TextColor[0]
	elseif rate >= 0.95 then
		return self.TextColor[206] .. currentPower .. self.TextColor[0]
	elseif rate >= 0.75 then
		return self.TextColor[201] .. currentPower .. self.TextColor[0]
	else
		return self.TextColor[219] .. currentPower .. self.TextColor[0]
	end
end

function RpgMazeDetailUIApi:GetExploreLabel()
	return self:GetCfgText(2300010)
end

function RpgMazeDetailUIApi:GetExploreText(score)
	return score .. "%"
end

function RpgMazeDetailUIApi:GetCheckPointText()
	return self:GetCfgText(2300013)
end

RpgMazeDetailUIApi:Init()
