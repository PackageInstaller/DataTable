-- chunkname: @IQIGame\\UIExternalApi\\DailyPicturePuzzleMissionUIApi.lua

DailyPicturePuzzleMissionUIApi = BaseLangApi:Extend()

function DailyPicturePuzzleMissionUIApi:Init()
	self:RegisterApi("Title", self.GetTitle)
	self:RegisterApi("TitleTask", self.GetTitleTask)
	self:RegisterApi("TextDes", self.GetTextDes)
	self:RegisterApi("TextTag", self.GetTextTag)
	self:RegisterApi("growUpViewTargetDesc", self.GetGrowUpViewTargetDesc)
end

function DailyPicturePuzzleMissionUIApi:GetGrowUpViewTargetDesc(desc, curNum, targetNum)
	return string.format("%s(%s/%s)", desc, curNum, targetNum)
end

function DailyPicturePuzzleMissionUIApi:GetTextTag(state)
	if state == 1 then
		return self:GetCfgText(3300001)
	elseif state == 2 then
		return self:GetCfgText(3300002)
	end

	return self:GetCfgText(3300003)
end

function DailyPicturePuzzleMissionUIApi:GetTextDes()
	return self:GetCfgText(3300004)
end

function DailyPicturePuzzleMissionUIApi:GetTitle()
	return self:GetCfgText(3300005)
end

function DailyPicturePuzzleMissionUIApi:GetTitleTask(type)
	if type == 1 then
		return self:GetCfgText(3300006)
	end

	return self:GetCfgText(3300007)
end

DailyPicturePuzzleMissionUIApi:Init()
