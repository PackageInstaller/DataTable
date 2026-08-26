-- chunkname: @modules/logic/versionactivity3_1/yeshumei/view/YeShuMeiGameViewContainer.lua

module("modules.logic.versionactivity3_1.yeshumei.view.YeShuMeiGameViewContainer", package.seeall)

local YeShuMeiGameViewContainer = class("YeShuMeiGameViewContainer", BaseViewContainer)

function YeShuMeiGameViewContainer:buildViews()
	local views = {}

	table.insert(views, YeShuMeiGameView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function YeShuMeiGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			self.navigateView
		}
	end
end

function YeShuMeiGameViewContainer:_overrideCloseFunc()
	YeShuMeiStatHelper.instance:sendGameAbort()

	if not GuideModel.instance:isGuideRunning(YeShuMeiGameView.GuideId) then
		self:closeThis()
	end
end

return YeShuMeiGameViewContainer
