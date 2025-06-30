-- chunkname: @IQIGame\\UIExternalApi\\NewMemoryUIApi.lua

NewMemoryUIApi = BaseLangApi:Extend()

function NewMemoryUIApi:Init()
	self:RegisterApi("GetLockNotice", self.GetLockNotice)
	self:RegisterApi("GetChapterIndex", self.GetChapterIndex)
	self:RegisterApi("GetStartLv", self.GetStartLv)
	self:RegisterApi("GetChapterComplete", self.GetChapterComplete)
	self:RegisterApi("GetLockTitle", self.GetLockTitle)
	self:RegisterApi("GetNewMemoryTitle", self.GetNewMemoryTitle)
	self:RegisterApi("GetMainTitle", self.GetMainTitle)
	self:RegisterApi("GetBranchTitle", self.GetBranchTitle)
	self:RegisterApi("CheckItemNum", self.CheckItemNum)
	self:RegisterApi("LoveUIStyleTitle", self.GetLoveUIStyleTitle)
	self:RegisterApi("NoticeMsg", self.GetNoticeMsg)
	self:RegisterApi("TextName", self.GetTextName)
	self:RegisterApi("TextSpend", self.GetTextSpend)
	self:RegisterApi("NoticeMsg1", self.GetNoticeMsg1)
	self:RegisterApi("UnlockTile", self.GetUnlockTile)
	self:RegisterApi("RewardBoxPath", self.GetRewardBoxPath)
	self:RegisterApi("MemoryTitle", self.GetMemoryTitle)
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextLock", self.GetTextLock)
	self:RegisterApi("TextFavorLv", self.GetTextFavorLv)
	self:RegisterApi("TextReward", self.GetTextReward)
	self:RegisterApi("TextClose", self.GetTextClose)
	self:RegisterApi("TextBtnReview", self.GetTextBtnReview)
	self:RegisterApi("TextBtnLock", self.GetTextBtnLock)
	self:RegisterApi("TextBtnClose", self.GetTextBtnClose)
end

function NewMemoryUIApi:GetTextBtnClose()
	return self:GetCfgText(1105001)
end

function NewMemoryUIApi:GetTextBtnLock()
	return self:GetCfgText(1015021)
end

function NewMemoryUIApi:GetTextBtnReview()
	return self:GetCfgText(1014002)
end

function NewMemoryUIApi:GetTextClose()
	return self:GetCfgText(79)
end

function NewMemoryUIApi:GetTextReward()
	return self:GetCfgText(2300604)
end

function NewMemoryUIApi:GetTextFavorLv(str, isOpen)
	if isOpen then
		return str
	end

	return str
end

function NewMemoryUIApi:GetTextLock()
	return self:GetCfgText(2300097)
end

function NewMemoryUIApi:GetTextTitle(isEng)
	if isEng then
		return self:GetCfgText(2300098)
	end

	return self:GetCfgText(2300099)
end

function NewMemoryUIApi:GetMemoryTitle()
	return self:GetCfgText(1106164)
end

function NewMemoryUIApi:GetRewardBoxPath(type, open)
	local path = ""

	if type == 1 then
		if open then
			return self:GetResUrl(1202001)
		else
			return self:GetResUrl(1202002)
		end
	elseif open then
		return self:GetResUrl(1202001)
	else
		return self:GetResUrl(1202002)
	end

	return path
end

function NewMemoryUIApi:GetUnlockTile()
	return self:GetCfgText(1190011)
end

function NewMemoryUIApi:GetNoticeMsg1()
	return self:GetCfgText(1190012)
end

function NewMemoryUIApi:GetTextSpend(num, totalNum)
	return self:GetCfgText(1190013) .. num .. "/" .. totalNum
end

function NewMemoryUIApi:GetTextName()
	return self:GetCfgText(1190014)
end

function NewMemoryUIApi:GetNoticeMsg(name)
	return "“" .. name .. "”" .. self:GetCfgText(1190015)
end

function NewMemoryUIApi:GetLoveUIStyleTitle(styleLV)
	if styleLV == 1 then
		return self:GetCfgText(1190016)
	elseif styleLV == 2 then
		return self:GetCfgText(1190017)
	elseif styleLV == 3 then
		return self:GetCfgText(1190018)
	elseif styleLV == 4 then
		return self:GetCfgText(1190019)
	elseif styleLV == 5 then
		return self:GetCfgText(1190020)
	elseif styleLV == 6 then
		return self:GetCfgText(1190021)
	end

	return ""
end

function NewMemoryUIApi:CheckItemNum(value)
	return self:GetCfgText(1190010)
end

function NewMemoryUIApi:GetMainTitle(value)
	return self:GetCfgText(1190000)
end

function NewMemoryUIApi:GetBranchTitle(value)
	return self:GetCfgText(1190001)
end

function NewMemoryUIApi:GetNewMemoryTitle(value)
	return value .. self:GetCfgText(1190002)
end

function NewMemoryUIApi:GetChapterComplete(value)
	return BaseLangApi.TextColor[8] .. self:GetCfgText(1190003) .. value .. self:GetCfgText(1190004) .. BaseLangApi.TextColor[0]
end

function NewMemoryUIApi:GetStartLv(value)
	return self:GetCfgText(1190005)
end

function NewMemoryUIApi:GetLockTitle()
	return self:GetCfgText(1190006)
end

function NewMemoryUIApi:GetChapterIndex(value)
	return self:GetCfgText(1190007) .. value .. self:GetCfgText(1190008)
end

function NewMemoryUIApi:GetLockNotice()
	return self:GetCfgText(1190009)
end

NewMemoryUIApi:Init()
