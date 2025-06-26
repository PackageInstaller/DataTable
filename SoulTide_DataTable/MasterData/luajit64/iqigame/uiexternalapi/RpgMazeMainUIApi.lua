-- chunkname: @IQIGame\\UIExternalApi\\RpgMazeMainUIApi.lua

RpgMazeMainUIApi = BaseLangApi:Extend()

function RpgMazeMainUIApi:Init()
	self:RegisterApi("MazeNameText", self.GetMazeNameText)
	self:RegisterApi("BagBtnText", self.GetBagBtnText)
	self:RegisterApi("AddExploreValueNotice", self.GetAddExploreValueNotice)
	self:RegisterApi("StartTitleText", self.GetStartTitleText)
	self:RegisterApi("StartTipText", self.GetStartTipText)
	self:RegisterApi("ExploreLabel", self.GetExploreLabel)
	self:RegisterApi("ExploreProgressText", self.GetExploreProgressText)
end

function RpgMazeMainUIApi:GetMazeNameText(chapterOrder, order, name)
	return name
end

function RpgMazeMainUIApi:GetBagBtnText()
	return self:GetCfgText(1234002)
end

function RpgMazeMainUIApi:GetAddExploreValueNotice(percent)
	return "+" .. percent .. "%"
end

function RpgMazeMainUIApi:GetStartTitleText()
	return self:GetCfgText(2200015)
end

function RpgMazeMainUIApi:GetStartTipText(conditionsDesc)
	return ""
end

function RpgMazeMainUIApi:GetExploreLabel()
	return self:GetCfgText(2300010)
end

function RpgMazeMainUIApi:GetExploreProgressText(percent)
	return string.format("%s%%", percent)
end

RpgMazeMainUIApi:Init()
