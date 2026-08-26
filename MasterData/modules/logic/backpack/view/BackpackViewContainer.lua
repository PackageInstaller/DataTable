-- chunkname: @modules/logic/backpack/view/BackpackViewContainer.lua

module("modules.logic.backpack.view.BackpackViewContainer", package.seeall)

local BackpackViewContainer = class("BackpackViewContainer", BaseViewContainer)

function BackpackViewContainer:buildViews()
	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "#scroll_category"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam1.prefabUrl = self._viewSetting.otherRes[2]
	scrollParam1.cellClass = BackpackCategoryListItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirV
	scrollParam1.lineCount = 1
	scrollParam1.cellWidth = 335
	scrollParam1.cellHeight = 110
	scrollParam1.cellSpaceH = 0
	scrollParam1.cellSpaceV = 4

	return {
		LuaListScrollView.New(BackpackCategoryListModel.instance, scrollParam1),
		BackpackView.New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(BackpackController.BackpackViewTabContainerId, "#go_container"),
		CommonRainEffectView.New("rainEffect")
	}
end

function BackpackViewContainer:buildTabViews(tabContainerId)
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
		local scrollParam = ListScrollParam.New()

		scrollParam.scrollGOPath = "#scroll_prop"
		scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
		scrollParam.prefabUrl = self._viewSetting.otherRes[1]
		scrollParam.cellClass = BackpackPropListItem
		scrollParam.scrollDir = ScrollEnum.ScrollDirV
		scrollParam.lineCount = 6
		scrollParam.cellWidth = 250
		scrollParam.cellHeight = 250
		scrollParam.cellSpaceH = 0
		scrollParam.cellSpaceV = 0
		scrollParam.startSpace = 20
		scrollParam.endSpace = 10
		scrollParam.minUpdateCountInFrame = 100

		local equipScrollParam = ListScrollParam.New()

		equipScrollParam.scrollGOPath = "#scroll_equip"
		equipScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
		equipScrollParam.prefabUrl = self._viewSetting.otherRes[3]
		equipScrollParam.cellClass = CharacterEquipItem
		equipScrollParam.scrollDir = ScrollEnum.ScrollDirV
		equipScrollParam.lineCount = 6
		equipScrollParam.cellWidth = 250
		equipScrollParam.cellHeight = 250
		equipScrollParam.cellSpaceH = 0
		equipScrollParam.cellSpaceV = 0
		equipScrollParam.startSpace = 20
		scrollParam.endSpace = 10
		equipScrollParam.minUpdateCountInFrame = 100

		local equipAnimationDelayTimes = {}
		local delayTime

		for i = 1, 24 do
			equipAnimationDelayTimes[i] = (math.ceil(i / 6) - 1) * 0.03
		end

		local antiqueScrollParam = ListScrollParam.New()

		antiqueScrollParam.scrollGOPath = "#scroll_antique"
		antiqueScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
		antiqueScrollParam.prefabUrl = self._viewSetting.otherRes[1]
		antiqueScrollParam.cellClass = AntiqueBackpackItem
		antiqueScrollParam.scrollDir = ScrollEnum.ScrollDirV
		antiqueScrollParam.lineCount = 6
		antiqueScrollParam.cellWidth = 250
		antiqueScrollParam.cellHeight = 250
		antiqueScrollParam.cellSpaceH = 0
		antiqueScrollParam.cellSpaceV = 0
		antiqueScrollParam.startSpace = 20
		antiqueScrollParam.endSpace = 10
		antiqueScrollParam.minUpdateCountInFrame = 100
		self.notPlayAnimation = true

		return {
			MultiView.New({
				BackpackPropView.New(),
				LuaListScrollView.New(BackpackPropListModel.instance, scrollParam)
			}),
			MultiView.New({
				CharacterBackpackEquipView.New(),
				LuaListScrollViewWithAnimator.New(CharacterBackpackEquipListModel.instance, equipScrollParam, equipAnimationDelayTimes)
			}),
			MultiView.New({
				AntiqueBackpackView.New(),
				LuaListScrollViewWithAnimator.New(AntiqueBackpackListModel.instance, antiqueScrollParam)
			})
		}
	end
end

function BackpackViewContainer:onContainerOpenFinish()
	self.navigationView:resetOnCloseViewAudio(AudioEnum.UI.UI_Rolesclose)
end

function BackpackViewContainer:setCurrentSelectCategoryId(id)
	self.currentSelectCategoryId = id or ItemEnum.CategoryType.All
end

function BackpackViewContainer:getCurrentSelectCategoryId()
	return self.currentSelectCategoryId
end

return BackpackViewContainer
