-- chunkname: @modules/logic/versionactivity2_3/dudugu/view/ActDuDuGuLevelViewContainer.lua

module("modules.logic.versionactivity2_3.dudugu.view.ActDuDuGuLevelViewContainer", package.seeall)

local ActDuDuGuLevelViewContainer = class("ActDuDuGuLevelViewContainer", BaseViewContainer)

function ActDuDuGuLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, ActDuDuGuLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function ActDuDuGuLevelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self._navigateButtonsView:setOverrideClose(self.overrideOnCloseClick, self)

		return {
			self._navigateButtonsView
		}
	end
end

function ActDuDuGuLevelViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity2_3Enum.ActivityId.DuDuGu)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity2_3Enum.ActivityId.DuDuGu
	})
end

function ActDuDuGuLevelViewContainer:overrideOnCloseClick()
	ActDuDuGuModel.instance:setCurLvIndex(0)
	self:closeThis()
end

return ActDuDuGuLevelViewContainer
