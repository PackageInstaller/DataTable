-- chunkname: @IQIGame\\UIExternalApi\\VirtualPhotoNoticeUIApi.lua

VirtualPhotoNoticeUIApi = BaseLangApi:Extend()

function VirtualPhotoNoticeUIApi:Init()
	self:RegisterApi("GestureTipText4", self.GetGestureTipText4)
	self:RegisterApi("GestureTipText3", self.GetGestureTipText3)
	self:RegisterApi("GestureTipText2", self.GetGestureTipText2)
	self:RegisterApi("GestureTipText1", self.GetGestureTipText1)
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("ConfirmBtnText", self.GetConfirmBtnText)
	self:RegisterApi("NotShowBtnText", self.GetNotShowBtnText)
end

function VirtualPhotoNoticeUIApi:GetGestureTipText4()
	return self:GetCfgText(3504301)
end

function VirtualPhotoNoticeUIApi:GetGestureTipText3()
	return self:GetCfgText(3504302)
end

function VirtualPhotoNoticeUIApi:GetGestureTipText2()
	return self:GetCfgText(3504303)
end

function VirtualPhotoNoticeUIApi:GetGestureTipText1()
	return self:GetCfgText(3504304)
end

function VirtualPhotoNoticeUIApi:GetTextTitle()
	return self:GetCfgText(3504305)
end

function VirtualPhotoNoticeUIApi:GetConfirmBtnText()
	return self:GetCfgText(3504306)
end

function VirtualPhotoNoticeUIApi:GetNotShowBtnText()
	return self:GetCfgText(3504307)
end

VirtualPhotoNoticeUIApi:Init()
