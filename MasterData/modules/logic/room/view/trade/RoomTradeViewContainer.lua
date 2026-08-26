-- chunkname: @modules/logic/room/view/trade/RoomTradeViewContainer.lua

module("modules.logic.room.view.trade.RoomTradeViewContainer", package.seeall)

local RoomTradeViewContainer = class("RoomTradeViewContainer", BaseViewContainer)

function RoomTradeViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomTradeView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "root/panel"))
	table.insert(views, TabViewGroup.New(3, "#go_topright"))

	return views
end

function RoomTradeViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			self.navigateView
		}
	elseif tabContainerId == 2 then
		self._dailyOrderView = RoomDailyOrderView.New()
		self._wholesaleView = RoomWholesaleView.New()

		return {
			MultiView.New({
				self._dailyOrderView
			}),
			MultiView.New({
				self._wholesaleView
			})
		}
	elseif tabContainerId == 3 then
		self._currencyView = CurrencyView.New({
			RoomTradeModel.instance:getCurrencyType()
		})
		self._currencyView.foreHideBtn = true

		return {
			self._currencyView
		}
	end
end

function RoomTradeViewContainer:_overrideCloseFunc()
	ManufactureController.instance:resetCameraOnCloseView()
	ViewMgr.instance:closeView(self.viewName)
end

function RoomTradeViewContainer:selectTabView(selectId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, selectId)
end

function RoomTradeViewContainer:playCloseTransition()
	local animatorPlayer = self:getAnimatorPlayer()

	animatorPlayer:Play(UIAnimationName.Close, self.onCloseAnimDone, self)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_jiaoyi_close)
end

function RoomTradeViewContainer:getAnimatorPlayer()
	self._animatorPlayer = self._animatorPlayer or ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	return self._animatorPlayer
end

function RoomTradeViewContainer:playAnim(animName)
	self._animator = self._animator or self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self._animator:Play(animName, 0, 0)
	self._animator:Update(0)
end

function RoomTradeViewContainer:onCloseAnimDone()
	self:onPlayCloseTransitionFinish()
end

function RoomTradeViewContainer:onContainerInit()
	if self.viewParam then
		self.viewParam.defaultTabIds = {}
		self.viewParam.defaultTabIds[2] = self.viewParam.defaultTab
	end
end

return RoomTradeViewContainer
