-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/component/D6AttrTimingComponent.lua

module("logic.extensions.charactersystem.view.equip.component.D6AttrTimingComponent", package.seeall)

local M = class("D6AttrTimingComponent")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)

	self:_buildUI()
end

function M:_buildUI()
	self._imgQuality = self._registry:getImage("attriubte_d6_right_tips_1984452839")
	self._icon = self._registry:getImage("attriubte_d6_right_tips_2068922968")
	self._lockGo = self._registry:getGo("attriubte_d6_right_tips_-1030982751")
	self._discardGo = self._registry:getGo("attriubte_d6_right_tips_1130944318")
	self._txtName = self._registry:getText("attriubte_d6_right_tips_-1659060617")
	self._btnRetiming = self._registry:getBtn("attriubte_d6_right_tips_1249111321")
	self._txtConsume1 = self._registry:getText("attriubte_d6_right_tips_-1238414717")
	self._txtConsume2 = self._registry:getText("attriubte_d6_right_tips_1786616307")
	self._imgConsume1 = self._registry:getImage("attriubte_d6_right_tips_-532979381")
	self._imgConsume2 = self._registry:getImage("attriubte_d6_right_tips_795736238")
	self._timingBtnMask = self._registry:getGo("attriubte_d6_right_tips_1008369147")
	self._consumeInfoGo = self._registry:getGo("attriubte_d6_right_tips_256960034")
	self._lock = self._registry:getGo("attriubte_d6_right_tips_284539718")
	self._unlock = self._registry:getGo("attriubte_d6_right_tips_1092915799")
	self._btnLock = self._registry:getBtn("attriubte_d6_right_tips_1431375964")
	self._undiscard = self._registry:getGo("attriubte_d6_right_tips_810170979")
	self._btnDiscard = self._registry:getBtn("attriubte_d6_right_tips_128627153")

	local itemsParent = self._registry:getGo("attriubte_d6_right_tips_1339473093")
	local attributeD6Template = goutil.findChild(itemsParent, "d6_attribute_item1")

	self._d6attributeItemViewList = {}

	for index = 1, EquipEnum.MaxD6AttrHoleCount do
		local d6AttributeItemGo = goutil.clone(attributeD6Template)

		goutil.setActive(d6AttributeItemGo, true)
		goutil.addChildToParent(d6AttributeItemGo, itemsParent)

		local itemView = Astral.LuaComponentContainer.Add(d6AttributeItemGo, D6AttrComponentItem)

		table.insert(self._d6attributeItemViewList, itemView)
	end

	self._btnRetiming:AddClickListener(self._onClickTimingBtn, self)
	goutil.setActive(self._btnRetiming.gameObject, true)
	goutil.setActive(goutil.findChild(self._consumeInfoGo, "price1"), false)
end

function M:setTipsPos(pos1, pos2)
	self._tipsGo = {}

	table.insert(self._tipsGo, pos1)
	table.insert(self._tipsGo, pos2)
end

function M:OnDestroy()
	self._btnRetiming:RemoveClickListener()

	self._d6attributeItemViewList = nil
end

function M:onExit()
	self._mo = nil
end

function M:_onClickLockBtn()
	local uuid = self._mo:getUuid()
	local isLock = self._mo:getIsLock()

	if not isLock then
		EquipmentAgent.instance:sendDiceLockToggleRequest(uuid)
	else
		local dialog = Dialog.showMessage(lang("tip_sure_unlock"), lang("tip_unlock_d6"))

		dialog:setConfirmListener(function()
			EquipmentAgent.instance:sendDiceLockToggleRequest(uuid)
		end, self)
	end
end

function M:_onClickDiscard()
	local equipId = self._mo:getUuid()

	EquipmentAgent.instance:sendDiceDiscardToggleRequest(equipId)
end

function M:bindEvents()
	self._btnLock:AddClickListener(self._onClickLockBtn, self)
	self._btnDiscard:AddClickListener(self._onClickDiscard, self)
end

function M:unbindEvents()
	self._btnLock:RemoveClickListener()
	self._btnDiscard:RemoveClickListener()
end

function M:setData(d6Mo)
	self._mo = d6Mo

	self:_setConsumeIcon()
	self:refreshView()
end

function M:_setConsumeIcon()
	self._itemIdConsume = EquipIntensifyModel.instance:getTimingItemId()
	self._currencyId = GameEnum.CurrencyCodeEnum.LzbCode

	IconLoader.setSprite(self._imgConsume2, IconType.Skinlib, CommEnum.CurrencyItemSrc[self._currencyId])
end

function M:refreshView()
	if not self._mo then
		self._mainGo:SetActive(false)

		self._canTiming = false

		return
	end

	self._mainGo:SetActive(true)
	self:_refreshAttrs()
	self:refreshLockAndDiscard()
	self:_refreshConsumeItemsInfo()
end

function M:_refreshAttrs()
	local mo = self._mo

	IconLoader.setSprite(self._imgQuality, IconType.Skinlib, GameUrl.getEquipQualityUrl(mo:getQuality()))
	IconLoader.setSprite(self._icon, IconType.D6Icon, mo:getIcon())
	self._lockGo:SetActive(mo:getIsLock())

	self._txtName.text = mo:getName()

	local attrs = mo:getAttrs()

	for index = 1, EquipEnum.MaxD6AttrHoleCount do
		local itemView = self._d6attributeItemViewList[index]
		local diceAttrMo = attrs[index]

		itemView:setData(diceAttrMo, true)
		itemView:setCurrentGoVisible(false)
		itemView:setTimingIndex(index)
	end
end

function M:refreshLockAndDiscard()
	goutil.setActive(self._lockGo, true)
	goutil.setActive(self._discardGo, true)

	local isLock = self._mo:getIsLock()

	goutil.setActive(self._lock, isLock)
	goutil.setActive(self._unlock, not isLock)

	local isDiscard = self._mo:getIsDiscard()

	goutil.setActive(self._undiscard, not isDiscard)
end

function M:_refreshConsumeItemsInfo()
	local goldHas = ItemModel.instance:getItemCountByItemId(self._currencyId)
	local goldNeed = EquipIntensifyModel.instance:getTimingConsumeInfo()

	self:setText(self._txtConsume2, goldNeed, goldHas)

	self._canTiming = goldNeed <= goldHas

	goutil.setActive(self._timingBtnMask, not self._canTiming)
end

function M:setBtnResetVisible(visible)
	goutil.setActive(self._btnRetiming.gameObject, visible)
end

function M:setText(txt, num, has)
	if has < num then
		txt.text = string.format("<color=#FF5C63>%d</color>", num)
	else
		txt.text = string.format("<color=#E4E4E4>%d</color>", num)
	end
end

function M:_onClickTimingBtn()
	if self._canTiming then
		EquipIntensifyModel.instance:backupsEquip()

		local equipUuid = EquipIntensifyModel.instance:getOperatingEquip():getUuid()
		local diceUuid = self._mo:getUuid()
		local effectIndex = EquipIntensifyModel.instance:getTimingHoleIndex()

		EquipmentAgent.instance:sendDiceRollRequest(equipUuid, diceUuid, effectIndex)
	else
		FloatWordMgr.instance:show(lang("tip_equip_timing_item_less"))
		self:_showItemTips(not self._isCurrenyEnough, false)
	end
end

function M:_showItemTips(showItem1, showItem2)
	local index = 1
	local viewName

	if showItem1 then
		local data = ToolTipsUtil.createItemTipsData(ItemData.New({
			count = 0,
			itemId = self._currencyId
		}), self._tipsGo[index])

		ToolTipsMgr.showTips(data.viewName, data)

		index = index + 1
		viewName = ViewName.ToolTipsSimple2View
	end

	if showItem2 then
		local data = ToolTipsUtil.createItemTipsData(ItemData.New({
			count = 0,
			itemId = self._itemIdConsume
		}), self._tipsGo[index])

		ToolTipsMgr.showTips(viewName or data.viewName, data)
	end
end

return M
