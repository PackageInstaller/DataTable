-- chunkname: @IQIGame\\UIExternalApi\\HomeLandChangeRoomUIApi.lua

HomeLandChangeRoomUIApi = BaseLangApi:Extend()

function HomeLandChangeRoomUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextTitle1", self.GetTextTitle1)
	self:RegisterApi("Text2", self.GetText2)
	self:RegisterApi("BtnText", self.GetBtnText)
	self:RegisterApi("TextCurrent", self.GetTextCurrent)
	self:RegisterApi("TextLock", self.GetTextLock)
	self:RegisterApi("BtnText1", self.GetBtnText1)
	self:RegisterApi("BtnCastleTitle", self.GetBtnCastleTitle)
	self:RegisterApi("ImgStartPath", self.GetImgStartPath)
	self:RegisterApi("ErrorMsg", self.GetErrorMsg)
	self:RegisterApi("LockDes", self.GetLockDes)
	self:RegisterApi("NowText3", self.GetNowText3)
	self:RegisterApi("TextAddDes", self.GetTextAddDes)
	self:RegisterApi("RoomBgPath", self.GetRoomBgPath)
	self:RegisterApi("TextNew", self.GetTextNew)
	self:RegisterApi("PageIndex", self.GetPageIndex)
end

function HomeLandChangeRoomUIApi:GetPageIndex(startIndex, endIndex)
	return string.format("%s - %s", startIndex, endIndex)
end

function HomeLandChangeRoomUIApi:GetTextNew()
	return self:GetCfgText(1015535)
end

function HomeLandChangeRoomUIApi:GetRoomBgPath(themeID)
	if themeID == 1 then
		return self:GetResUrl(3005001)
	elseif themeID == 2 then
		return self:GetResUrl(3005002)
	elseif themeID == 3 then
		return self:GetResUrl(3005004)
	elseif themeID == 4 then
		return self:GetResUrl(3005005)
	elseif themeID == 5 then
		return self:GetResUrl(3005006)
	elseif themeID == 6 then
		return self:GetResUrl(3005007)
	elseif themeID == 7 then
		return self:GetResUrl(3005008)
	elseif themeID == 8 then
		return self:GetResUrl(3005009)
	elseif themeID == 9 then
		return self:GetResUrl(3005010)
	elseif themeID == 10 then
		return self:GetResUrl(3005011)
	end

	return self:GetResUrl(3005003)
end

function HomeLandChangeRoomUIApi:GetTextAddDes(num, isLock)
	if num == 0 then
		return ""
	end

	if isLock then
		return string.format(self:GetCfgText(1015506), num)
	end

	return string.format(self:GetCfgText(1015507), num)
end

function HomeLandChangeRoomUIApi:GetNowText3()
	return self:GetCfgText(1214003)
end

function HomeLandChangeRoomUIApi:GetLockDes()
	return self:GetCfgText(1015501)
end

function HomeLandChangeRoomUIApi:GetErrorMsg()
	return self:GetCfgText(1015502)
end

function HomeLandChangeRoomUIApi:GetImgStartPath(top)
	if top then
		return ""
	end

	return ""
end

function HomeLandChangeRoomUIApi:GetBtnCastleTitle()
	return self:GetCfgText(1015503)
end

function HomeLandChangeRoomUIApi:GetBtnText1()
	return self:GetCfgText(1015508)
end

function HomeLandChangeRoomUIApi:GetTextTitle(isEng)
	if isEng then
		return self:GetCfgText(1015505)
	end

	return self:GetCfgText(1015504)
end

function HomeLandChangeRoomUIApi:GetTextTitle1()
	return self:GetCfgText(1015069)
end

function HomeLandChangeRoomUIApi:GetText2(score)
	return self:GetCfgText(1015070) .. score
end

function HomeLandChangeRoomUIApi:GetBtnText()
	return self:GetCfgText(1015071)
end

function HomeLandChangeRoomUIApi:GetTextCurrent()
	return self:GetCfgText(1015072)
end

function HomeLandChangeRoomUIApi:GetTextLock(num, needNum)
	if needNum <= num then
		return BaseLangApi.TextColor[16] .. self:GetCfgText(1015128) .. BaseLangApi.TextColor[0] .. BaseLangApi.TextColor[12] .. num .. "/" .. needNum .. BaseLangApi.TextColor[0]
	end

	return BaseLangApi.TextColor[16] .. self:GetCfgText(1015128) .. BaseLangApi.TextColor[0] .. BaseLangApi.TextColor[12] .. num .. "/" .. needNum .. BaseLangApi.TextColor[0]
end

HomeLandChangeRoomUIApi:Init()
