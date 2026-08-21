-- chunkname: @IQIGame\\UIExternalApi\\AmusementParkPlayerUIApi.lua

AmusementParkPlayerUIApi = BaseLangApi:Extend()

function AmusementParkPlayerUIApi:Init()
	self:RegisterApi("ChildToggleName", self.GetChildToggleName)
	self:RegisterApi("TextRecruitNum", self.GetTextRecruitNum)
	self:RegisterApi("TextSpend", self.GetTextSpend)
	self:RegisterApi("TextSoulLv", self.GetTextSoulLv)
	self:RegisterApi("BackStoryUnlockLevel", self.GetBackStoryUnlockLevel)
	self:RegisterApi("TextSoulNum", self.GetTextSoulNum)
end

function AmusementParkPlayerUIApi:GetTextSoulNum(num, maxNum)
	return string.format("%s/%s", num, maxNum)
end

function AmusementParkPlayerUIApi:GetBackStoryUnlockLevel(needLv)
	return string.format(self:GetCfgText(3830050), needLv)
end

function AmusementParkPlayerUIApi:GetTextSoulLv(lv)
	return string.format(self:GetCfgText(3830051), lv)
end

function AmusementParkPlayerUIApi:GetTextSpend(num)
	return string.format("-%s", num)
end

function AmusementParkPlayerUIApi:GetTextRecruitNum(buildLv, playerNum)
	return string.format(self:GetCfgText(3830052), buildLv, playerNum)
end

function AmusementParkPlayerUIApi:GetChildToggleName(index)
	if index == 1 then
		return self:GetCfgText(3830053)
	elseif index == 2 then
		return self:GetCfgText(3830054)
	elseif index == 3 then
		return self:GetCfgText(3830055)
	end

	return ""
end

AmusementParkPlayerUIApi:Init()
