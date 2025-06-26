-- chunkname: @IQIGame\\UIExternalApi\\MemoryUIApi.lua

MemoryUIApi = BaseLangApi:Extend()

function MemoryUIApi:Init()
	self:RegisterApi("GetLabBtnCancelTxt", self.GetBtnCancelTxt)
	self:RegisterApi("GetLabRewardCheckTxt", self.GetLabRewardCheckTxt)
	self:RegisterApi("GetFashionTitleTxt", self.GetFashionTitleTxt)
	self:RegisterApi("GetReachLifeLevelTxt", self.GetReachLifeLevelTxt)
	self:RegisterApi("GetCompoundDessTxt", self.GetCompoundDessTxt)
	self:RegisterApi("GetNoGetGiftNextChapter", self.GetNoGetGiftNextChapter)
	self:RegisterApi("GetLockPlayText", self.GetLockPlayText)
	self:RegisterApi("TextMsg", self.GetTextMsg)
	self:RegisterApi("UnlockIconPath", self.GetUnlockIconPath)
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("TextBtnGetReward", self.GetTextBtnGetReward)
	self:RegisterApi("TextSpend", self.GetTextSpend)
	self:RegisterApi("TextContinue", self.GetTextContinue)
	self:RegisterApi("TextAdd", self.GetTextAdd)
	self:RegisterApi("TextAddTitle", self.GetTextAddTitle)
	self:RegisterApi("TitleText1", self.GetTitleText1)
	self:RegisterApi("TitleText3", self.GetTitleText3)
	self:RegisterApi("TitleText4", self.GetTitleText4)
	self:RegisterApi("TextAttribute", self.GetTextAttribute)
	self:RegisterApi("TextName", self.GetTextName)
	self:RegisterApi("TextBtnAttribute", self.GetTextBtnAttribute)
	self:RegisterApi("MemoryUIBGM", self.GetMemoryUIBGM)
	self:RegisterApi("TextOrder", self.GetTextOrder)
	self:RegisterApi("TextStory", self.GetTextStory)
	self:RegisterApi("TextLock", self.GetTextLock)
	self:RegisterApi("TextLockDes", self.GetTextLockDes)
	self:RegisterApi("TextUnLock", self.GetTextUnLock)
	self:RegisterApi("TextUnLockDes", self.GetTextUnLockDes)
	self:RegisterApi("TextBtnClose", self.GetTextBtnClose)
	self:RegisterApi("TextUnLock_2", self.GetTextUnLock_2)
	self:RegisterApi("MsgChangeBtnLabel", self.GetMsgChangeBtnLabel)
end

function MemoryUIApi:GetMsgChangeBtnLabel(unlock)
	if unlock then
		return self:GetCfgText(2300084)
	end

	return self:GetCfgText(2300085)
end

function MemoryUIApi:GetTextUnLock_2(state)
	if state == 1 then
		return self:GetCfgText(2300082)
	end

	return self:GetCfgText(2300083)
end

function MemoryUIApi:GetTextBtnClose()
	return self:GetCfgText(1317026)
end

function MemoryUIApi:GetTextUnLockDes()
	return self:GetCfgText(2300078)
end

function MemoryUIApi:GetTextUnLock()
	return self:GetCfgText(2300079)
end

function MemoryUIApi:GetTextLockDes()
	return self:GetCfgText(2300077)
end

function MemoryUIApi:GetTextLock()
	return self:GetCfgText(1190006)
end

function MemoryUIApi:GetTextStory()
	return self:GetCfgText(1107018)
end

function MemoryUIApi:GetTextOrder(str)
	return string.format(self:GetCfgText(2300096), str)
end

function MemoryUIApi:GetMemoryUIBGM()
	return 5
end

function MemoryUIApi:GetTextBtnAttribute()
	return self:GetCfgText(2300070)
end

function MemoryUIApi:GetTextName()
	return "???"
end

function MemoryUIApi:GetTextAttribute(top, str)
	if top then
		return str
	end

	return str
end

function MemoryUIApi:GetTitleText4()
	return self:GetCfgText(2300071)
end

function MemoryUIApi:GetTitleText3()
	return self:GetCfgText(2300072)
end

function MemoryUIApi:GetTitleText1()
	return self:GetCfgText(2300073)
end

function MemoryUIApi:GetTextAddTitle()
	return self:GetCfgText(2300074)
end

function MemoryUIApi:GetTextAdd()
	return self:GetCfgText(2300074) .. ":？？？"
end

function MemoryUIApi:GetTextContinue()
	return self:GetCfgText(2300075)
end

function MemoryUIApi:GetTextSpend()
	return self:GetCfgText(1233108) .. "："
end

function MemoryUIApi:GetTextBtnGetReward()
	return self:GetCfgText(1229060)
end

function MemoryUIApi:GetTextTitle()
	return self:GetCfgText(1160031)
end

function MemoryUIApi:GetUnlockIconPath()
	return self:GetResUrl(1201001)
end

function MemoryUIApi:GetTextMsg(num)
	return string.format(self:GetCfgText(1014081) .. self:GetCfgText(2300076), num)
end

function MemoryUIApi:GetLockPlayText(value)
	return self:GetCfgText(1170006)
end

function MemoryUIApi:GetNoGetGiftNextChapter(value)
	return self:GetCfgText(1170007)
end

function MemoryUIApi:GetCompoundDessTxt(value)
	return self:GetCfgText(1170005)
end

function MemoryUIApi:GetReachLifeLevelTxt(value)
	return self:GetCfgText(1170000) .. value .. self:GetCfgText(1170001)
end

function MemoryUIApi:GetBtnCancelTxt()
	return self:GetCfgText(1170002)
end

function MemoryUIApi:GetLabRewardCheckTxt()
	return self:GetCfgText(1170003)
end

function MemoryUIApi:GetFashionTitleTxt()
	return self:GetCfgText(1170004)
end

MemoryUIApi:Init()
