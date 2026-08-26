-- chunkname: @modules/logic/chessgame/game/step/ChessStepStory.lua

module("modules.logic.chessgame.game.step.ChessStepStory", package.seeall)

local ChessStepStory = class("ChessStepStory", BaseWork)

function ChessStepStory:init(stepData)
	self.originData = stepData
end

function ChessStepStory:onStart()
	TaskDispatcher.cancelTask(self.onDoneTrue, self)

	local id = self.originData.storyId
	local actId = ChessModel.instance:getActId()
	local isTips = ChessConfig.instance:getTipsCo(actId, id) ~= nil

	if isTips then
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameToastUpdate, id)
		TaskDispatcher.runDelay(self.onDoneTrue, self, 1)

		return
	end

	local storyId = id

	if storyId then
		local param = {}

		param.blur = true
		param.hideStartAndEndDark = true
		param.mark = true
		param.isReplay = false
		self._initMaskActive = PostProcessingMgr.instance:getUIPPValue("LocalMaskActive")
		self._initDistortStrength = PostProcessingMgr.instance:getUIPPValue("LocalDistortStrength")

		PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", false)
		PostProcessingMgr.instance:setUIPPValue("localDistortStrength", 0)
		PostProcessingMgr.instance:setUIPPValue("LocalDistortStrength", 0)
		StoryController.instance:playStory(storyId, param, self.afterPlayStory, self)
		ChessGameModel.instance:setPlayingStory(true)
	else
		self:onDone(true)
	end
end

function ChessStepStory:onDoneTrue()
	self:onDone(true)
end

function ChessStepStory:afterPlayStory()
	PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", self._initMaskActive)
	PostProcessingMgr.instance:setUIPPValue("LocalDistortStrength", self._initDistortStrength)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.PlayStoryonDone)
	ChessGameModel.instance:setPlayingStory(false)
	TaskDispatcher.runDelay(self.onDoneTrue, self, 0.3)
end

function ChessStepStory:clearWork()
	TaskDispatcher.cancelTask(self.onDoneTrue, self)
end

return ChessStepStory
