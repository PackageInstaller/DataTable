-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/view/WuErLiXiLevelViewContainer.lua

module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiLevelViewContainer", package.seeall)

local WuErLiXiLevelViewContainer = class("WuErLiXiLevelViewContainer", BaseViewContainer)

function WuErLiXiLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, WuErLiXiLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function WuErLiXiLevelViewContainer:buildTabViews(tabContainerId)
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

function WuErLiXiLevelViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity2_4Enum.ActivityId.WuErLiXi)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity2_4Enum.ActivityId.WuErLiXi
	})
end

function WuErLiXiLevelViewContainer:overrideOnCloseClick()
	WuErLiXiModel.instance:setCurEpisodeIndex(0)
	self:closeThis()
end

return WuErLiXiLevelViewContainer
