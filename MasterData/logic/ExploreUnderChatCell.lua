-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/data/ExploreUnderChatCell.lua

module("logic.extensions.exploreunder.data.ExploreUnderChatCell", package.seeall)

local ExploreUnderChatCell = class("ExploreUnderChatCell")

function ExploreUnderChatCell:ctor()
	self:onResetChat()
end

function ExploreUnderChatCell:onUpdateChat(dialoguePlanId, dialogueId, chatId)
	local data = ExploreUnderConfig.instance:getDialogueData(dialoguePlanId, dialogueId, chatId)

	if data == nil then
		printError(string.format("错误！缺失配置( yt-运营-探索地宫走格子.xlsx | export_对话事件 | dialoguePlanId:%s, dialogueId:%s, id:%s )", dialoguePlanId, dialogueId, chatId))

		return
	end

	self._dialoguePlanId = dialoguePlanId
	self._dialogueId = dialogueId
	self._chatId = chatId
	self._content = data.content
	self._waitAnswer = data.waitAnswer or {}
	self._answerIcon = data.answerIcon or {}
	self._continueHandler = data.continueHandler
	self._answerHandler = data.answerHandler
	self._extInfoHandler = data.extInfoHandler
	self._isEnd = data.isEnd

	local tag = checknumber(data.tag)

	self._tag = tag == 0 and 1 or tag
	self._npcId = data.npcId

	local npcData = GoddessShopConfig.instance:getNpcData(self._npcId)

	if npcData then
		self._name = npcData.name
		self._iconPath = npcData.iconPath
	end
end

function ExploreUnderChatCell:onResetChat()
	self._dialoguePlanId = 0
	self._dialogueId = 0
	self._chatId = 0
	self._content = ""
	self._waitAnswer = {}
	self._answerIcon = {}
	self._isEnd = false
	self._npcId = 0
	self._name = ""
	self._iconPath = ""
	self._tag = 0
	self._continueHandler = nil
	self._answerHandler = nil
	self._extInfoHandler = nil
end

function ExploreUnderChatCell:getDialoguePlanId()
	return self._dialoguePlanId
end

function ExploreUnderChatCell:getDialogueId()
	return self._dialogueId
end

function ExploreUnderChatCell:getChatId()
	return self._chatId
end

function ExploreUnderChatCell:getContent()
	return self._content
end

function ExploreUnderChatCell:getTag()
	return self._tag
end

function ExploreUnderChatCell:getWaitAnswer()
	return self._waitAnswer
end

function ExploreUnderChatCell:getAnswerIcon()
	return self._answerIcon
end

function ExploreUnderChatCell:isEnd()
	return self._isEnd
end

function ExploreUnderChatCell:getName()
	return self._name
end

function ExploreUnderChatCell:getIconPath()
	return self._iconPath
end

function ExploreUnderChatCell:getContinueHandler()
	return self._continueHandler
end

function ExploreUnderChatCell:getAnswerHandler()
	return self._answerHandler
end

function ExploreUnderChatCell:getExtInfoHandler()
	return self._extInfoHandler
end

return ExploreUnderChatCell
