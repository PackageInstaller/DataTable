-- chunkname: @IQIGame\\UIExternalApi\\FriendUIApi.lua

FriendUIApi = BaseLangApi:Extend()

function FriendUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("TabBtnText", self.GetTabBtnText)
	self:RegisterApi("SearchModePlayerIDText", self.GetSearchModePlayerIDText)
	self:RegisterApi("FriendNumText", self.GetFriendNumText)
	self:RegisterApi("OnlineTimeLabel", self.GetOnlineTimeLabel)
	self:RegisterApi("PrivateChatBtnText", self.GetPrivateChatBtnText)
	self:RegisterApi("AgreeBtnText", self.GetAgreeBtnText)
	self:RegisterApi("RefuseBtnText", self.GetRefuseBtnText)
	self:RegisterApi("ApplyBtnText", self.GetApplyBtnText)
	self:RegisterApi("DeleteMuteBtnText", self.GetDeleteMuteBtnText)
	self:RegisterApi("MuteBtnText", self.GetMuteBtnText)
	self:RegisterApi("ClearMuteBtnText", self.GetClearMuteBtnText)
	self:RegisterApi("HasAppliedText", self.GetHasAppliedText)
	self:RegisterApi("HasDeleteMuteText", self.GetHasDeleteMuteText)
	self:RegisterApi("AgreeAllApplyBtnText", self.GetAgreeAllApplyBtnText)
	self:RegisterApi("ClearAllApplyBtnText", self.GetClearAllApplyBtnText)
	self:RegisterApi("RecommendBtnText", self.GetRecommendBtnText)
	self:RegisterApi("SearchBtnText", self.GetSearchBtnText)
	self:RegisterApi("SearchModeApplyAllBtnText", self.GetSearchModeApplyAllBtnText)
	self:RegisterApi("SearchModeReturnBtnText", self.GetSearchModeReturnBtnText)
	self:RegisterApi("SearchInputFieldPlaceholder", self.GetSearchInputFieldPlaceholder)
	self:RegisterApi("NoneTitleText", self.GetNoneTitleText)
	self:RegisterApi("NoneBubbleText", self.GetNoneBubbleText)
	self:RegisterApi("NoneTipText", self.GetNoneTipText)
	self:RegisterApi("NoneBubbleApplyText", self.GetNoneBubbleApplyText)
	self:RegisterApi("NoneTipApplyText", self.GetNoneTipApplyText)
	self:RegisterApi("NoneBubbleMuteText", self.GetNoneBubbleMuteText)
	self:RegisterApi("NoneTipMuteText", self.GetNoneTipMuteText)
end

function FriendUIApi:GetTitleText()
	return self:GetCfgText(1108009)
end

function FriendUIApi:GetTabBtnText(index)
	if index == 1 then
		return self:GetCfgText(1108001)
	elseif index == 2 then
		return self:GetCfgText(1108002)
	elseif index == 3 then
		return self:GetCfgText(1108003)
	elseif index == 4 then
		return self:GetCfgText(1108004)
	else
		return ""
	end
end

function FriendUIApi:GetSearchModePlayerIDText(guid)
	return self:GetCfgText(1108010) .. self:Space(1) .. guid
end

function FriendUIApi:GetFriendNumText(tabIndex, friendNum, maxNum)
	if tabIndex == 1 then
		self:GetCfgText(234, friendNum, maxNum)
	elseif tabIndex == 2 then
		self:GetCfgText(235, friendNum, maxNum)
	elseif tabIndex == 3 then
		self:GetCfgText(236, friendNum, maxNum)
	elseif tabIndex == 4 then
		self:GetCfgText(237, friendNum, maxNum)
	end
end

function FriendUIApi:GetOnlineTimeLabel()
	return self:GetCfgText(3503001)
end

function FriendUIApi:GetPrivateChatBtnText()
	return self:GetCfgText(3503002)
end

function FriendUIApi:GetAgreeBtnText()
	return self:GetCfgText(3503003)
end

function FriendUIApi:GetRefuseBtnText()
	return self:GetCfgText(3503004)
end

function FriendUIApi:GetApplyBtnText()
	return self:GetCfgText(3503005)
end

function FriendUIApi:GetDeleteMuteBtnText()
	return self:GetCfgText(3503006)
end

function FriendUIApi:GetMuteBtnText()
	return self:GetCfgText(3503007)
end

function FriendUIApi:GetClearMuteBtnText()
	return self:GetCfgText(3503008)
end

function FriendUIApi:GetHasAppliedText()
	return self:GetCfgText(3503009)
end

function FriendUIApi:GetHasDeleteMuteText()
	return self:GetCfgText(3503010)
end

function FriendUIApi:GetAgreeAllApplyBtnText()
	return self:GetCfgText(3503011)
end

function FriendUIApi:GetClearAllApplyBtnText()
	return self:GetCfgText(3503012)
end

function FriendUIApi:GetRecommendBtnText()
	return self:GetCfgText(3503013)
end

function FriendUIApi:GetSearchBtnText()
	return self:GetCfgText(3503014)
end

function FriendUIApi:GetSearchModeApplyAllBtnText()
	return self:GetCfgText(3503015)
end

function FriendUIApi:GetSearchModeReturnBtnText()
	return self:GetCfgText(3503016)
end

function FriendUIApi:GetSearchInputFieldPlaceholder()
	return self:GetCfgText(3503017)
end

function FriendUIApi:GetNoneTitleText()
	return self:GetCfgText(3503018)
end

function FriendUIApi:GetNoneBubbleText()
	return self:GetCfgText(3503019)
end

function FriendUIApi:GetNoneTipText()
	return self:GetCfgText(3503020)
end

function FriendUIApi:GetNoneBubbleApplyText()
	return self:GetCfgText(3503019)
end

function FriendUIApi:GetNoneTipApplyText()
	return self:GetCfgText(3503021)
end

function FriendUIApi:GetNoneBubbleMuteText()
	return self:GetCfgText(3503019)
end

function FriendUIApi:GetNoneTipMuteText()
	return self:GetCfgText(3503022)
end

FriendUIApi:Init()
