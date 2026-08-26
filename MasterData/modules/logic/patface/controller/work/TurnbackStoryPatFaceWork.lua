-- chunkname: @modules/logic/patface/controller/work/TurnbackStoryPatFaceWork.lua

module("modules.logic.patface.controller.work.TurnbackStoryPatFaceWork", package.seeall)

local TurnbackStoryPatFaceWork = class("TurnbackStoryPatFaceWork", PatFaceWorkBase)

function TurnbackStoryPatFaceWork:checkCanPat()
	local canShowPop = TurnbackModel.instance:canShowTurnbackPop()
	local turnbackId = TurnbackModel.instance:getCurTurnbackId()
	local hasPlayed = TurnbackController.instance:hasPlayedStoryVideo(turnbackId)

	return (canShowPop and not hasPlayed or nil) and true
end

function TurnbackStoryPatFaceWork:startPat()
	local TurnbackMo = TurnbackModel.instance:getCurTurnbackMo()

	if TurnbackMo then
		::label_2_0::

		local var_2_0 = TurnbackMo.config

		if TurnbackMo.config then
			local storyId = TurnbackMo.config.startStory

			if storyId then
				StoryController.instance:playStory(storyId, nil, self.onPlayPatStoryFinish, self)
			else
				logError(string.format("TurnbackStoryPatFaceWork:startPat error, storyId is nil", storyId))
				self:onPlayPatStoryFinish()
			end
		end
	end
end

return TurnbackStoryPatFaceWork
