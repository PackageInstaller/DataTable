-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/ShopTipItemCell.lua

module("logic.extensions.backpack.cellcomponent.ShopTipItemCell", package.seeall)

local ButtonAdapter = Astral.ButtonAdapter
local M = class("ShopTipItemCell", CellBaseComponent)

function M:ctor(cell)
	M.super.ctor(self, cell)

	self._qualityFrame = nil
	self._iconImg = nil
	self._btnClick = nil
	self._isNameTextActive = nil
end

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()

	self._qualityFrame = registry:findUIElement("rewards_detail_item_868117965", UIComponentType.Image)
	self._iconImg = registry:findUIElement("rewards_detail_item_-2041880288", UIComponentType.Image)
	self._goSelect1 = registry:findUIElement("backpack_item_-2022575790")
	self._goSelect2 = registry:findUIElement("backpack_item_506657149")
	self._clickGO = registry:findUIElement("rewards_detail_item_1370605741")
	self._btnClick = ButtonAdapter.Get(self._clickGO)

	self._btnClick:AddClickListener(self._clickSelf, self)

	self._longPressTrigger = OnceLongPressTrigger.Get(self._clickGO)

	self._longPressTrigger:AddLongPressListener(self._onOnceLongPressSelf, self)
end

function M:_clickSelf()
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_generic_select, nil, nil, nil)

	if self._clickCallback then
		self._clickCallback(self._clickHandler, self._cell)
	else
		self._cell:dealSelect()
	end
end

function M:_onOnceLongPressSelf(isOn, x, y)
	if self._onceLongPressCallback then
		self._onceLongPressCallback(self._onceLongPressHandler)
	end
end

function M:updateData(data)
	return
end

function M:setIconImgActive(isActive)
	self._iconImg.gameObject:SetActive(isActive)
end

function M:setQualityImgActive(isActive)
	self._qualityFrame.gameObject:SetActive(isActive)
end

function M:getItemSelect()
	return self._goSelect1.activeSelf or self._goSelect2.activeSelf
end

function M:setItemSelect(isSelect)
	goutil.setActive(self._goSelect1, false)
	goutil.setActive(self._goSelect2, false)

	if isSelect then
		local numComp = self._cell:getComponent("num")
		local visible = numComp:isVisible()

		if visible then
			goutil.setActive(self._goSelect1, true)
		else
			goutil.setActive(self._goSelect2, true)
		end
	end
end

function M:setClickListener(callback, handler)
	self._clickCallback = callback
	self._clickHandler = handler
end

function M:setOnceLongPressListener(callback, handler)
	self._onceLongPressCallback = callback
	self._onceLongPressHandler = handler
end

function M:btnListener(bind)
	if bind then
		self._btnClick:AddClickListener(self._clickSelf, self)
		self._longPressTrigger:AddLongPressListener(self._onOnceLongPressSelf, self)
	else
		self._btnClick:RemoveClickListener()
		self._longPressTrigger:RemoveLongPressListener()
	end
end

function M:adjustClickArea()
	local numComp = self._cell:getComponent("num")
	local visible = numComp:isVisible()

	goutil.setHeight(self._clickGO.transform, visible and 141 or 116)
end

function M:onDestroy()
	M.super.onDestroy(self)
	self._btnClick:RemoveClickListener()

	self._clickCallback = nil
	self._clickHandler = nil

	self._longPressTrigger:RemoveLongPressListener()

	self._longPressTrigger = nil
	self._onceLongPressCallback = nil
	self._onceLongPressHandler = nil
end

return M
