-- chunkname: @modules/logic/guide/view/GuideView.lua

module("modules.logic.guide.view.GuideView", package.seeall)

local GuideView = class("GuideView", BaseView)

function GuideView:onInitView()
	local guideGMNode = GMController.instance:getGMNode("guideview", self.viewGO)

	if guideGMNode then
		self._btnJump = gohelper.findChildButtonWithAudio(guideGMNode, "btnJump")
	end
end

function GuideView:isOpenGM()
	return isDebugBuild and PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewShowGMBtn, 1) == 1
end

function GuideView:onOpen()
	if self._btnJump then
		gohelper.setActive(self._btnJump.gameObject, self:isOpenGM())
	end
end

function GuideView:addEvents()
	if self._btnJump then
		self._btnJump:AddClickListener(self._onClickBtnJump, self)
	end
end

function GuideView:removeEvents()
	if self._btnJump then
		self._btnJump:RemoveClickListener()
	end
end

function GuideView:_onClickBtnJump()
	GuideModel.instance:onClickJumpGuides()

	local doingGuideId = GuideModel.instance:getDoingGuideId()

	if doingGuideId then
		::label_6_0::

		local guideMO = GuideModel.instance:getById(doingGuideId)
		local doingStepId = guideMO and guideMO.currStepId

		logWarn(string.format("点击了指引跳过按钮！！！！！当前指引：%d_%d", doingGuideId or -1, doingStepId or -1))

		if doingGuideId == GuideController.FirstGuideId then
			DungeonFightController.instance:sendEndFightRequest(true)
		end

		GuideController.instance:oneKeyFinishGuides()
		GuideStepController.instance:clearStep()
	end
end

return GuideView
