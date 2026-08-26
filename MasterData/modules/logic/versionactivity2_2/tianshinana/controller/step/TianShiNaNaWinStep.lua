-- chunkname: @modules/logic/versionactivity2_2/tianshinana/controller/step/TianShiNaNaWinStep.lua

module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaWinStep", package.seeall)

local TianShiNaNaWinStep = class("TianShiNaNaWinStep", TianShiNaNaStepBase)

function TianShiNaNaWinStep:onStart(context)
	local storyId = TianShiNaNaModel.instance.episodeCo.storyClear

	if storyId > 0 then
		self._initMaskActive = PostProcessingMgr.instance:getUIPPValue("LocalMaskActive")
		self._initDistortStrength = PostProcessingMgr.instance:getUIPPValue("LocalDistortStrength")

		PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", false)
		PostProcessingMgr.instance:setUIPPValue("localDistortStrength", 0)
		StoryController.instance:playStory(storyId, nil, self._onStoryEnd, self)
	else
		self:_onStoryEnd()
	end
end

function TianShiNaNaWinStep:_onStoryEnd()
	ViewMgr.instance:openView(ViewName.TianShiNaNaResultView, {
		isWin = true,
		star = self._data.star
	})
	self:onDone(false)
end

function TianShiNaNaWinStep:clearWork()
	if self._initMaskActive ~= nil then
		PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", self._initMaskActive)
		PostProcessingMgr.instance:setUIPPValue("LocalDistortStrength", self._initDistortStrength)
	end
end

return TianShiNaNaWinStep
