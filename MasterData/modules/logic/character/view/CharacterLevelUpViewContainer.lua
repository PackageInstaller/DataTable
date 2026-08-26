-- chunkname: @modules/logic/character/view/CharacterLevelUpViewContainer.lua

module("modules.logic.character.view.CharacterLevelUpViewContainer", package.seeall)

local CharacterLevelUpViewContainer = class("CharacterLevelUpViewContainer", BaseViewContainer)
local ITEM_WIDTH = 130

function CharacterLevelUpViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "anim/lv/#go_Lv/#scroll_Num"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "anim/lv/#go_Lv/#scroll_Num/Viewport/Content/#go_Item"
	scrollParam.cellClass = CharacterLevelItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = ITEM_WIDTH
	scrollParam.cellHeight = 120
	scrollParam.startSpace = 280
	scrollParam.endSpace = 280
	self.characterLevelUpView = CharacterLevelUpView.New()

	return {
		self.characterLevelUpView,
		TabViewGroup.New(1, "anim/#go_righttop"),
		LuaListScrollView.New(CharacterLevelListModel.instance, scrollParam)
	}
end

function CharacterLevelUpViewContainer:buildTabViews(tabContainerId)
	local currencyType = CurrencyEnum.CurrencyType
	local currencyParam = {
		currencyType.Gold,
		currencyType.HeroExperience
	}

	return {
		CurrencyView.New(currencyParam, self._onCurrencyClick, self, true)
	}
end

function CharacterLevelUpViewContainer:_onCurrencyClick()
	CharacterController.instance:dispatchEvent(CharacterEvent.levelUpViewClick)
end

function CharacterLevelUpViewContainer:setWaitHeroLevelUpRefresh(isWait)
	self._waitHeroLevelUpRefresh = isWait
end

function CharacterLevelUpViewContainer:getWaitHeroLevelUpRefresh()
	return self._waitHeroLevelUpRefresh
end

function CharacterLevelUpViewContainer:setLocalUpLevel(localUpLevel)
	self.localUpLevel = localUpLevel
end

function CharacterLevelUpViewContainer:getLocalUpLevel()
	return self.localUpLevel
end

function CharacterLevelUpViewContainer:onContainerClose()
	self:setWaitHeroLevelUpRefresh(false)
	self:setLocalUpLevel()
end

function CharacterLevelUpViewContainer:getLevelItemWidth()
	return ITEM_WIDTH
end

return CharacterLevelUpViewContainer
