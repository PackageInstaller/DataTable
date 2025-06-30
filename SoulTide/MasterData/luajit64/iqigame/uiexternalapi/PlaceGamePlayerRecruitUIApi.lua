-- chunkname: @IQIGame\\UIExternalApi\\PlaceGamePlayerRecruitUIApi.lua

PlaceGamePlayerRecruitUIApi = BaseLangApi:Extend()

function PlaceGamePlayerRecruitUIApi:Init()
	self:RegisterApi("TextSelectDes", self.GetTextSelectDes)
	self:RegisterApi("TextSelectValue", self.GetTextSelectValue)
	self:RegisterApi("TextLv", self.GetTextLv)
end

function PlaceGamePlayerRecruitUIApi:GetTextLv(num)
	return string.format("%s", num)
end

function PlaceGamePlayerRecruitUIApi:GetTextSelectValue(num, maxNum)
	return string.format("%s/%s", num, maxNum)
end

function PlaceGamePlayerRecruitUIApi:GetTextSelectDes(num)
	return string.format("%s", num)
end

PlaceGamePlayerRecruitUIApi:Init()
