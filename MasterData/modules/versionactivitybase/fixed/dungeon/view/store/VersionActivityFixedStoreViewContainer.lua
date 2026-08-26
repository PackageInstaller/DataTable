-- chunkname: @modules/versionactivitybase/fixed/dungeon/view/store/VersionActivityFixedStoreViewContainer.lua

module("modules.versionactivitybase.fixed.dungeon.view.store.VersionActivityFixedStoreViewContainer", package.seeall)

local VersionActivityFixedStoreViewContainer = class("VersionActivityFixedStoreViewContainer", BaseViewContainer)

function VersionActivityFixedStoreViewContainer:buildViews()
	self._bigVersion, self._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()

	return {
		VersionActivityFixedHelper.getVersionActivityStoreView(self._bigVersion, self._smallVersion).New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_righttop")
	}
end

function VersionActivityFixedStoreViewContainer:buildTabViews(tabContainerId)
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
		local currencyType = VersionActivityFixedHelper.getVersionActivityCurrencyType(self._bigVersion, self._smallVersion)

		self._currencyView = CurrencyView.New({
			currencyType
		})

		self._currencyView:setOpenCallback(self._onCurrencyOpen, self)

		local enum = VersionActivityFixedHelper.getVersionActivityEnum(self._bigVersion, self._smallVersion)

		self._currencyView.foreHideBtn = enum.isHideStoreCurrencyAddBtn

		return {
			self._currencyView
		}
	end
end

function VersionActivityFixedStoreViewContainer:_onCurrencyOpen()
	self:refreshCurrencyItem()
end

function VersionActivityFixedStoreViewContainer:refreshCurrencyItem()
	local item = self._currencyView:getCurrencyItem(1)

	gohelper.setActive(item.btn, false)
	gohelper.setActive(item.click, true)
	recthelper.setAnchorX(item.txt.transform, 313)
end

function VersionActivityFixedStoreViewContainer:playOpenTransition()
	self:startViewOpenBlock()

	local animation = self.viewGO:GetComponent(typeof(UnityEngine.Animation))

	animation:Play("activitystore_open")
	TaskDispatcher.runDelay(self.onPlayOpenTransitionFinish, self, 0.5)
end

function VersionActivityFixedStoreViewContainer:playCloseTransition()
	self:startViewCloseBlock()

	local animation = self.viewGO:GetComponent(typeof(UnityEngine.Animation))

	animation:Play("activitystore_close")
	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, 0.167)
end

function VersionActivityFixedStoreViewContainer:onContainerClose()
	VersionActivityFixedHelper.setCustomDungeonStore()
end

function VersionActivityFixedStoreViewContainer:isShowSpecialItem()
	return true
end

return VersionActivityFixedStoreViewContainer
