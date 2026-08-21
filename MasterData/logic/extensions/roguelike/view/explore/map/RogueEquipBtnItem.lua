-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/map/RogueEquipBtnItem.lua

module("logic.extensions.roguelike.view.explore.map.RogueEquipBtnItem", package.seeall)

local M = class("RogueEquipBtnItem")

function M:ctor(container)
	local go = container.gameObject

	self._go = go
	self._onClickCallback = nil
	self._goAdd = goutil.findChild(go, "imgAdd")
	self._goCell = goutil.findChild(go, "cell")
	self._imgEquipIcon = goutil.findChildImageComponent(self._goCell, "backpack_item/imgIcon")
	self._imgEquipQuality = goutil.findChildImageComponent(self._goCell, "backpack_item/imgQuality")
	self._goEquipClick = goutil.findChild(self._goCell, "backpack_item/click")

	goutil.setActive(self._goEquipClick, false)
	self:updateData()
end

function M:setClickCallback(callback)
	self._onClickCallback = callback
end

function M:updateData()
	local equips = RoguelikeModel.instance:getCurEquipMOS() or {}
	local hadEquip = #equips > 0

	if hadEquip then
		IconLoader.setSprite(self._imgEquipIcon, IconType.ItemIcon, equips[1]:getIcon())
		IconLoader.setSprite(self._imgEquipQuality, IconType.Skinlib, GameUrl.getItemQualityUrl(equips[1]:getQuality()))
	end

	goutil.setActive(self._goCell, hadEquip)
	goutil.setActive(self._goAdd, not hadEquip)
end

function M:onItemClick()
	if self._onClickCallback then
		self._onClickCallback()
	end
end

function M:setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.ROGUE_EQUIP_REFRESH, self._onEquipRefresh, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_EQUIP_REFRESH, self._onEquipRefresh, self)
	end
end

function M:_onEquipRefresh()
	self:updateData()
end

function M:OnDestroy()
	self._onClickCallback = nil

	self:setEvent(false)
end

return M
