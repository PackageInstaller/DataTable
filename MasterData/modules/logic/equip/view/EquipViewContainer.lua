-- chunkname: @modules/logic/equip/view/EquipViewContainer.lua

module("modules.logic.equip.view.EquipViewContainer", package.seeall)

local EquipViewContainer = class("EquipViewContainer", BaseViewContainer)

function EquipViewContainer:buildViews()
	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "#scroll_category"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam1.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam1.cellClass = EquipCategoryItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirV
	scrollParam1.lineCount = 1
	scrollParam1.cellWidth = 300
	scrollParam1.cellHeight = 120
	scrollParam1.cellSpaceH = 0
	scrollParam1.cellSpaceV = 0

	local equipScrollParam = ListScrollParam.New()

	equipScrollParam.scrollGOPath = "#scroll_equip"
	equipScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	equipScrollParam.prefabUrl = self._viewSetting.otherRes[4]
	equipScrollParam.cellClass = EquipChooseItem
	equipScrollParam.scrollDir = ScrollEnum.ScrollDirV
	equipScrollParam.lineCount = 3
	equipScrollParam.cellWidth = 228
	equipScrollParam.cellHeight = 218
	equipScrollParam.cellSpaceH = 0
	equipScrollParam.cellSpaceV = 2.22
	equipScrollParam.startSpace = 0

	local equipRefineScrollParam = ListScrollParam.New()

	equipRefineScrollParam.scrollGOPath = "#scroll_refine_equip"
	equipRefineScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	equipRefineScrollParam.prefabUrl = self._viewSetting.otherRes[4]
	equipRefineScrollParam.cellClass = EquipRefineItem
	equipRefineScrollParam.scrollDir = ScrollEnum.ScrollDirV
	equipRefineScrollParam.lineCount = 3
	equipRefineScrollParam.cellWidth = 228
	equipRefineScrollParam.cellHeight = 218
	equipRefineScrollParam.cellSpaceH = 1.92
	equipRefineScrollParam.cellSpaceV = 3
	equipRefineScrollParam.startSpace = 0

	local equipSelectedScrollParam = ListScrollParam.New()

	equipSelectedScrollParam.scrollGOPath = "#scroll_costequip"
	equipSelectedScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	equipSelectedScrollParam.prefabUrl = self._viewSetting.otherRes[5]
	equipSelectedScrollParam.cellClass = EquipSelectedItem
	equipSelectedScrollParam.scrollDir = ScrollEnum.ScrollDirH
	equipSelectedScrollParam.lineCount = 1
	equipSelectedScrollParam.cellWidth = 127
	equipSelectedScrollParam.cellHeight = 150
	equipSelectedScrollParam.cellSpaceH = 8
	equipSelectedScrollParam.cellSpaceV = 0
	equipSelectedScrollParam.startSpace = 8
	equipSelectedScrollParam.endSpace = 8
	equipSelectedScrollParam.minUpdateCountInFrame = 5
	self.equipView = EquipView.New()
	self.tableView = EquipTabViewGroup.New(2, "right")

	return {
		LuaListScrollView.New(EquipCategoryListModel.instance, scrollParam1),
		LuaListScrollView.New(EquipChooseListModel.instance, equipScrollParam),
		LuaListScrollView.New(EquipRefineListModel.instance, equipRefineScrollParam),
		LuaListScrollView.New(EquipSelectedListModel.instance, equipSelectedScrollParam),
		self.equipView,
		TabViewGroup.New(1, "#go_btns"),
		self.tableView,
		TabViewGroup.New(3, "#go_righttop")
	}
end

function EquipViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigationView
		}
	elseif tabContainerId == 2 then
		local equipRefineSelectedScrollParam = ListScrollParam.New()

		equipRefineSelectedScrollParam.scrollGOPath = "#go_effect/#go_cost/#scroll_cost"
		equipRefineSelectedScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
		equipRefineSelectedScrollParam.prefabUrl = "#go_effect/#go_cost/#scroll_cost/Viewport/#go_cost_item"
		equipRefineSelectedScrollParam.cellClass = EquipRefineSelectedItem
		equipRefineSelectedScrollParam.scrollDir = ScrollEnum.ScrollDirH
		equipRefineSelectedScrollParam.lineCount = 1
		equipRefineSelectedScrollParam.cellWidth = 124
		equipRefineSelectedScrollParam.cellHeight = 127
		equipRefineSelectedScrollParam.cellSpaceH = 18
		equipRefineSelectedScrollParam.cellSpaceV = 0
		equipRefineSelectedScrollParam.startSpace = 0
		equipRefineSelectedScrollParam.endSpace = 0
		self.equipInfoView = EquipInfoView.New()
		self.equipStrengthenView = EquipStrengthenView.New()
		self.equipRefineView = EquipRefineView.New()
		self.equipStoryView = EquipStoryView.New()

		return {
			self.equipInfoView,
			self.equipStrengthenView,
			MultiView.New({
				self.equipRefineView,
				LuaListScrollView.New(EquipRefineSelectedListModel.instance, equipRefineSelectedScrollParam)
			}),
			self.equipStoryView
		}
	elseif tabContainerId == 3 then
		local currencyView = CurrencyView.New({
			CurrencyEnum.CurrencyType.Gold
		})

		currencyView:overrideCurrencyClickFunc(self.onClickCurrency, self)

		return {
			currencyView
		}
	end
end

function EquipViewContainer:onClickCurrency(param)
	local openedViewNameList = JumpController.instance:getCurrentOpenedView()

	for i = #openedViewNameList, 1, -1 do
		local openViewTable = openedViewNameList[i]

		if openViewTable.viewName == self.viewName then
			openViewTable.viewParam = openViewTable.viewParam or {}
			openViewTable.viewParam.defaultTabIds = {
				[2] = 2
			}
		elseif openViewTable.viewName == ViewName.BackpackView then
			openViewTable.viewParam = openViewTable.viewParam or {}
			openViewTable.viewParam.defaultTabIds = {
				[BackpackController.BackpackViewTabContainerId] = 2
			}
		end
	end

	if type(param) == "number" then
		MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, param, false, nil, self._cantJump, {
			type = MaterialEnum.MaterialType.Currency,
			id = param,
			sceneType = GameSceneMgr.instance:getCurSceneType(),
			openedViewNameList = openedViewNameList
		})
	else
		MaterialTipController.instance:showMaterialInfo(param.type, param.id, false, nil, self._cantJump, {
			type = param.type,
			id = param.id,
			sceneType = GameSceneMgr.instance:getCurSceneType(),
			openedViewNameList = openedViewNameList
		})
	end
end

function EquipViewContainer:playCloseTransition()
	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, 0.05)
end

function EquipViewContainer:onContainerOpenFinish()
	self.navigationView:resetOnCloseViewAudio(AudioEnum.UI.UI_checkpoint_story_close)
end

function EquipViewContainer:setIsOpenLeftBackpack(isOpen)
	self.isOpenLeftBackpack = isOpen
end

function EquipViewContainer:getIsOpenLeftBackpack()
	return self.isOpenLeftBackpack or false
end

function EquipViewContainer:isOpenLeftStrengthenScroll()
	return self.equipView._isShowStrengthenScroll
end

function EquipViewContainer:playCurrencyViewAnimation(animationName)
	self.equipView:playCurrencyViewAnimation(animationName)
end

return EquipViewContainer
