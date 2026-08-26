-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/view/ZhiXinQuanErLevelViewContainer.lua

module("modules.logic.versionactivity2_3.zhixinquaner.view.ZhiXinQuanErLevelViewContainer", package.seeall)

local ZhiXinQuanErLevelViewContainer = class("ZhiXinQuanErLevelViewContainer", BaseViewContainer)

function ZhiXinQuanErLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, ZhiXinQuanErLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function ZhiXinQuanErLevelViewContainer:buildTabViews(tabContainerId)
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

function ZhiXinQuanErLevelViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr
	})
end

return ZhiXinQuanErLevelViewContainer
