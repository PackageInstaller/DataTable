-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyStoreViewContainer.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyStoreViewContainer", package.seeall)

local PartyGameLobbyStoreViewContainer = class("PartyGameLobbyStoreViewContainer", BaseViewContainer)

function PartyGameLobbyStoreViewContainer:buildViews()
	self._bigVersion, self._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()

	return {
		VersionActivityFixedHelper.getVersionActivityStoreView(self._bigVersion, self._smallVersion).New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_righttop")
	}
end

function PartyGameLobbyStoreViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local curSceneType = GameSceneMgr.instance:getCurSceneType()

		return {
			NavigateButtonsView.New({
				true,
				curSceneType == SceneType.Main,
				false
			})
		}
	end

	if tabContainerId == 2 then
		local currencyType = CurrencyEnum.CurrencyType.V3a9PartyGameStoreCoin

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

function PartyGameLobbyStoreViewContainer:_onCurrencyOpen()
	self:refreshCurrencyItem()
end

function PartyGameLobbyStoreViewContainer:refreshCurrencyItem()
	local item = self._currencyView:getCurrencyItem(1)

	gohelper.setActive(item.btn, false)
	gohelper.setActive(item.click, true)
	recthelper.setAnchorX(item.txt.transform, 313)
end

function PartyGameLobbyStoreViewContainer:playOpenTransition()
	self:startViewOpenBlock()

	local animation = self.viewGO:GetComponent(typeof(UnityEngine.Animation))

	animation:Play("activitystore_open")
	TaskDispatcher.runDelay(self.onPlayOpenTransitionFinish, self, 0.5)
end

function PartyGameLobbyStoreViewContainer:playCloseTransition()
	self:startViewCloseBlock()

	local animation = self.viewGO:GetComponent(typeof(UnityEngine.Animation))

	animation:Play("activitystore_close")
	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, 0.167)
end

function PartyGameLobbyStoreViewContainer:onContainerClose()
	VersionActivityFixedHelper.setCustomDungeonStore()
end

function PartyGameLobbyStoreViewContainer:isShowSpecialItem()
	return false
end

return PartyGameLobbyStoreViewContainer
