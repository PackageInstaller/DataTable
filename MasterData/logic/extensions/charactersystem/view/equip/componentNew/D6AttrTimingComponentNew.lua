-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/componentNew/D6AttrTimingComponentNew.lua

module("logic.extensions.charactersystem.view.equip.componentNew.D6AttrTimingComponentNew", package.seeall)

local M = class("D6AttrTimingComponentNew")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)

	self:_buildUI()
end

function M:_buildUI()
	self._icon = self._registry:getImage("attriubte_d6_right_tips_copy_40758660")
	self._lockGo = self._registry:getGo("attriubte_d6_right_tips_copy_-1030982751")
	self._txtName = self:getText("attriubte_d6_right_tips_copy_619354886")
	self._btnRetiming = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGo, "node/content3/btnReset"))
	self._consumeInfoGo = goutil.findChild(self._mainGo, "node/content3/com_price").gameObject
	self._txtConsume1 = goutil.findChildComponent(self._consumeInfoGo, "price1/txtPrice1", UIComponentType.Text)
	self._txtConsume2 = goutil.findChildComponent(self._consumeInfoGo, "price2/txtPrice2", UIComponentType.Text)
	self._imgConsume1 = goutil.findChildImageComponent(self._consumeInfoGo, "price1/icon")
	self._imgConsume2 = goutil.findChildImageComponent(self._consumeInfoGo, "price2/icon")
	self._lock = self._registry:getGo("attriubte_d6_right_tips_copy_284539718")
	self._unlock = self._registry:getGo("attriubte_d6_right_tips_copy_1092915799")
	self._btnLock = self._registry:getBtn("attriubte_d6_right_tips_copy_1431375964")

	local itemsParentContent = self._registry:getGo("attriubte_d6_right_tips_copy_-726530779")
	local itemsParent = goutil.findChild(itemsParentContent, "d6AttributeLayout")
	local attributeD6Template = goutil.findChild(itemsParent, "d6_attribute_item")

	goutil.setActive(attributeD6Template, false)

	self._d6attributeItemViewList = {}

	for index = 1, EquipEnum.MaxD6AttrHoleCount do
		local d6AttributeItemGo = goutil.clone(attributeD6Template)

		goutil.setActive(d6AttributeItemGo, true)
		goutil.addChildToParent(d6AttributeItemGo, itemsParent)

		local itemView = Astral.LuaComponentContainer.Add(d6AttributeItemGo, D6AttrComponentItem)

		table.insert(self._d6attributeItemViewList, itemView)
	end

	goutil.setActive(self._btnRetiming.gameObject, true)
	goutil.setActive(goutil.findChild(self._consumeInfoGo, "price1"), false)
	goutil.setActive(goutil.findChild(self._consumeInfoGo, "price2"), true)

	self._btnCanvasGroup = goutil.findChild(self._mainGo, "node/content3"):GetComponent(ComponentType.CanvasGroup)
	self._retimingGo = goutil.findChild(self._mainGo, "node")
	self._firstTimingGo = goutil.findChild(self._mainGo, "emptyNode")
	self._firstTimingBtn = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGo, "emptyNode/btnFirstTime"))

	goutil.setActive(self._retimingGo, true)
	goutil.setActive(self._firstTimingGo, false)
end

function M:setTipsPos(pos1, pos2)
	self._tipsGo = {}

	table.insert(self._tipsGo, pos1)
	table.insert(self._tipsGo, pos2)
end

function M:OnDestroy()
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
	self._btnRetiming:AddClickListener(self._onClickTimingBtn, self)
	self._firstTimingBtn:AddClickListener(self._onClickFirstTiming, self)
end

function M:unbindEvents()
	self._btnLock:RemoveClickListener()
	self._btnRetiming:RemoveClickListener()
	self._firstTimingBtn:RemoveClickListener()
end

function M:setData(d6Mo)
	self._mo = d6Mo

	self:_setConsumeIcon()
	self:refreshView()
end

function M:_setConsumeIcon()
	self._itemIdConsume = EquipIntensifyModel.instance:getTimingItemId()
	self._currencyId = GameEnum.CurrencyCodeEnum.LzbCode

	MoneyUtil.setMoneyIcon(self._imgConsume1, self._itemIdConsume)
	MoneyUtil.setMoneyIcon(self._imgConsume2, self._currencyId)
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

	IconLoader.setSprite(self._icon, IconType.D6Icon, mo:getIcon())
	self._lockGo:SetActive(mo:getIsLock())

	local quality = mo:getQuality()
	local qualityName = lang(CommEnum.Quality2Lang[quality])

	self._txtName.text = qualityName .. mo:getName()

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

	local isLock = self._mo:getIsLock()

	goutil.setActive(self._lock, isLock)
	goutil.setActive(self._unlock, not isLock)
end

function M:_refreshConsumeItemsInfo()
	local goldHas = ItemModel.instance:getItemCountByItemId(self._currencyId)
	local goldNeed = EquipIntensifyModel.instance:getTimingConsumeInfo()

	self:setText(self._txtConsume2, goldNeed, goldHas)

	self._canTiming = goldNeed <= goldHas

	self:setBtnState()
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

function M:_onClickFirstTiming()
	GlobalDispatcher:dispatchEvent(EventType.EQUIP_UI_STATUS_CHANGED, EquipEnum.MainUIStatus.Timing)
end

function M:_onClickTimingBtn()
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_jiaoshiqijiediantiaojiao1, nil, nil, nil)

	if self._canTiming then
		EquipIntensifyModel.instance:backupsEquip()

		local equipUuid = EquipIntensifyModel.instance:getOperatingEquip():getUuid()
		local diceUuid = self._mo:getUuid()
		local effectIndex = EquipIntensifyModel.instance:getTimingHoleIndex()

		EquipmentAgent.instance:sendDiceRollRequest(equipUuid, diceUuid, effectIndex)
	else
		ToolTipsMgr.showCharacterTopToast(lang("tip_equip_timing_item_less"), CommEnum.CharacterTopToastIcon.Fail, 1)
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

function M:setBtnState()
	local go = self._btnRetiming.gameObject
	local img = goutil.findChildImageComponent(go, "Image1")
	local txt = goutil.findChildTextComponent(go, "Text")

	if self._canTiming then
		img.color = parsecolor("#FFFFFFFF")
		txt.color = parsecolor("#000000")
	else
		img.color = parsecolor("#FFFFFF14")
		txt.color = parsecolor("#18141A")
	end
end

return M
