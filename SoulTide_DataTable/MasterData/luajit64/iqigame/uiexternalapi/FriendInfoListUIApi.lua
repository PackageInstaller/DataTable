-- chunkname: @IQIGame\\UIExternalApi\\FriendInfoListUIApi.lua

FriendInfoListUIApi = BaseLangApi:Extend()

function FriendInfoListUIApi:Init()
	self:RegisterApi("PanelTitle", self.GetPanelTitle)
	self:RegisterApi("TextLv", self.GetTextLv)
	self:RegisterApi("TextPlayerID", self.GetTextPlayerID)
	self:RegisterApi("InfoCarTitle", self.GetInfoCarTitle)
	self:RegisterApi("TextName1", self.GetTextName1)
	self:RegisterApi("TextName2", self.GetTextName2)
	self:RegisterApi("InfoExhibitionTitle", self.GetInfoExhibitionTitle)
	self:RegisterApi("TextBtnPreviewCard", self.GetTextBtnPreviewCard)
	self:RegisterApi("TextBtnContact", self.GetTextBtnContact)
end

function FriendInfoListUIApi:GetTextBtnContact()
	return self:GetCfgText(2400550)
end

function FriendInfoListUIApi:GetTextBtnPreviewCard()
	return self:GetCfgText(2400551)
end

function FriendInfoListUIApi:GetInfoExhibitionTitle()
	return self:GetCfgText(2400552)
end

function FriendInfoListUIApi:GetTextName2()
	return self:GetCfgText(2400553)
end

function FriendInfoListUIApi:GetTextName1()
	return self:GetCfgText(2400554)
end

function FriendInfoListUIApi:GetInfoCarTitle()
	return self:GetCfgText(2400555)
end

function FriendInfoListUIApi:GetTextPlayerID(guid)
	return string.format(self:GetCfgText(2400556), guid)
end

function FriendInfoListUIApi:GetTextLv()
	return self:GetCfgText(2400557)
end

function FriendInfoListUIApi:GetPanelTitle()
	return self:GetCfgText(2400558)
end

FriendInfoListUIApi:Init()
