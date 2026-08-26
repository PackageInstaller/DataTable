-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyHeroGroupEquipItem.lua

module("modules.logic.sp01.odyssey.view.OdysseyHeroGroupEquipItem", package.seeall)

local OdysseyHeroGroupEquipItem = class("OdysseyHeroGroupEquipItem", LuaCompBase)

function OdysseyHeroGroupEquipItem:init(go)
	self.go = go
	self._goEmpty = gohelper.findChild(self.go, "#go_Empty")
	self._goShowEmpty = gohelper.findChild(self.go, "#go_showEmpty")
	self._gonoEmpty = gohelper.findChild(self.go, "#go_noEmpty")
	self._simageEquipIcon = gohelper.findChildSingleImage(self.go, "#go_noEmpty/#simage_EquipIcon")
	self._goSelect = gohelper.findChild(self.go, "#go_Select")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "#btn_Click")
	self._imageRare = gohelper.findChildImage(self.go, "#go_noEmpty/#image_rare")
	self._imageSuit = gohelper.findChildImage(self.go, "#go_noEmpty/suit/image_suitIcon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyHeroGroupEquipItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self._clickEquip:AddClickUpListener(self._btnClickUp, self)
	self._clickEquip:AddClickListener(self._btnClickOnClick, self)
	self._btnLongPress:AddLongPressListener(self.onLongClickItem, self)
end

function OdysseyHeroGroupEquipItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
	self._clickEquip:RemoveClickListener()
	self._clickEquip:RemoveClickUpListener()
	self._btnLongPress:RemoveLongPressListener()
end

function OdysseyHeroGroupEquipItem:_btnClickUp()
	self.isLongParse = false
end

function OdysseyHeroGroupEquipItem:_btnClickOnClick()
	if self.isDrag or self.isLongParse then
		return
	end

	if self.type == OdysseyEnum.BagType.Bag then
		OdysseyController.instance:dispatchEvent(OdysseyEvent.OnEquipPosSelect, self.index)
	elseif self.type == OdysseyEnum.BagType.FightPrepare then
		local param = {}

		param.index = self.index
		param.heroPos = self.heroPos

		OdysseyController.instance:openEquipView(param)
	end
end

function OdysseyHeroGroupEquipItem:onLongClickItem()
	if self.isDrag then
		return
	end

	self.isLongParse = true

	if self.equipUid ~= nil and self.equipUid ~= 0 and self.type == OdysseyEnum.BagType.FightPrepare then
		local itemMo = OdysseyItemModel.instance:getItemMoByUid(self.equipUid)
		local viewParam = {}

		viewParam.itemId = itemMo.id
		viewParam.clickPos = GamepadController.instance:getMousePosition()

		OdysseyController.instance:showItemTipView(viewParam)
	end
end

function OdysseyHeroGroupEquipItem:_editableInitView()
	self._clickEquip = gohelper.getClick(self._gonoEmpty)
	self._btnLongPress = SLFramework.UGUI.UILongPressListener.Get(self._gonoEmpty)

	self._btnLongPress:SetLongPressTime({
		0.8,
		99999
	})
end

function OdysseyHeroGroupEquipItem:setActive(active)
	gohelper.setActive(self.go, active)
	gohelper.setActive(self._goEmpty, active)
end

function OdysseyHeroGroupEquipItem:setEmptyParent(parent)
	self._goEmpty.transform:SetParent(parent, false)
end

function OdysseyHeroGroupEquipItem:setInfo(heroPos, index, equipUid, type)
	self.index = index
	self.heroPos = heroPos
	self.equipUid = equipUid
	self.type = type

	local isEmpty = equipUid == nil or equipUid == 0
	local isOnlyDisplay = type == OdysseyEnum.BagType.OnlyDisplay

	gohelper.setActive(self._gonoEmpty, not isEmpty)
	gohelper.setActive(self._goShowEmpty, isEmpty and isOnlyDisplay)
	self:resetPos()

	if isEmpty then
		return
	end

	local itemMo = OdysseyItemModel.instance:getItemMoByUid(equipUid)
	local itemConfig = OdysseyConfig.instance:getItemConfig(itemMo.id)

	if itemConfig.type == OdysseyEnum.ItemType.Item then
		self._simageEquipIcon:LoadImage(ResUrl.getPropItemIcon(itemConfig.icon))
	elseif itemConfig.type == OdysseyEnum.ItemType.Equip then
		self._simageEquipIcon:LoadImage(ResUrl.getSp01OdysseyItemSingleBg(itemConfig.icon))

		local suitConfig = OdysseyConfig.instance:getEquipSuitConfig(itemConfig.suitId)

		UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self._imageSuit, suitConfig.icon)
	end

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self._imageRare, "odyssey_item_quality" .. itemConfig.rare)
	self:setSelect(nil)
end

function OdysseyHeroGroupEquipItem:setSelect(index)
	if self.index then
		local isSelect = index == self.index

		gohelper.setActive(self._goSelect, isSelect)
	end
end

function OdysseyHeroGroupEquipItem:resetPos()
	recthelper.setAnchor(self._gonoEmpty.transform, 0, 0)
end

function OdysseyHeroGroupEquipItem:clear()
	self.index = nil
	self.heroPos = nil
	self.equipUid = nil
	self.type = nil

	self:setSelect(nil)
end

function OdysseyHeroGroupEquipItem:refreshUI()
	return
end

function OdysseyHeroGroupEquipItem:onItemBeginDrag(index)
	if index == self.mo.id then
		ZProj.TweenHelper.DOScale(self.go.transform, 1.1, 1.1, 1, 0.2, nil, nil, nil, EaseType.Linear)
	end
end

function OdysseyHeroGroupEquipItem:isEmpty()
	return self.go.activeSelf == true and (self.equipUid == nil or self.equipUid == 0)
end

function OdysseyHeroGroupEquipItem:isActive()
	return self.go.activeSelf == true and self.heroPos ~= nil and self.index ~= nil
end

function OdysseyHeroGroupEquipItem:onDestroy()
	return
end

return OdysseyHeroGroupEquipItem
