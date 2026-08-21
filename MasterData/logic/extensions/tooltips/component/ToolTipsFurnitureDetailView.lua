-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsFurnitureDetailView.lua

module("logic.extensions.tooltips.component.ToolTipsFurnitureDetailView", package.seeall)

local M = class("ToolTipsFurnitureDetailView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	M.super.buildUI(self)

	local mainGO = self.mainGO

	self._detailView = Astral.LuaComponentContainer.Add(mainGO, RoomBackpackFurnitureDetailView)
	self._guiAnimation = goutil.addComponentOnce(mainGO, typeof(Astral.GUITimelineAniLua))
	self._goBtnRecycle = self:getGo("furniture_detail_tips_1854868282")
	self._passEvent = self:getGo("empty_mask_tips_29887572"):GetComponent(ComponentType.PassEvent)
end

function M:destroyUI()
	self._detailView:_destroyUI()
	M.super.destroyUI(self)
end

function M:bindEvents()
	M.super.bindEvents(self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Room)
	M.super.onEnter(self)

	local info = self:getFirstParam()
	local itemId = info.itemId
	local furnitureData = FurnitureData.New({
		count = info.itemData.num,
		itemId = itemId
	})

	self._detailView:setItemData(furnitureData)

	self._passEvent.isPassEvent = info.passEvent

	self._detailView:onEnter()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
	goutil.setActive(self._goBtnRecycle, false)
end

function M:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Room)
	self._detailView:onExit()
	M.super.onExit(self)
end

return M
