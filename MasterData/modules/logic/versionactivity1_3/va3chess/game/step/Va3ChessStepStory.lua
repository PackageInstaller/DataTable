-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/step/Va3ChessStepStory.lua

module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepStory", package.seeall)

local Va3ChessStepStory = class("Va3ChessStepStory", Va3ChessStepBase)

function Va3ChessStepStory:start()
	TaskDispatcher.cancelTask(self.finish, self)

	local id = self.originData.storyId
	local actId = Va3ChessModel.instance:getActId()
	local isTips = Va3ChessConfig.instance:getTipsCfg(actId, id) ~= nil

	if isTips then
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameToastUpdate, id)
		TaskDispatcher.runDelay(self.finish, self, 1)

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
		Va3ChessGameModel.instance:setPlayingStory(true)
	else
		self:finish()
	end
end

function Va3ChessStepStory:afterPlayStory()
	PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", self._initMaskActive)
	PostProcessingMgr.instance:setUIPPValue("LocalDistortStrength", self._initDistortStrength)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.PlayStoryFinish)
	Va3ChessGameModel.instance:setPlayingStory(false)
	TaskDispatcher.runDelay(self.finish, self, 0.3)
end

function Va3ChessStepStory:dispose()
	TaskDispatcher.cancelTask(self.finish, self)
	Va3ChessStepStory.super.dispose(self)
end

return Va3ChessStepStory
