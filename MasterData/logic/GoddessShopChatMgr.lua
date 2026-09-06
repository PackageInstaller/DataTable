-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessshop/data/GoddessShopChatMgr.lua

module("logic.extensions.goddessshop.data.GoddessShopChatMgr", package.seeall)

local GoddessShopChatMgr = class("GoddessShopChatMgr")

function GoddessShopChatMgr:ctor(activityId)
	self._activityId = activityId
	self._chatTrees = {}
	self._chatCellDirectory = {}
	self._chatCellPool = self:_creatChatCellPool()
end

function GoddessShopChatMgr:dispose()
	for key, tree in pairs(self._chatTrees) do
		tree:dispose()

		self._chatTrees[key] = nil
	end

	for key, cell in pairs(self._chatCellDirectory) do
		self:_returnChatCell(cell)

		self._chatCellDirectory[key] = nil
	end

	if self._chatCellPool then
		self._chatCellPool:clear()
	end
end

function GoddessShopChatMgr:getChatCell(girlId, dialogueId, chatId, dialogueIndex)
	local key = MmUtil.getUniqueKey(girlId, dialogueId, chatId, dialogueIndex)

	if self._chatCellDirectory[key] == nil then
		self._chatCellDirectory[key] = self:_fetchChatCell(girlId, dialogueId, chatId)
	end

	return self._chatCellDirectory[key]
end

function GoddessShopChatMgr:getChatIdList(girlId, dialogueId, chatId)
	local tree = self:getChatTree(girlId, dialogueId)

	return tree:getChatIdListFromRoot(chatId)
end

function GoddessShopChatMgr:getChatIdListFinish(girlId, dialogueId, chatIds)
	local tree = self:getChatTree(girlId, dialogueId)

	return tree:getChatIdListByAnswer(chatIds)
end

function GoddessShopChatMgr:getChatTree(girlId, dialogueId)
	local key = MmUtil.getUniqueKey(girlId, dialogueId)

	if self._chatTrees[key] == nil then
		local dialoguePlanId = GoddessShopConfig.instance:getDialoguePlanId(self._activityId, girlId)

		self._chatTrees[key] = GoddessShopChatTree.New(dialoguePlanId, dialogueId)
	end

	return self._chatTrees[key]
end

function GoddessShopChatMgr:_fetchChatCell(girlId, dialogueId, chatId)
	local cell = self._chatCellPool:fetchObject()
	local dialoguePlanId = GoddessShopConfig.instance:getDialoguePlanId(self._activityId, girlId)

	cell:onUpdateChat(dialoguePlanId, dialogueId, chatId)

	return cell
end

function GoddessShopChatMgr:_returnChatCell(cell)
	self._chatCellPool:returnObject(cell)
end

function GoddessShopChatMgr:_creatChatCellPool()
	local function createFunc()
		return GoddessShopChatCell.New()
	end

	local function disposeFunc(comp)
		comp:onResetChat()
	end

	local function resetFunc(comp)
		comp:onResetChat()
	end

	return ObjectPool.New(20, createFunc, disposeFunc, resetFunc)
end

return GoddessShopChatMgr
