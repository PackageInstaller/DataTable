-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/controller/StoryMgr.lua

module("logic.extensions.story.controller.StoryMgr", package.seeall)

local M = class("StoryMgr")
local kStorySaveKey = "kStorySaveKey"
local ep4StoryId = 1000401

function M:startSingle(storyId, sceneId, finishFunc, finishHandler, stayUI, plotType, resetUI)
	self._storyId = storyId

	self:isAfterBattle(false)
	StoryModel.instance:cachePlotType(plotType)
	StoryController.instance:Open(storyId, finishFunc, finishHandler, stayUI, plotType, resetUI)
end

function M:isAfterBattle(isAfterBattle)
	StoryModel.instance:isAfterBattle(isAfterBattle)
end

function M:clearStep()
	StoryController.instance:Close()

	self._storyId = false
end

function M:checkInterruptSkip()
	local interruptSkip = false
	local nextGroupId = false
	local nextIndex = false
	local _storyEntry = StoryController.instance:getCurStoryEntry()

	if not _storyEntry then
		return
	end

	local curIndex = _storyEntry:_GetCurrIndex()

	interruptSkip, nextGroupId, nextIndex = _storyEntry:hasExistBreak(curIndex)

	print(string.format("是否需要跳转:%s,下一个ID:%s ,当前索引:%s 跳转索引:%s", interruptSkip, nextGroupId, curIndex, nextIndex))

	if interruptSkip then
		_storyEntry:forceSwitch()
	end

	return interruptSkip, nextGroupId, nextIndex
end

function M:getNextVideoPath()
	local _storyEntry = StoryController.instance:getCurStoryEntry()

	if not _storyEntry then
		return false
	end

	return _storyEntry:getNextVideoPath()
end

function M:verifyEP4HasFinish(callback, callbackHandle)
	self._ep4CallBack = callback
	self._ep4CallBackHandle = callbackHandle

	local isPreconditionFinish = false
	local guideIds = ConstConfig.instance:getNumValuesByKey(ConstConfigKeyEnum.SpecialLotteryGuideId)

	if guideIds and #guideIds == 2 then
		local preconditionGuideId = guideIds[1]

		isPreconditionFinish = GuideModel.instance:isGuideFinish(preconditionGuideId)
	end

	if isPreconditionFinish then
		self:_onEp4Finish()

		return
	end

	local saveKey = string.format("%s_%s_%s", kStorySaveKey, PlayerModel.instance:getId(), ep4StoryId)
	local playState = Astral.LocalStorage.Instance:GetInt(saveKey)

	if playState == 0 then
		StoryMgr.instance:startSingle(ep4StoryId, false, self._onEp4Finish, self, false, NewbieExtension_pb.PlotEnum.DUNGEON)
	else
		self:_onEp4Finish()
	end
end

function M:_onEp4Finish()
	local saveKey = string.format("%s_%s_%s", kStorySaveKey, PlayerModel.instance:getId(), ep4StoryId)

	Astral.LocalStorage.Instance:SetInt(saveKey, 1)

	if self._ep4CallBack then
		self._ep4CallBack(self._ep4CallBackHandle)
	end

	self._ep4CallBack = nil
	self._ep4CallBackHandle = nil
end

M.instance = M.New()

return M
