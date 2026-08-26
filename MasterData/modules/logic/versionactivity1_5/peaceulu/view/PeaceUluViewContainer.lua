-- chunkname: @modules/logic/versionactivity1_5/peaceulu/view/PeaceUluViewContainer.lua

module("modules.logic.versionactivity1_5.peaceulu.view.PeaceUluViewContainer", package.seeall)

local PeaceUluViewContainer = class("PeaceUluViewContainer", BaseViewContainer)
local navigatetionview = 1
local tabgroupviews = 2

function PeaceUluViewContainer:buildViews()
	local view = {}

	self.peaceUluView = PeaceUluView.New()
	self.navigatetionview = TabViewGroup.New(1, "#go_topleft")
	self.tabgroupviews = TabViewGroup.New(2, "#go_content")

	table.insert(view, self.peaceUluView)
	table.insert(view, self.navigatetionview)
	table.insert(view, self.tabgroupviews)

	return view
end

function PeaceUluViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == navigatetionview then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self._navigateButtonView:setCloseCheck(self.defaultOverrideCloseCheck, self)

		return {
			self._navigateButtonView
		}
	end

	if tabContainerId == tabgroupviews then
		return {
			PeaceUluMainView.New(),
			PeaceUluGameView.New(),
			PeaceUluResultView.New()
		}
	end
end

function PeaceUluViewContainer:getNavigateButtonView()
	return self._navigateButtonView
end

function PeaceUluViewContainer:defaultOverrideCloseCheck()
	local curTabId = self.tabgroupviews:getCurTabId()

	if curTabId ~= PeaceUluEnum.TabIndex.Main then
		PeaceUluController.instance:dispatchEvent(PeaceUluEvent.onSwitchTab, PeaceUluEnum.TabIndex.Main)
	else
		self._navigateButtonView:_reallyClose()
	end
end

function PeaceUluViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_5Enum.ActivityId.PeaceUlu)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_5Enum.ActivityId.PeaceUlu
	})
end

return PeaceUluViewContainer
