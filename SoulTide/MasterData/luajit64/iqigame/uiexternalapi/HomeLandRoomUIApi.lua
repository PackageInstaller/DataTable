-- chunkname: @IQIGame\\UIExternalApi\\HomeLandRoomUIApi.lua

HomeLandRoomUIApi = BaseLangApi:Extend()

function HomeLandRoomUIApi:Init()
	self:RegisterApi("TextBtnEdit", self.GetTextBtnEdit)
	self:RegisterApi("TextBtnPurchase", self.GetTextBtnPurchase)
	self:RegisterApi("TextBtnIllustration", self.GetTextBtnIllustration)
	self:RegisterApi("TextBtnTheme", self.GetTextBtnTheme)
	self:RegisterApi("TextRoomName", self.GetTextRoomName)
	self:RegisterApi("TextBtnLock", self.GetTextBtnLock)
	self:RegisterApi("TextBtnCall", self.GetTextBtnCall)
	self:RegisterApi("TextLabel1", self.GetTextLabel1)
	self:RegisterApi("TextTip", self.GetTextTip)
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextRightTopTitle", self.GetTextRightTopTitle)
	self:RegisterApi("IsCanSave", self.GetIsCanSave)
	self:RegisterApi("RewardBoxPath", self.GetRewardBoxPath)
	self:RegisterApi("TextError", self.GetTextError)
	self:RegisterApi("ToggleTitle", self.GetToggleTitle)
	self:RegisterApi("ErrorCallMsg", self.GetErrorCallMsg)
	self:RegisterApi("TextBtnSetRoom", self.GetTextBtnSetRoom)
end

function HomeLandRoomUIApi:GetTextBtnSetRoom()
	return self:GetCfgText(1015581)
end

function HomeLandRoomUIApi:GetTextBtnCall()
	return self:GetCfgText(1015545)
end

function HomeLandRoomUIApi:GetErrorCallMsg(soulName)
	return string.format("%s " .. self:GetCfgText(1015546), soulName)
end

function HomeLandRoomUIApi:GetToggleTitle()
	return {
		{
			0,
			""
		},
		{
			1,
			self:GetCfgText(1015161)
		},
		{
			2,
			self:GetCfgText(1015162)
		},
		{
			3,
			self:GetCfgText(1015163)
		},
		{
			4,
			self:GetCfgText(1015164)
		},
		{
			5,
			self:GetCfgText(1015165)
		},
		{
			7,
			self:GetCfgText(1015178)
		}
	}
end

function HomeLandRoomUIApi:GetTextError(name)
	return string.format("[%s]" .. self:GetCfgText(1014010), name)
end

function HomeLandRoomUIApi:GetRewardBoxPath(open)
	if open then
		return self:GetResUrl(3003001)
	end

	return self:GetResUrl(3003002)
end

function HomeLandRoomUIApi:GetIsCanSave(type)
	if type == 1 then
		return self:GetCfgText(1015541)
	elseif type == 2 then
		return self:GetCfgText(1015542)
	end

	return ""
end

function HomeLandRoomUIApi:GetTextRightTopTitle()
	return self:GetCfgText(1015543)
end

function HomeLandRoomUIApi:GetTextBtnLock()
	return self:GetCfgText(1015021)
end

function HomeLandRoomUIApi:GetTextTitle()
	return self:GetCfgText(1015543)
end

function HomeLandRoomUIApi:GetTextBtnEdit(isEng)
	if isEng then
		return self:GetCfgText(1015544)
	end

	return self:GetCfgText(1015055)
end

function HomeLandRoomUIApi:GetTextBtnPurchase(isEng)
	if isEng then
		return self:GetCfgText(1015548)
	end

	return self:GetCfgText(1015056)
end

function HomeLandRoomUIApi:GetTextBtnIllustration(isEng)
	if isEng then
		return self:GetCfgText(1015580)
	end

	return self:GetCfgText(1015539)
end

function HomeLandRoomUIApi:GetTextBtnTheme(isEng)
	if isEng then
		return self:GetCfgText(1015549)
	end

	return self:GetCfgText(1015059)
end

function HomeLandRoomUIApi:GetTextRoomName(name)
	return name
end

function HomeLandRoomUIApi:GetTextLabel1()
	return self:GetCfgText(1240002)
end

function HomeLandRoomUIApi:GetTextTip(str)
	return self:GetCfgText(1015051) .. str
end

HomeLandRoomUIApi:Init()
