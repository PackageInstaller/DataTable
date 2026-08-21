-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/componentNew/D6AttrRetimingComponentNew.lua

module("logic.extensions.charactersystem.view.equip.componentNew.D6AttrRetimingComponentNew", package.seeall)

local M = class("D6AttrRetimingComponentNew", D6AttrTimingComponentNew)

function M:_buildUI()
	M.super._buildUI(self)
	goutil.setActive(goutil.findChild(self._consumeInfoGo, "price1"), true)
end

function M:refreshView()
	M.super.refreshView(self)

	if self._mo then
		local effectFace = self._mo:getEffectFace()

		for index = 1, EquipEnum.MaxD6AttrHoleCount do
			self._d6attributeItemViewList[index]:setCurrentGoVisible(effectFace == index)
		end
	end
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

		itemView:setSourceData(diceAttrMo, true)
		itemView:setCurrentGoVisible(false)
		itemView:setTimingIndex(index)
	end
end

function M:showFirstTiming(isShow)
	goutil.setActive(self._retimingGo, not isShow)
	goutil.setActive(self._firstTimingGo, isShow)
end

function M:refreshLockAndDiscard()
	goutil.setActive(self._lockGo, false)
	goutil.setActive(self._discardGo, false)
end

function M:_refreshConsumeItemsInfo()
	self._isMax = EquipIntensifyModel.instance:isMaxTimingTimes()

	goutil.setActive(self._consumeInfoGo, not self._isMax)

	if self._isMax then
		self._canTiming = false

		return
	end

	local itemHas = ItemModel.instance:getItemCountByItemId(self._itemIdConsume)
	local goldHas = ItemModel.instance:getItemCountByItemId(self._currencyId)
	local itemNeed, goldNeed = EquipIntensifyModel.instance:getRetimingConsumeInfo()

	if not itemNeed then
		printError("调校信息获取失败，请检查")

		self._canTiming = false

		return
	end

	self:setText(self._txtConsume1, itemNeed, itemHas)
	self:setText(self._txtConsume2, goldNeed, goldHas)

	self._canTiming = itemNeed <= itemHas and goldNeed <= goldHas
	self._isItemEnough = itemNeed <= itemHas
	self._isCurrenyEnough = goldNeed <= goldHas

	self:setBtnState()
end

function M:_onClickTimingBtn()
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_jiaoshiqijiediantiaojiao1, nil, nil, nil)

	if self._isMax then
		ToolTipsMgr.showCharacterTopToast(lang("tip_equip_timing_times_less"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	if not self._canTiming then
		ToolTipsMgr.showCharacterTopToast(lang("tip_equip_timing_item_less"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	EquipIntensifyModel.instance:backupsEquip()

	local equipUuid = EquipIntensifyModel.instance:getOperatingEquip():getUuid()
	local effectIndex = EquipIntensifyModel.instance:getTimingHoleIndex()

	EquipmentAgent.instance:sendDiceReRollRequest(equipUuid, effectIndex)
end

return M
