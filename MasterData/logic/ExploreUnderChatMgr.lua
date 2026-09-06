-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/data/ExploreUnderChatMgr.lua

module("logic.extensions.exploreunder.data.ExploreUnderChatMgr", package.seeall)

local ExploreUnderChatMgr = class("ExploreUnderChatMgr")

function ExploreUnderChatMgr:ctor()
	self._chatCellDirectory = {}
	self._chatCellPool = self:_creatChatCellPool()
	self._dialoguePlanId = 0
	self._dialogueId = 0
	self._chatIdList = {}
end

function ExploreUnderChatMgr:onEnter(dialoguePlanId, dialogueId)
	self._dialoguePlanId = dialoguePlanId
	self._dialogueId = dialogueId

	table.clear(self._chatIdList)
end

function ExploreUnderChatMgr:onExit()
	self._dialoguePlanId = 0
	self._dialogueId = 0

	table.clear(self._chatIdList)

	for key, cell in pairs(self._chatCellDirectory) do
		self:_returnChatCell(cell)

		self._chatCellDirectory[key] = nil
	end
end

function ExploreUnderChatMgr:dispose()
	for key, cell in pairs(self._chatCellDirectory) do
		self:_returnChatCell(cell)

		self._chatCellDirectory[key] = nil
	end

	if self._chatCellPool then
		self._chatCellPool:clear()
	end
end

function ExploreUnderChatMgr:getChatIdList()
	return self._chatIdList
end

function ExploreUnderChatMgr:resetChatIdList()
	table.clear(self._chatIdList)
end

function ExploreUnderChatMgr:nextChat(chatId)
	local curChatId = self:getCurChatId()
	local isSuccess = curChatId == 0

	if not isSuccess and curChatId > 0 then
		local chatCell = self:getChatCell(curChatId)

		if not isSuccess and #chatCell:getWaitAnswer() > 0 then
			if table.indexof(chatCell:getWaitAnswer(), chatId) ~= false then
				isSuccess = true
			else
				printError(string.format("错误！检查配置，[waitAnswer]缺失配置( yt-运营-探索地宫走格子.xlsx | export_对话事件 | dialoguePlanId:%s, dialogueId:%s, id:%s )", self._dialoguePlanId, self._dialogueId, chatId))
			end
		end

		if not isSuccess and chatCell:getContinueHandler() ~= nil then
			local handler = chatCell:getContinueHandler()
			local type = handler.type

			if type == ExploreUnderEnum.ContinueHandler_SurroundByGirl_ChangeMoney then
				if handler.ifelse and table.indexof(handler.ifelse, chatId) ~= false then
					isSuccess = true
				else
					printError(string.format("错误！检查配置，[continueHandler]缺失配置( yt-运营-探索地宫走格子.xlsx | export_对话事件 | dialoguePlanId:%s, dialogueId:%s, id:%s )", self._dialoguePlanId, self._dialogueId, chatId))
				end
			elseif type == ExploreUnderEnum.ContinueHandler_Auto then
				if handler.next == chatId then
					isSuccess = true
				else
					printError(string.format("错误！检查配置，[continueHandler]缺失配置( yt-运营-探索地宫走格子.xlsx | export_对话事件 | dialoguePlanId:%s, dialogueId:%s, id:%s )", self._dialoguePlanId, self._dialogueId, chatId))
				end
			elseif type == ExploreUnderEnum.ContinueHandler_Random then
				if handler.answers and table.indexof(handler.answers, chatId) ~= false then
					isSuccess = true
				else
					printError(string.format("错误！检查配置，[continueHandler]缺失配置( yt-运营-探索地宫走格子.xlsx | export_对话事件 | dialoguePlanId:%s, dialogueId:%s, id:%s )", self._dialoguePlanId, self._dialogueId, chatId))
				end
			elseif type == ExploreUnderEnum.ContinueHandler_Fight then
				if handler.ifelse and table.indexof(handler.ifelse, chatId) ~= false then
					isSuccess = true
				else
					printError(string.format("错误！检查配置，[continueHandler]缺失配置( yt-运营-探索地宫走格子.xlsx | export_对话事件 | dialoguePlanId:%s, dialogueId:%s, id:%s )", self._dialoguePlanId, self._dialogueId, chatId))
				end
			else
				printError(string.format("错误！检查配置，[continueHandler]缺失配置( yt-运营-探索地宫走格子.xlsx | export_对话事件 | dialoguePlanId:%s, dialogueId:%s, id:%s )", self._dialoguePlanId, self._dialogueId, chatId))
			end
		end
	end

	if isSuccess then
		table.insert(self._chatIdList, chatId)
	end
end

function ExploreUnderChatMgr:getCurChatId()
	return self._chatIdList[#self._chatIdList] or 0
end

function ExploreUnderChatMgr:getChatCell(chatId)
	local key = MmUtil.getUniqueKey(self._dialoguePlanId, self._dialogueId, chatId)

	if self._chatCellDirectory[key] == nil then
		self._chatCellDirectory[key] = self:_fetchChatCell(self._dialoguePlanId, self._dialogueId, chatId)
	end

	return self._chatCellDirectory[key]
end

function ExploreUnderChatMgr:_fetchChatCell(dialoguePlanId, dialogueId, chatId)
	local cell = self._chatCellPool:fetchObject()

	cell:onUpdateChat(dialoguePlanId, dialogueId, chatId)

	return cell
end

function ExploreUnderChatMgr:_returnChatCell(cell)
	self._chatCellPool:returnObject(cell)
end

function ExploreUnderChatMgr:_creatChatCellPool()
	local function createFunc()
		return ExploreUnderChatCell.New()
	end

	local function disposeFunc(comp)
		comp:onResetChat()
	end

	local function resetFunc(comp)
		comp:onResetChat()
	end

	return ObjectPool.New(20, createFunc, disposeFunc, resetFunc)
end

function ExploreUnderChatMgr:_getUniqueKey(...)
	local args = {
		...
	}
	local hash = 0

	for i = 1, #args do
		local num = args[i]

		if type(num) ~= "number" then
			printError("所有参数必须是 number 类型")
		else
			hash = (hash * 31 + num) % 9007199254740992
		end
	end

	return hash
end

return ExploreUnderChatMgr
