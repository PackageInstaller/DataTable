-- chunkname: @modules/logic/versionactivity2_8/nuodika/view/NuoDiKaLevelViewContainer.lua

module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaLevelViewContainer", package.seeall)

local NuoDiKaLevelViewContainer = class("NuoDiKaLevelViewContainer", BaseViewContainer)

function NuoDiKaLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, NuoDiKaLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function NuoDiKaLevelViewContainer:buildTabViews(tabContainerId)
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

function NuoDiKaLevelViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity2_8Enum.ActivityId.NuoDiKa)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity2_8Enum.ActivityId.NuoDiKa
	})
end

function NuoDiKaLevelViewContainer:overrideOnCloseClick()
	NuoDiKaModel.instance:setCurEpisode(0, 0)
	self:closeThis()
end

return NuoDiKaLevelViewContainer
