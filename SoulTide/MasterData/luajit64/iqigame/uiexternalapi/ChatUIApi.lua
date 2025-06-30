-- chunkname: @IQIGame\\UIExternalApi\\ChatUIApi.lua

ChatUIApi = BaseLangApi:Extend()

function ChatUIApi:Init()
	self:RegisterApi("goBtnSureTxt", self.GetBtnSureTxt)
	self:RegisterApi("TabBtn", self.GetTabBtnText)
	self:RegisterApi("RoomNumLab", self.GetRoomNumLab)
	self:RegisterApi("goChannelCellTitle", self.GetChannelCellTitle)
	self:RegisterApi("CurrentRoomPlayerNum", self.GetCurrentRoomPlayerNum)
	self:RegisterApi("NewMsg", self.GetNewMsg)
	self:RegisterApi("infoBtnTxt", self.GetInfoBtnTxt)
	self:RegisterApi("addFriendBtnTxt", self.GetAddFriendBtnTxt)
	self:RegisterApi("visitBtnTxt", self.GetVisitBtnTxt)
	self:RegisterApi("reportBtnTxt", self.GetReportBtnTxt)
	self:RegisterApi("healthyGameNotice", self.GetHealthyGameNotice)
	self:RegisterApi("goForbiddenTxt", self.GetForbiddenTxt)
	self:RegisterApi("goPrivateName", self.GetPrivatePlayerName)
	self:RegisterApi("btnChangeRoom", self.GetBtnChangeRoom)
	self:RegisterApi("SysToggleTxt1", self.GetSysToggleTxt1)
	self:RegisterApi("SysToggleTxt2", self.GetSysToggleTxt2)
	self:RegisterApi("btnDeleteTxt", self.GetBtnDeleteTxt)
	self:RegisterApi("GetPlayerLv", self.GetPlayerLv)
	self:RegisterApi("GetPlayerName", self.GetPlayerName)
	self:RegisterApi("GetPlayerNum", self.GetPlayerNum)
	self:RegisterApi("emotion", self.GetEmotionPath)
	self:RegisterApi("msgDefaultTxt", self.GetMsgDefaultTxt)
	self:RegisterApi("roomNumDefaultTxt", self.GetRoomNumDefaultTxt)
	self:RegisterApi("EmptyViewText", self.GetEmptyViewText)
	self:RegisterApi("expViewGroupName", self.GetExpViewGroupName)
	self:RegisterApi("ExpListEmptyViewText", self.GetExpListEmptyViewText)
	self:RegisterApi("Emo_BtnDefaultTxt", self.GetEmoBtnDefaultTxt)
	self:RegisterApi("Emo_BtnSureTxt", self.GetEmoBtnSureTxt)
	self:RegisterApi("Emo_Title", self.EmoTitle)
	self:RegisterApi("Emo_Name", self.GetEmoName)
	self:RegisterApi("Emo_Num", self.GetEmoNum)
	self:RegisterApi("Emo_Speed", self.GetEmoSpeed)
end

function ChatUIApi:GetExpViewGroupName(name)
	return name
end

function ChatUIApi:GetExpListEmptyViewText()
	return self:GetCfgText(1110033)
end

function ChatUIApi:GetEmoSpeed()
	return 10
end

function ChatUIApi:GetEmoNum(num)
	return num
end

function ChatUIApi:GetEmoName(name)
	return name
end

function ChatUIApi:EmoTitle()
	return self:GetCfgText(1110028)
end

function ChatUIApi:GetEmoBtnSureTxt()
	return self:GetCfgText(1110029)
end

function ChatUIApi:GetEmoBtnDefaultTxt()
	return self:GetCfgText(1110030)
end

function ChatUIApi:GetEmotionPath(CfgEmoticonData)
	return UIGlobalApi.ImagePath .. CfgEmoticonData.Emoticons .. "0" .. CfgEmoticonData.startIndex .. ".png"
end

function ChatUIApi:GetPlayerName(value)
	return value
end

function ChatUIApi:GetPlayerNum(value)
	return self:GetCfgText(1110021) .. value
end

function ChatUIApi:GetPlayerLv(value)
	return self:FontSize(value, 18)
end

function ChatUIApi:GetSysToggleTxt1()
	return self:GetCfgText(1110025)
end

function ChatUIApi:GetSysToggleTxt2()
	return self:GetCfgText(1110024)
end

function ChatUIApi:GetBtnDeleteTxt()
	return self:GetCfgText(1110032)
end

function ChatUIApi:GetBtnChangeRoom()
	return self:GetCfgText(1110026)
end

function ChatUIApi:GetPrivatePlayerName(pName)
	return pName
end

function ChatUIApi:GetBtnSureTxt()
	return self:GetCfgText(1110001)
end

function ChatUIApi:GetTabBtnText(index)
	if index == 4 then
		return self:GetCfgText(1110004)
	elseif index == 5 then
		return self:GetCfgText(1110005)
	else
		return self:GetCfgText(1110003)
	end
end

function ChatUIApi:GetRoomNumLab(max, min)
	return self:GetCfgText(1110026) .. "(" .. min .. "-" .. max .. ")"
end

function ChatUIApi:GetChannelCellTitle(channel, name)
	if channel == ChatModule.CHANNEL_SYSTEM then
		return "[" .. self:GetCfgText(1110002) .. "]" .. name
	elseif channel == ChatModule.CHANNEL_PRIVATE_CHAT then
		return "[" .. self:GetCfgText(1110004) .. "]" .. name
	elseif channel == ChatModule.CHANNEL_GUILD then
		return "[" .. self:GetCfgText(1110005) .. "]" .. name
	elseif channel == ChatModule.CHANNEL_WORLD then
		return "[" .. self:GetCfgText(1110003) .. "]" .. name
	end
end

function ChatUIApi:GetCurrentRoomPlayerNum(roomNum, onlineCount)
	if roomNum <= 3 or onlineCount >= 250 then
		onlineCountDesc = "（" .. self:GetCfgText(1110008) .. "）"
	else
		onlineCountDesc = ""
	end

	return self:GetCfgText(1110007) .. roomNum .. onlineCountDesc
end

function ChatUIApi:GetNewMsg(newMsgNum)
	return self:GetCfgText(1110013) .. newMsgNum .. self:GetCfgText(1110014)
end

function ChatUIApi:GetInfoBtnTxt()
	return self:GetCfgText(1110015)
end

function ChatUIApi:GetAddFriendBtnTxt()
	return self:GetCfgText(1110015)
end

function ChatUIApi:GetVisitBtnTxt()
	return self:GetCfgText(1110017)
end

function ChatUIApi:GetReportBtnTxt()
	return self:GetCfgText(1110018)
end

function ChatUIApi:GetHealthyGameNotice()
	return self:GetCfgText(1110019)
end

function ChatUIApi:GetForbiddenTxt()
	return self:GetCfgText(1110027)
end

function ChatUIApi:GetMsgDefaultTxt()
	return self:GetCfgText(84)
end

function ChatUIApi:GetRoomNumDefaultTxt()
	return self:GetCfgText(1110031)
end

function ChatUIApi:GetEmptyViewText()
	return self:GetCfgText(1110034)
end

ChatUIApi:Init()
