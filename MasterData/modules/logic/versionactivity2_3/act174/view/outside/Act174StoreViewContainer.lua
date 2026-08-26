-- chunkname: @modules/logic/versionactivity2_3/act174/view/outside/Act174StoreViewContainer.lua

module("modules.logic.versionactivity2_3.act174.view.outside.Act174StoreViewContainer", package.seeall)

local Act174StoreViewContainer = class("Act174StoreViewContainer", BaseViewContainer)

function Act174StoreViewContainer:buildViews()
	return {
		Act174StoreView.New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_righttop")
	}
end

function Act174StoreViewContainer:buildTabViews(tabContainerId)
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
		self._currencyView = CurrencyView.New({
			CurrencyEnum.CurrencyType.V2a3DouQuQu
		})

		self._currencyView:setOpenCallback(self._onCurrencyOpen, self)

		return {
			self._currencyView
		}
	end
end

function Act174StoreViewContainer:_onCurrencyOpen()
	local item = self._currencyView:getCurrencyItem(1)

	gohelper.setActive(item.btn, false)
	gohelper.setActive(item.click, true)
	recthelper.setAnchorX(item.txt.transform, 313)
end

function Act174StoreViewContainer:playOpenTransition()
	self:startViewOpenBlock()

	local animation = self.viewGO:GetComponent(typeof(UnityEngine.Animation))

	animation:Play("activitystore_open")
	TaskDispatcher.runDelay(self.onPlayOpenTransitionFinish, self, 0.5)
end

function Act174StoreViewContainer:playCloseTransition()
	self:startViewCloseBlock()

	local animation = self.viewGO:GetComponent(typeof(UnityEngine.Animation))

	animation:Play("activitystore_close")
	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, 0.167)
end

return Act174StoreViewContainer
