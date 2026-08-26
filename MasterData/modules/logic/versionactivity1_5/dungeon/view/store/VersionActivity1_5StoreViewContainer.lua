-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/store/VersionActivity1_5StoreViewContainer.lua

module("modules.logic.versionactivity1_5.dungeon.view.store.VersionActivity1_5StoreViewContainer", package.seeall)

local VersionActivity1_5StoreViewContainer = class("VersionActivity1_5StoreViewContainer", BaseViewContainer)

function VersionActivity1_5StoreViewContainer:buildViews()
	return {
		VersionActivity1_5StoreView.New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_righttop")
	}
end

function VersionActivity1_5StoreViewContainer:buildTabViews(tabContainerId)
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
			CurrencyEnum.CurrencyType.V1a5Dungeon
		})

		self._currencyView:setOpenCallback(self._onCurrencyOpen, self)

		return {
			self._currencyView
		}
	end
end

function VersionActivity1_5StoreViewContainer:_onCurrencyOpen()
	local item = self._currencyView:getCurrencyItem(1)

	gohelper.setActive(item.btn, false)
	gohelper.setActive(item.click, true)
	recthelper.setAnchorX(item.txt.transform, 313)
end

function VersionActivity1_5StoreViewContainer:playOpenTransition()
	self:startViewOpenBlock()

	local animation = self.viewGO:GetComponent(typeof(UnityEngine.Animation))

	animation:Play("activitystore_open")
	TaskDispatcher.runDelay(self.onPlayOpenTransitionFinish, self, 0.5)
end

function VersionActivity1_5StoreViewContainer:playCloseTransition()
	self:startViewCloseBlock()

	local animation = self.viewGO:GetComponent(typeof(UnityEngine.Animation))

	animation:Play("activitystore_close")
	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, 0.167)
end

function VersionActivity1_5StoreViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_5Enum.ActivityId.DungeonStore)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_5Enum.ActivityId.DungeonStore
	})
end

return VersionActivity1_5StoreViewContainer
