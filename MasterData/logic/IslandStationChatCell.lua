-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/data/IslandStationChatCell.lua

module("logic.extensions.islandstation.data.IslandStationChatCell", package.seeall)

local IslandStationChatCell = class("IslandStationChatCell")

function IslandStationChatCell:ctor()
	self:onResetChat()
end

function IslandStationChatCell:onUpdateChat(dialoguePlanId, dialogueId, id)
	local data = IslandStationConfig.instance:getDialogueData(dialoguePlanId, dialogueId, id)

	if data == nil then
		printError(string.format("配置缺失, 更新chatCell失败( %s-%s-%s )", dialoguePlanId, dialogueId, id))

		return
	end

	self._dialoguePlanId = dialoguePlanId
	self._dialogueId = dialogueId
	self._chatId = id
	self._content = data.content
	self._problemDesc = data.desc
	self._waitAnswer = data.waitAnswer or {}
	self._autoNext = data.autoNext
	self._isEnd = data.isEnd
	self._tag = data.tag
	self._fetterAdd = data.fetterAdd
	self._npcId = data.npcId

	local npcData = GoddessShopConfig.instance:getGirlNpcCfg(self._npcId)

	self._name = npcData.name
	self._iconPath = npcData.iconPath
end

function IslandStationChatCell:onResetChat()
	self._dialoguePlanId = 0
	self._dialogueId = 0
	self._chatId = 0
	self._content = ""
	self._problemDesc = ""
	self._waitAnswer = {}
	self._autoNext = 0
	self._isEnd = false
	self._tag = 0
	self._fetterAdd = 0
	self._npcId = 0
	self._name = ""
	self._iconPath = ""
end

function IslandStationChatCell:getDialoguePlanId()
	return self._dialoguePlanId
end

function IslandStationChatCell:getDialogueId()
	return self._dialogueId
end

function IslandStationChatCell:getChatId()
	return self._chatId
end

function IslandStationChatCell:getContent()
	return self._content
end

function IslandStationChatCell:getContentValue()
	local str

	if self._fetterAdd ~= 0 then
		if self._fetterAdd < 0 then
			if not self._fetterAdd then
				local value = "+" .. self._fetterAdd

				str = string.format("<color=#eb4624>(好感度%s)</color>", value)
			end
		end
	end

	return str
end

function IslandStationChatCell:getProblemDesc()
	return self._problemDesc
end

function IslandStationChatCell:getWaitAnswer()
	return self._waitAnswer
end

function IslandStationChatCell:isWaitAnswer()
	return #self._waitAnswer > 0
end

function IslandStationChatCell:getAutoNext()
	return self._autoNext
end

function IslandStationChatCell:isEnd()
	return self._isEnd
end

function IslandStationChatCell:getTag()
	return self._tag
end

function IslandStationChatCell:getName()
	return self._name
end

function IslandStationChatCell:getIconPath()
	return self._iconPath
end

function IslandStationChatCell:getFetterChange()
	return self._fetterAdd
end

function IslandStationChatCell:updateFetterChange(value)
	self._fetterAdd = value
end

return IslandStationChatCell
