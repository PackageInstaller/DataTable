-- chunkname: @modules/logic/reactivity/view/ReactivityStoreViewContainer.lua

module("modules.logic.reactivity.view.ReactivityStoreViewContainer", package.seeall)

local ReactivityStoreViewContainer = class("ReactivityStoreViewContainer", BaseViewContainer)

function ReactivityStoreViewContainer:buildViews()
	return {
		ReactivityStoreView.New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_righttop")
	}
end

function ReactivityStoreViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end

	if tabContainerId == 2 then
		local currencyId = ReactivityModel.instance:getActivityCurrencyId(self.viewParam.actId)
		local currencyView = CurrencyView.New({
			currencyId
		})

		currencyView.foreHideBtn = true

		return {
			currencyView
		}
	end
end

function ReactivityStoreViewContainer:playOpenTransition()
	self:startViewOpenBlock()

	local animation = self.viewGO:GetComponent(typeof(UnityEngine.Animation))

	animation:Play("activitystore_open")
	TaskDispatcher.runDelay(self.onPlayOpenTransitionFinish, self, 0.5)
end

function ReactivityStoreViewContainer:playCloseTransition()
	self:startViewCloseBlock()

	local animation = self.viewGO:GetComponent(typeof(UnityEngine.Animation))

	animation:Play("activitystore_close")
	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, 0.167)
end

return ReactivityStoreViewContainer
