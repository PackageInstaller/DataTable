-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessshop/data/GoddessShopChatCell.lua

module("logic.extensions.goddessshop.data.GoddessShopChatCell", package.seeall)

local GoddessShopChatCell = class("GoddessShopChatCell")

function GoddessShopChatCell:ctor()
	self:onResetChat()
end

function GoddessShopChatCell:onUpdateChat(dialoguePlanId, dialogueId, id)
	local data = GoddessShopConfig.instance:getDialogueData(dialoguePlanId, dialogueId, id)

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
	self._fetterChange = data.fetterChange
	self._moneyChange = 0
	self._npcId = data.npcId

	local npcData = GoddessShopConfig.instance:getNpcData(self._npcId)

	self._name = npcData.name
	self._iconPath = npcData.iconPath
end

function GoddessShopChatCell:onResetChat()
	self._dialoguePlanId = 0
	self._dialogueId = 0
	self._chatId = 0
	self._content = ""
	self._problemDesc = ""
	self._waitAnswer = {}
	self._autoNext = 0
	self._isEnd = false
	self._tag = 0
	self._fetterChange = 0
	self._moneyChange = 0
	self._npcId = 0
	self._name = ""
	self._iconPath = ""
end

function GoddessShopChatCell:getDialoguePlanId()
	return self._dialoguePlanId
end

function GoddessShopChatCell:getDialogueId()
	return self._dialogueId
end

function GoddessShopChatCell:getChatId()
	return self._chatId
end

function GoddessShopChatCell:getContent()
	return self._content
end

function GoddessShopChatCell:getContentValue()
	local str

	if self._fetterChange ~= 0 then
		if self._fetterChange < 0 then
			if not self._fetterChange then
				do
					local value = "+" .. self._fetterChange

					str = string.format("<color=#eb4624>(好感度%s)</color>", value)
				end

				if self._moneyChange ~= 0 then
					str = str == nil and "" or str .. "\n"

					if self._fetterChange < 0 then
						if not self._moneyChange then
							local value = "+" .. self._moneyChange

							str = str .. string.format("<color=#eb4624>(财富%s)</color>", value)
						end
					end
				end
			end
		end
	end

	return str
end

function GoddessShopChatCell:getProblemDesc()
	return self._problemDesc
end

function GoddessShopChatCell:getWaitAnswer()
	return self._waitAnswer
end

function GoddessShopChatCell:isWaitAnswer()
	return #self._waitAnswer > 0
end

function GoddessShopChatCell:getAutoNext()
	return self._autoNext
end

function GoddessShopChatCell:isEnd()
	return self._isEnd
end

function GoddessShopChatCell:getTag()
	return self._tag
end

function GoddessShopChatCell:getName()
	return self._name
end

function GoddessShopChatCell:getIconPath()
	return self._iconPath
end

function GoddessShopChatCell:getFetterChange()
	return self._fetterChange
end

function GoddessShopChatCell:updateFetterChange(value)
	self._fetterChange = value
end

function GoddessShopChatCell:getMoneyChange()
	return self._moneyChange
end

function GoddessShopChatCell:updateMoneyChange(value)
	self._moneyChange = value
end

return GoddessShopChatCell
