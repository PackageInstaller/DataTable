-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/data/IslandStationChatMgr.lua

module("logic.extensions.islandstation.data.IslandStationChatMgr", package.seeall)

local IslandStationChatMgr = class("IslandStationChatMgr")

function IslandStationChatMgr:ctor(activityId)
	self._activityId = activityId
	self._chatTrees = {}
	self._chatCellDirectory = {}
	self._chatCellPool = self:_creatChatCellPool()
end

function IslandStationChatMgr:dispose()
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

function IslandStationChatMgr:getChatCell(girlId, dialogueId, chatId, dialogueIndex)
	local key = MmUtil.getUniqueKey(girlId, dialogueId, chatId, dialogueIndex)

	if self._chatCellDirectory[key] == nil then
		self._chatCellDirectory[key] = self:_fetchChatCell(girlId, dialogueId, chatId)
	end

	return self._chatCellDirectory[key]
end

function IslandStationChatMgr:getChatIdList(girlId, dialogueId, chatId)
	local tree = self:getChatTree(girlId, dialogueId)

	return tree:getChatIdListFromRoot(chatId)
end

function IslandStationChatMgr:getChatIdListFinish(girlId, dialogueId, chatIds)
	local tree = self:getChatTree(girlId, dialogueId)

	return tree:getChatIdListByAnswer(chatIds)
end

function IslandStationChatMgr:getChatTree(girlId, dialogueId)
	local key = MmUtil.getUniqueKey(girlId, dialogueId)

	if self._chatTrees[key] == nil then
		local dialoguePlanId = IslandStationConfig.instance:getDialoguePlanId(self._activityId, girlId)

		self._chatTrees[key] = IslandStationChatTree.New(dialoguePlanId, dialogueId)
	end

	return self._chatTrees[key]
end

function IslandStationChatMgr:_fetchChatCell(girlId, dialogueId, chatId)
	local cell = self._chatCellPool:fetchObject()
	local dialoguePlanId = IslandStationConfig.instance:getDialoguePlanId(self._activityId, girlId)

	cell:onUpdateChat(dialoguePlanId, dialogueId, chatId)

	return cell
end

function IslandStationChatMgr:_returnChatCell(cell)
	self._chatCellPool:returnObject(cell)
end

function IslandStationChatMgr:_creatChatCellPool()
	local function createFunc()
		return IslandStationChatCell.New()
	end

	local function disposeFunc(comp)
		comp:onResetChat()
	end

	local function resetFunc(comp)
		comp:onResetChat()
	end

	return ObjectPool.New(20, createFunc, disposeFunc, resetFunc)
end

return IslandStationChatMgr
