-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/equipdungeon/RedMistDungeonCell.lua

module("logic.extensions.dungeon.view.equipdungeon.RedMistDungeonCell", package.seeall)

local M = class("RedMistDungeonCell", SimpleCellComponent)
local LockAlpha = 0.2

function M:ctor(container)
	self.super.ctor(self, container)

	self._clickHandler = Handler.New()
end

function M:buildUI()
	self._canvasGroup = self._registry:getUIComponent("red_mist_dungeon_item_-96101800", ComponentType.CanvasGroup)
	self._textNum = self._registry:getText("red_mist_dungeon_item_1501519503")
	self._textName = self._registry:getText("red_mist_dungeon_item_-244171939")
	self._imgIcon = self._registry:getImage("red_mist_dungeon_item_611276301")
	self._goSelect = self._registry:getGo("red_mist_dungeon_item_-128846707")
	self._goLock = self._registry:getGo("red_mist_dungeon_item_900455505")
	self._textLock = self._registry:getText("red_mist_dungeon_item_-1619919394")
	self._btnClick = self._registry:getBtn("red_mist_dungeon_item_395104190")
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClickSelf, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_ResourcesExplore)
end

function M:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_ResourcesExplore)
end

function M:destroyUI()
	self._clickHandler:clear()

	self._clickHandler = nil
end

function M:_setData(dungeonMo, chapterIndex, clickFunc, clickObj)
	self._dungeonMo = dungeonMo
	self._chapterIndex = chapterIndex

	self._clickHandler:setListener(clickFunc, clickObj)
end

function M:_refreshUI()
	local isUnlock = self._dungeonMo:getIsUnlock()

	self._textName.text = self._dungeonMo:getName()
	self._textNum.text = string.format("%02d", self._chapterIndex)
	self._canvasGroup.alpha = isUnlock and 1 or LockAlpha
	self._textLock.text = self._dungeonMo:getLockDesc()

	IconLoader.setSprite(self._imgIcon, IconType.DynSpriteAtlas_ResourcesExplore, self._dungeonMo:getBannerRes())
	goutil.setActive(self._goLock, not isUnlock)
	goutil.setActive(self._goSelect, false)
	goutil.setActive(self._textName.gameObject, isUnlock)
end

function M:_onClickSelf()
	self._clickHandler:call(self._dungeonMo, self._chapterIndex)
end

function M:getDungeonId()
	return self._dungeonMo:getId()
end

function M:setSelect(isSelect)
	goutil.setActive(self._goSelect, isSelect)
end

return M
