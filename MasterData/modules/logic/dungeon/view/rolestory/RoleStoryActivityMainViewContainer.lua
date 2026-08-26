-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryActivityMainViewContainer.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryActivityMainViewContainer", package.seeall)

local RoleStoryActivityMainViewContainer = class("RoleStoryActivityMainViewContainer", BaseViewContainer)

function RoleStoryActivityMainViewContainer:buildViews()
	local views = {}

	self.actView = RoleStoryActivityView.New()
	self.challengeView = RoleStoryActivityChallengeView.New()
	self.mainView = RoleStoryActivityMainView.New()

	table.insert(views, RoleStoryActivityBgView.New())
	table.insert(views, RoleStoryItemRewardView.New())
	table.insert(views, self.mainView)
	table.insert(views, self.actView)
	table.insert(views, self.challengeView)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "#go_topright"))

	return views
end

function RoleStoryActivityMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self._navigateButtonsView:setOverrideClose(self.overrideClose, self)

		return {
			self._navigateButtonsView
		}
	end

	local currencyParam = {
		{
			isIcon = true,
			type = MaterialEnum.MaterialType.Item,
			id = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryActivityItemId)
		}
	}

	self.currencyView = CurrencyView.New(currencyParam)
	self.currencyView.foreHideBtn = true

	return {
		self.currencyView
	}
end

function RoleStoryActivityMainViewContainer:refreshCurrency(currencyTypeParam)
	self.currencyView:setCurrencyType(currencyTypeParam)
end

function RoleStoryActivityMainViewContainer:overrideClose()
	if not self.mainView._showActView then
		RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ChangeMainViewShow, true)

		return
	end

	ViewMgr.instance:closeView(self.viewName, nil, true)
end

function RoleStoryActivityMainViewContainer:onContainerClose()
	if self:isManualClose() and not ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.ManuallyOpenMainView)
	end
end

function RoleStoryActivityMainViewContainer:playAnim(animName, callback, callbackObj)
	local animatorPlayer = self:__getAnimatorPlayer()

	if not gohelper.isNil(animatorPlayer) then
		animatorPlayer:Play(animName, callback, callbackObj)
	end
end

function RoleStoryActivityMainViewContainer:playOpenTransition()
	local paramTable = {}

	if self.mainView._showActView then
		paramTable.anim = "open"
		paramTable.duration = 0.67
	else
		paramTable.anim = "challenge"
		paramTable.duration = 0.6
	end

	RoleStoryActivityMainViewContainer.super.playOpenTransition(self, paramTable)
end

function RoleStoryActivityMainViewContainer:_setVisible(isVisible)
	RoleStoryActivityMainViewContainer.super._setVisible(self, isVisible)

	if self.mainView then
		self.mainView:onSetVisible()
	end
end

function RoleStoryActivityMainViewContainer:getVisible()
	return self._isVisible
end

return RoleStoryActivityMainViewContainer
