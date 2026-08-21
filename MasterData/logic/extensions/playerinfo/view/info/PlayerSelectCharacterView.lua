-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/PlayerSelectCharacterView.lua

module("logic.extensions.playerinfo.view.info.PlayerSelectCharacterView", package.seeall)

local M = class("PlayerSelectCharacterView", ViewComponent)

function M:buildUI()
	self._heroData = HeroDepotModel.instance:getHeroDepotData()
	self._playerCardInfo = PlayerModel.instance:getPlayerCardInfo()
	self._showHeroData = self._heroData:getShowDataList()
	self._heroParent = goutil.findChild(self.mainGO, "charaterScroll/mask/content")
	self._heroTemplate = goutil.findChild(self.mainGO, "charaterScroll/mask/content/player_show_item")
	self._heroScroll = self:getGo("character_depot_main_view_-1505180648")
	self._scrollView = LoopGridViewHelper.New(self._heroScroll)

	self._scrollView:InitGridView(0, self._onCellUpdate, self)
	self:_refreshLoopView()

	self._btnReturn = self:getBtn("title_view_-878360263")
end

function M:destroyUI()
	self._heroScroll = nil
	self._showHeroData = nil
	self._heroData = nil
	self._scrollView = nil
end

function M:_refreshLoopView()
	self._playerCardInfo = PlayerModel.instance:getPlayerCardInfo()
	self._heroSelectIds = MainPerformConfig.instance:getConstNumValuesByKey("DisplayHeroSelect")

	local count = #self._heroSelectIds

	self._scrollView:SetListItemCount(count, true)
	self._scrollView:RefreshAllShownItem()
end

function M:_onCellUpdate(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._scrollView:NewListViewItem("player_show_item")
	local view = Astral.LuaComponentContainer.Add(item.gameObject, HeroBoardItemCell)
	local mo = self._showHeroData:getMoByIndex(curIndex)
	local heroId = mo:getCharacterCo().id
	local curDisplayHero = self._playerCardInfo.displayHero

	view:updateData(heroId, curDisplayHero)

	return item
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	GlobalDispatcher:addEventListener(EventType.CHANGE_PLAYER_DISPLAYHERO_SUC, self._refreshLoopView, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.CHANGE_PLAYER_DISPLAYHERO_SUC, self._refreshLoopView, self)
end

function M:_onClickReturn()
	self:back()
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterDepot)

	local _tmpHeroList = HeroDepotModel.instance:getHeroDepotData():getShowDataList()
	local sortData = CharacterUtil.SortAndFitler(CommEnum.HeroFilter.Display, _tmpHeroList:getMoList())
	local fitlerAgainSortData = {}

	for index, characterData in ipairs(sortData or {}) do
		if MainPerformConfig.instance:getIsAdjutantOnline(characterData:getId()) then
			table.insert(fitlerAgainSortData, characterData)
		end
	end

	self._showHeroData:setMoList(fitlerAgainSortData)

	self._curViewType = HeroDepotEnum.ViewType.Overview

	local canvasGroupScrollView = self:getUIComponent("character_depot_main_view_-1505180648", ComponentType.CanvasGroup)

	canvasGroupScrollView.alpha = 1

	self:_refreshLoopView()
end

function M:onEnterFinished()
	GlobalDispatcher:dispatchEvent(EventType.TITLE_CHANGE_EVENT, {
		titleName = lang("tip_keep_close_people")
	})
end

function M:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterDepot)

	self._heroData = nil
	self._defaultSort = nil
end

function M:_showDataByViewType()
	HeroDepotModel.instance:setViewType(self._curViewType)
	GlobalDispatcher:dispatchEvent(EventType.HERODEPOT_VIEW_TYPE, self._curViewType)
end

return M
