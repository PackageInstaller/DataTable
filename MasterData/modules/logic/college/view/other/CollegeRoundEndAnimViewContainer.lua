-- chunkname: @modules/logic/college/view/other/CollegeRoundEndAnimViewContainer.lua

module("modules.logic.college.view.other.CollegeRoundEndAnimViewContainer", package.seeall)

local CollegeRoundEndAnimViewContainer = class("CollegeRoundEndAnimViewContainer", BaseViewContainer)

function CollegeRoundEndAnimViewContainer:buildViews()
	return {}
end

function CollegeRoundEndAnimViewContainer:onContainerOpen()
	CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.RoundEnd)

	UIBlockMgrExtend.CircleMvDelay = 10

	UIBlockMgrExtend.instance:resetMaskShow()
	CollegeHelper.instance:setViewVisible(self.viewName, true)

	self.openDt = os.clock()

	local btn = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	self.addClickCb(self, btn, self.onClick, self)
	TaskDispatcher.runDelay(self.closeThis, self, 3.867)
	NavigateMgr.instance:addEscape(self.viewName, self.onClick, self)
end

function CollegeRoundEndAnimViewContainer:onClick()
	if not self.openDt or os.clock() - self.openDt < 0.5 then
		return
	end

	self:closeThis()
end

function CollegeRoundEndAnimViewContainer:onContainerClose()
	UIBlockMgrExtend.CircleMvDelay = nil

	CollegeHelper.instance:setViewVisible(self.viewName, false)
	TaskDispatcher.cancelTask(self.closeThis, self)
end

return CollegeRoundEndAnimViewContainer
