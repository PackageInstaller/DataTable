-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/filterview/EquipSuitFilterItem.lua

module("logic.extensions.backpack.view.filterview.EquipSuitFilterItem", package.seeall)

local M = class("EquipSuitFilterItem")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self.mainGO)
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local registry = self._viewElementsRegistry

	self._btn = Astral.ButtonAdapter.Get(registry:findUIElement("suititem_-110027740"))
	self._txtSuitName = registry:findUIElement("suitItem_1292840505", UIComponentType.Text)
	self._txtSuitNum = registry:findUIElement("suitItem_-361338564", UIComponentType.Text)
	self._goSelect = registry:findUIElement("suitItem_-38945400")
	self._txtSuitDesc1 = registry:findUIElement("suititem_-1195080789", UIComponentType.TMPText)
	self._txtSuitDesc2 = registry:findUIElement("suititem_-311176909", UIComponentType.TMPText)
	self._goImgDian1 = goutil.findChild(self._txtSuitDesc1.gameObject, "imgDian")
	self._goImgDian2 = goutil.findChild(self._txtSuitDesc2.gameObject, "imgDian")
	self._goItem = registry:findUIElement("0&rewards_detail_item_2141037416")
	self._imgIcon = registry:findUIElement("0&rewards_detail_item_-2041880288", UIComponentType.Image)

	goutil.setActive(self._goItem, true)
end

function M:destroyUI()
	self.mainGO = nil
	self._clickEvent = nil
end

function M:bindEvents()
	self._btn:AddClickListener(self._onClick, self)
	GlobalDispatcher:addEventListener(EventType.EQUIP_WEARING_SUIT_CLICK_EVENT, self._handleClickSuit, self)
end

function M:unbindEvents()
	self._btn:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.EQUIP_WEARING_SUIT_CLICK_EVENT, self._handleClickSuit, self)
end

function M:_onClick()
	if not self._isCanClick then
		FloatWordMgr.instance:show(lang("tip_equip_no_suit"))

		return
	end

	local add = not self._goSelect.activeSelf

	goutil.setActive(self._goSelect, add)

	if self._clickEvent then
		GlobalDispatcher:dispatchEvent(self._clickEvent, self._suitMo, add)
	end
end

function M:updateData(suitMo, curPart)
	self._suitMo = suitMo
	self._isCanClick = suitMo:getIsOwner()
	self._txtSuitName.text = suitMo:getName()

	local suitDescList = self._suitMo:getSuit3DescList(HeroDepotModel.instance:getCurViewPageHeroTags())

	if suitDescList then
		self._txtSuitDesc1.text = suitDescList[1] or ""
		self._txtSuitDesc2.text = suitDescList[2] or ""
	else
		self._txtSuitDesc1.text = ""
		self._txtSuitDesc2.text = ""
	end

	goutil.setActive(self._goImgDian1, self._txtSuitDesc1.text ~= "")
	goutil.setActive(self._goImgDian2, self._txtSuitDesc2.text ~= "")

	self._txtSuitNum.text = curPart > 0 and suitMo:getNum(curPart) or suitMo:getAllPartNum()

	local config = EquipmentConfig.instance:getConfigByKey(ConfigName.EquipmentSuit, self._suitMo:getId())

	IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, config.icon)
end

function M:setSelect(isSelect)
	goutil.setActive(self._goSelect, isSelect)
end

function M:setClickEvent(evt)
	self._clickEvent = evt
end

function M:_handleClickSuit(e, suitMo, add)
	if add then
		self:setSelect(suitMo == self._suitMo)
	end
end

return M
