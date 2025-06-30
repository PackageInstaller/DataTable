-- chunkname: @IQIGame\\UIExternalApi\\ActivityNewDollStoryUIApi.lua

ActivityNewDollStoryUIApi = BaseLangApi:Extend()

function ActivityNewDollStoryUIApi:Init()
	self:RegisterApi("TextPanelTitle", self.GetTextPanelTitle)
	self:RegisterApi("TextConditionScore", self.GetTextConditionScore)
	self:RegisterApi("TextConditionBefore", self.GetTextConditionBefore)
	self:RegisterApi("TextCondition", self.GetTextCondition)
	self:RegisterApi("ImgNumPath", self.GetImgNumPath)
	self:RegisterApi("TextStr1", self.GetTextStr1)
	self:RegisterApi("TextStr2", self.GetTextStr2)
	self:RegisterApi("ImgChapterPath", self.GetImgChapterPath)
end

function ActivityNewDollStoryUIApi:GetImgChapterPath(value)
	if value == 0 then
		return self:GetResUrl(5000000)
	elseif value == 1 then
		return self:GetResUrl(5000001)
	elseif value == 2 then
		return self:GetResUrl(5000002)
	elseif value == 3 then
		return self:GetResUrl(5000003)
	elseif value == 4 then
		return self:GetResUrl(5000004)
	elseif value == 5 then
		return self:GetResUrl(5000005)
	elseif value == 6 then
		return self:GetResUrl(5000006)
	elseif value == 7 then
		return self:GetResUrl(5000007)
	elseif value == 8 then
		return self:GetResUrl(5000008)
	elseif value == 9 then
		return self:GetResUrl(5000009)
	end
end

function ActivityNewDollStoryUIApi:GetTextStr2()
	return self:GetCfgText(3300304)
end

function ActivityNewDollStoryUIApi:GetTextStr1()
	return self:GetCfgText(3300305)
end

function ActivityNewDollStoryUIApi:GetImgNumPath(value)
	if value == 0 then
		return self:GetResUrl(5000010)
	elseif value == 1 then
		return self:GetResUrl(5000011)
	elseif value == 2 then
		return self:GetResUrl(5000012)
	elseif value == 3 then
		return self:GetResUrl(5000013)
	elseif value == 4 then
		return self:GetResUrl(5000014)
	elseif value == 5 then
		return self:GetResUrl(5000015)
	elseif value == 6 then
		return self:GetResUrl(5000016)
	elseif value == 7 then
		return self:GetResUrl(5000017)
	elseif value == 8 then
		return self:GetResUrl(5000018)
	elseif value == 9 then
		return self:GetResUrl(5000019)
	end
end

function ActivityNewDollStoryUIApi:GetTextCondition()
	return self:GetCfgText(3300301)
end

function ActivityNewDollStoryUIApi:GetTextConditionBefore()
	return string.format(self:GetCfgText(3300302))
end

function ActivityNewDollStoryUIApi:GetTextConditionScore(num)
	return string.format(self:GetCfgText(3300303), num)
end

function ActivityNewDollStoryUIApi:GetTextPanelTitle()
	return self:GetCfgText(1233203)
end

ActivityNewDollStoryUIApi:Init()
