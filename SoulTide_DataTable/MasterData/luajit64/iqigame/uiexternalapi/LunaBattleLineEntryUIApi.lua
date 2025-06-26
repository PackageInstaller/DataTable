-- chunkname: @IQIGame\\UIExternalApi\\LunaBattleLineEntryUIApi.lua

LunaBattleLineEntryUIApi = BaseLangApi:Extend()

function LunaBattleLineEntryUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("RewardProgressText", self.GetRewardProgressText)
	self:RegisterApi("TipBtnText", self.GetTipBtnText)
	self:RegisterApi("ShopBtnText", self.GetShopBtnText)
	self:RegisterApi("TaskBtnText", self.GetTaskBtnText)
	self:RegisterApi("TimeText", self.GetTimeText)
	self:RegisterApi("ZoneCellSealProgressText", self.GetZoneCellSealProgressText)
	self:RegisterApi("UnfinishedMazeTagIcon", self.GetUnfinishedMazeTagIcon)
	self:RegisterApi("UnfinishedMazeTagText", self.GetUnfinishedMazeTagText)
end

function LunaBattleLineEntryUIApi:GetTitleText()
	return self:GetCfgText(3600001)
end

function LunaBattleLineEntryUIApi:GetRewardProgressText(currentNum, totalNum)
	return string.format(self:GetCfgText(3600002), currentNum, totalNum)
end

function LunaBattleLineEntryUIApi:GetTipBtnText()
	return self:GetCfgText(3600003)
end

function LunaBattleLineEntryUIApi:GetShopBtnText()
	return self:GetCfgText(3600004)
end

function LunaBattleLineEntryUIApi:GetTaskBtnText()
	return self:GetCfgText(3600005)
end

function LunaBattleLineEntryUIApi:GetTimeText(currentServerTime, accessEndTime, activityEndTime)
	if accessEndTime < currentServerTime then
		return string.format(self:GetCfgText(3600012), getDateTimeMText(activityEndTime))
	else
		return string.format(self:GetCfgText(3600006), getDateTimeMText(accessEndTime))
	end
end

function LunaBattleLineEntryUIApi:GetZoneCellSealProgressText(currentNum, maxNum)
	return currentNum .. "%"
end

function LunaBattleLineEntryUIApi:GetUnfinishedMazeTagIcon(chapterType)
	if chapterType == 10 then
		return "/Maze/LunaFront/LunaCommonUI/LunaCommon_Image_13.png"
	elseif chapterType == 8 then
		return "/Maze/LunaFront/LunaCommonUI/LunaCommon_Image_11.png"
	elseif chapterType == 9 then
		return "/Maze/LunaFront/LunaCommonUI/LunaCommon_Image_12.png"
	end

	return "/Maze/LunaFront/LunaCommonUI/LunaCommon_Image_13.png"
end

function LunaBattleLineEntryUIApi:GetUnfinishedMazeTagText(mazeName, chapterType)
	if chapterType == 10 then
		return self:GetCfgText(3600008) .. self:GetCfgText(3600011)
	elseif chapterType == 8 then
		return self:GetCfgText(3600009) .. self:GetCfgText(3600011)
	elseif chapterType == 9 then
		return self:GetCfgText(3600010) .. self:GetCfgText(3600011)
	end

	return chapterType .. mazeName .. self:GetCfgText(3600007)
end

LunaBattleLineEntryUIApi:Init()
