-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackTabViewContainer.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackTabViewContainer", package.seeall)

local Rouge2_BackpackTabViewContainer = class("Rouge2_BackpackTabViewContainer", BaseViewContainer)

function Rouge2_BackpackTabViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	self._containerView = TabViewGroup.New(Rouge2_Enum.BackpackTabContainerId, "#go_Container")

	table.insert(views, self._containerView)
	table.insert(views, Rouge2_BackpackTabView.New())
	table.insert(views, Rouge2_MapCoinView.New())

	return views
end

function Rouge2_BackpackTabViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		})

		self.navigateView:setOverrideHelp(self.overrideHelpBtn, self)
		self.navigateView:setOverrideClose(self._overrideCloseCallback, self)

		return {
			self.navigateView
		}
	elseif tabContainerId == Rouge2_Enum.BackpackTabContainerId then
		self:_addTabViewToMap(Rouge2_Enum.BagTabType.Career, nil, Rouge2_BackpackCareerView.New())
		self:_addTabViewToMap(Rouge2_Enum.BagTabType.ActiveSkill, Rouge2_Enum.BagType.ActiveSkill, Rouge2_BackpackSkillRootView.New())
		self:_addTabViewToMap(Rouge2_Enum.BagTabType.Buff, Rouge2_Enum.BagType.Buff, Rouge2_BackpackBuffView.New())
		self:_addTabViewToMap(Rouge2_Enum.BagTabType.Relics, Rouge2_Enum.BagType.Relics, Rouge2_BackpackRelicsView.New())

		return self._bagTabViewList or {}
	end
end

function Rouge2_BackpackTabViewContainer:_addTabViewToMap(tabType, bagType, viewInst)
	self._bagTabViewList = self._bagTabViewList or {}
	self._bagTabViewMap = self._bagTabViewMap or {}
	self._tabType2BagType = self._tabType2BagType or {}
	self._bagTabViewMap[tabType] = viewInst
	self._tabType2BagType[tabType] = bagType

	table.insert(self._bagTabViewList, viewInst)
end

function Rouge2_BackpackTabViewContainer:_getBagTypeByTabType(tabType)
	return self._tabType2BagType and self._tabType2BagType[tabType]
end

function Rouge2_BackpackTabViewContainer:getCurSelectType()
	return self._containerView:getCurTabId()
end

function Rouge2_BackpackTabViewContainer:switchTab(type)
	local curTabId = self._containerView:getCurTabId()

	if curTabId == type then
		return
	end

	local bagType = self:_getBagTypeByTabType(type)

	Rouge2_BackpackController.instance:readAllItems(bagType)
	self:dispatchEvent(ViewEvent.ToSwitchTab, Rouge2_Enum.BackpackTabContainerId, type)
	self:refreshHelpBtnVisible()
end

function Rouge2_BackpackTabViewContainer:onContainerInit()
	NavigateMgr.instance:addEscape(self.viewName, self._overrideCloseCallback, self)
end

function Rouge2_BackpackTabViewContainer:onContainerOpen()
	self:refreshHelpBtnVisible()
end

function Rouge2_BackpackTabViewContainer:refreshHelpBtnVisible()
	local curTabId = self._containerView:getCurTabId()

	self.navigateView:setHelpVisible(curTabId ~= Rouge2_Enum.BagTabType.Career)
end

function Rouge2_BackpackTabViewContainer:overrideHelpBtn()
	local curTabId = self._containerView:getCurTabId()

	if curTabId == Rouge2_Enum.BagTabType.ActiveSkill then
		Rouge2_Controller.instance:openTechniqueView(Rouge2_MapEnum.TechniqueId.BackpackActiveSkill)
	elseif curTabId == Rouge2_Enum.BagTabType.Buff then
		Rouge2_Controller.instance:openTechniqueView(Rouge2_MapEnum.TechniqueId.BackpackBuff)
	elseif curTabId == Rouge2_Enum.BagTabType.Relics then
		Rouge2_Controller.instance:openTechniqueView(Rouge2_MapEnum.TechniqueId.BackpackRelcis)
	else
		logError("肉鸽背包界面帮助按钮未定义页签")
	end
end

function Rouge2_BackpackTabViewContainer:getTabViewByTabType(tabType)
	return self._bagTabViewMap and self._bagTabViewMap[tabType]
end

function Rouge2_BackpackTabViewContainer:_overrideCloseCallback()
	local curTabId = self:getCurSelectType()

	if curTabId == Rouge2_Enum.BagTabType.ActiveSkill then
		local curTabView = self:getTabViewByTabType(curTabId)

		return curTabView and curTabView:_onClickEscapeCallback()
	end

	self:closeThis()
end

return Rouge2_BackpackTabViewContainer
