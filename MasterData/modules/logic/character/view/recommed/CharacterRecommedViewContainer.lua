-- chunkname: @modules/logic/character/view/recommed/CharacterRecommedViewContainer.lua

module("modules.logic.character.view.recommed.CharacterRecommedViewContainer", package.seeall)

local CharacterRecommedViewContainer = class("CharacterRecommedViewContainer", BaseViewContainer)

function CharacterRecommedViewContainer:buildViews()
	self._recommedView = CharacterRecommedView.New()
	self._heroView = CharacterRecommedHeroView.New()

	local views = {}

	table.insert(views, self._heroView)
	table.insert(views, self._recommedView)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "right/#go_scroll"))
	table.insert(views, TabViewGroup.New(3, "#go_changehero"))

	return views
end

function CharacterRecommedViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end

	if tabContainerId == 2 then
		return {
			CharacterRecommedGroupView.New(),
			CharacterDevelopGoalsView.New()
		}
	end

	if tabContainerId == 3 then
		local views = {}

		self:_addCharacterChangeHeroView(views)

		return views
	end
end

function CharacterRecommedViewContainer:onContainerInit()
	self.viewParam.defaultTabIds = {}
	self.viewParam.defaultTabIds[2] = self.viewParam.defaultTabId or CharacterRecommedEnum.TabSubType.RecommedGroup

	local characterViewContainer = ViewMgr.instance:getContainer(ViewName.CharacterView)

	if characterViewContainer and characterViewContainer:isOpen() then
		characterViewContainer:onOpenAnimDone()
	end
end

function CharacterRecommedViewContainer:_addCharacterChangeHeroView(t)
	local views = {}

	table.insert(views, CharacterRecommedChangeHeroView.New())

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_hero"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[3]
	scrollParam.cellClass = CharacterRecommedChangeHeroItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 3
	scrollParam.cellWidth = 150
	scrollParam.cellHeight = 150
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0

	local scrollView = LuaListScrollView.New(CharacterRecommedHeroListModel.instance, scrollParam)

	table.insert(views, scrollView)

	t[1] = MultiView.New(views)
end

function CharacterRecommedViewContainer:playCloseTransition()
	self._recommedView:playViewAnimPlayer(CharacterRecommedEnum.AnimName.Close, self.onPlayCloseTransitionFinish, self)
end

function CharacterRecommedViewContainer:cutTab(tab)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, tab)

	self.viewParam.defaultTabId = tab
end

function CharacterRecommedViewContainer:getGroupItemRes()
	local resPath = self._viewSetting.otherRes[1]

	return self:getRes(resPath)
end

function CharacterRecommedViewContainer:getGoalsItemRes()
	local resPath = self._viewSetting.otherRes[2]

	return self:getRes(resPath)
end

function CharacterRecommedViewContainer:getHeroIconRes()
	local resPath = self._viewSetting.otherRes[3]

	return self:getRes(resPath)
end

function CharacterRecommedViewContainer:getEquipIconRes()
	local resPath = self._viewSetting.otherRes[4]

	return self:getRes(resPath)
end

return CharacterRecommedViewContainer
