-- chunkname: @IQIGame\\UIExternalApi\\HomeLandOverviewUIApi.lua

HomeLandOverviewUIApi = BaseLangApi:Extend()

function HomeLandOverviewUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("Text_Lock1", self.GetText_Lock1)
	self:RegisterApi("Text_Lock2", self.GetText_Lock2)
	self:RegisterApi("TextName", self.GetTextName)
	self:RegisterApi("TextTitleState", self.GetTextTitleState)
	self:RegisterApi("TextBtnGetReward", self.GetTextBtnGetReward)
	self:RegisterApi("TextBtnLook", self.GetTextBtnLook)
	self:RegisterApi("TextTimeGold", self.GetTextTimeGold)
	self:RegisterApi("TextTimeGoldMax", self.GetTextTimeGoldMax)
	self:RegisterApi("TextSortGift", self.GetTextSortGift)
	self:RegisterApi("TextSortManufacture", self.GetTextSortManufacture)
	self:RegisterApi("TextTimeManufacture", self.GetTextTimeManufacture)
	self:RegisterApi("TextSortCooking", self.GetTextSortCooking)
	self:RegisterApi("TextTimeCooking", self.GetTextTimeCooking)
	self:RegisterApi("TextSortPlant", self.GetTextSortPlant)
	self:RegisterApi("TextTimePlant", self.GetTextTimePlant)
	self:RegisterApi("TextTimeWork", self.GetTextTimeWork)
	self:RegisterApi("TextSortWork", self.GetTextSortWork)
end

function HomeLandOverviewUIApi:GetTextTimeGoldMax()
	return self:GetCfgText(1016019)
end

function HomeLandOverviewUIApi:GetTextSortWork(num1, num2)
	return string.format(self:GetCfgText(1016001) .. "：%s", self.TextColor[31] .. "<Size=24>" .. num1 .. "</Size>" .. self.TextColor[0] .. self.TextColor[31] .. "/" .. num2 .. self.TextColor[0])
end

function HomeLandOverviewUIApi:GetTextTimeWork(str)
	return string.format("%s" .. self:GetCfgText(1016002), str)
end

function HomeLandOverviewUIApi:GetTextTimePlant(str)
	return string.format("%s" .. self:GetCfgText(1016003), str)
end

function HomeLandOverviewUIApi:GetTextSortPlant(num1, num2)
	return string.format(self:GetCfgText(1016004) .. "：%s", self.TextColor[31] .. "<Size=24>" .. num1 .. "</Size>" .. self.TextColor[0] .. self.TextColor[31] .. "/" .. num2 .. self.TextColor[0])
end

function HomeLandOverviewUIApi:GetTextTimeCooking(str)
	return string.format("%s" .. self:GetCfgText(1016005), str)
end

function HomeLandOverviewUIApi:GetTextSortCooking(num1, num2)
	return string.format(self:GetCfgText(1016006) .. "：%s", self.TextColor[31] .. "<Size=24>" .. num1 .. "</Size>" .. self.TextColor[0] .. self.TextColor[31] .. "/" .. num2 .. self.TextColor[0])
end

function HomeLandOverviewUIApi:GetTextTimeManufacture(str)
	return string.format("%s" .. self:GetCfgText(1016007), str)
end

function HomeLandOverviewUIApi:GetTextSortManufacture(num1, num2)
	return string.format(self:GetCfgText(1016008) .. "：%s", self.TextColor[31] .. "<Size=24>" .. num1 .. "</Size>" .. self.TextColor[0] .. self.TextColor[31] .. "/" .. num2 .. self.TextColor[0])
end

function HomeLandOverviewUIApi:GetTextSortGift()
	return self:GetCfgText(1016009)
end

function HomeLandOverviewUIApi:GetTextTimeGold(str)
	return string.format("%s" .. self:GetCfgText(1016010), str)
end

function HomeLandOverviewUIApi:GetTextBtnLook()
	return self:GetCfgText(1016011)
end

function HomeLandOverviewUIApi:GetTextBtnGetReward()
	return self:GetCfgText(1016012)
end

function HomeLandOverviewUIApi:GetTextTitleState(isEmptyQueue, homelandBuildType)
	if homelandBuildType == Constant.HomelandBuildType.BuildBackGift then
		return ""
	elseif isEmptyQueue then
		return self:GetCfgText(1016013)
	end

	return self:GetCfgText(1016014)
end

function HomeLandOverviewUIApi:GetTextName(isOpen, funName)
	if isOpen then
		return "<color=#000000>" .. funName .. "</color>"
	end

	return "<color=#FFFFFF>" .. funName .. "</color>"
end

function HomeLandOverviewUIApi:GetText_Lock2(roomName)
	return string.format(self:GetCfgText(1016018), roomName)
end

function HomeLandOverviewUIApi:GetText_Lock1()
	return self:GetCfgText(1016015)
end

function HomeLandOverviewUIApi:GetTextTitle()
	return self:GetCfgText(1016016)
end

HomeLandOverviewUIApi:Init()
