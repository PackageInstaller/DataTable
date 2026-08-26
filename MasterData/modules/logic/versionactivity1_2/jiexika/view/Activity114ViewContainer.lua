-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114ViewContainer.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114ViewContainer", package.seeall)

local Activity114ViewContainer = class("Activity114ViewContainer", BaseViewContainer)

function Activity114ViewContainer:buildViews()
	if self.viewParam and type(self.viewParam) == "table" and self.viewParam.defaultTabIds then
		if not self.viewParam.defaultTabIds[2] then
			self._nowTabIndex = 1
			self._activity114Live2dView = Activity114Live2dView.New()

			return {
				self._activity114Live2dView,
				Activity114View.New(),
				TabViewGroup.New(1, "#go_btns"),
				TabViewGroup.New(2, "#go_content")
			}
		end
	end
end

function Activity114ViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, 167)

		navigateView:setOverrideClose(self.onClickClose, self)

		return {
			navigateView
		}
	elseif tabContainerId == 2 then
		return {
			Activity114EnterView.New(),
			Activity114TaskView.New(),
			Activity114MainView.New()
		}
	end
end

function Activity114ViewContainer:onContainerInit()
	Activity114Model.instance:beginStat()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_2Enum.ActivityId.JieXiKa)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_2Enum.ActivityId.JieXiKa
	})
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_open)
end

function Activity114ViewContainer:onClickClose()
	if self._nowTabIndex ~= Activity114Enum.TabIndex.EnterView then
		self:switchTab(Activity114Enum.TabIndex.EnterView)
	else
		self:closeThis()
	end
end

function Activity114ViewContainer:onContainerClose()
	Activity114Model.instance:endStat()
end

function Activity114ViewContainer:getActivity114Live2d()
	return self._activity114Live2dView:getUISpine()
end

function Activity114ViewContainer:switchTab(tabIndex)
	local preIndex = self._nowTabIndex

	self._nowTabIndex = tabIndex

	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, tabIndex, preIndex)
end

function Activity114ViewContainer:playOpenTransition()
	local paramTable

	if self._nowTabIndex ~= Activity114Enum.TabIndex.EnterView then
		paramTable = {}

		if self._nowTabIndex == Activity114Enum.TabIndex.MainView then
			paramTable.anim = "start_open"
		elseif self._nowTabIndex == Activity114Enum.TabIndex.MainView then
			paramTable.anim = "quest_open"
		end
	end

	Activity114ViewContainer.super.playOpenTransition(self, paramTable)
end

function Activity114ViewContainer:onPlayCloseTransitionFinish()
	if self.openViewName then
		ViewMgr.instance:openView(self.openViewName)

		self.openViewName = nil

		TaskDispatcher.cancelTask(self.onPlayCloseTransitionFinish, self)
		self:_cancelBlock()
	else
		Activity114ViewContainer.super.onPlayCloseTransitionFinish(self)
	end
end

return Activity114ViewContainer
