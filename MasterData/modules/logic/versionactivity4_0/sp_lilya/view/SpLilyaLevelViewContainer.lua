-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/view/SpLilyaLevelViewContainer.lua

module("modules.logic.versionactivity4_0.sp_lilya.view.SpLilyaLevelViewContainer", package.seeall)

local SpLilyaLevelViewContainer = class("SpLilyaLevelViewContainer", BaseViewContainer)

function SpLilyaLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, SpLilyaLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function SpLilyaLevelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonsView
		}
	end
end

function SpLilyaLevelViewContainer:onContainerInit()
	local actId = SpLilyaModel.instance:getActId()

	ActivityEnterMgr.instance:enterActivity(actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		actId
	})
end

return SpLilyaLevelViewContainer
