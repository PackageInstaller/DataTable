-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starequipment/view/EquipBreakthroughView.lua

module("logic.extensions.starequipment.view.EquipBreakthroughView", package.seeall)

local EquipBreakthroughView = class("EquipBreakthroughView", ViewComponent)

function EquipBreakthroughView:getBigBgList()
	return {
		{
			goPath = "txtGoldNum/imgGold",
			imageUrl = "ui/icon/items/icon_jinbi.png"
		}
	}
end

function EquipBreakthroughView:ctor()
	EquipBreakthroughView.super.ctor(self)
end

function EquipBreakthroughView:destroyUI()
	EquipBreakthroughView.super.destroyUI(self)
end

function EquipBreakthroughView:onExitFinished()
	EquipBreakthroughView.super.onExitFinished(self)
end

function EquipBreakthroughView:onEnterFinished()
	EquipBreakthroughView.super.onEnterFinished(self)
end

function EquipBreakthroughView:unbindEvents()
	EquipBreakthroughView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnBreakthrough:RemoveClickListener()
end

function EquipBreakthroughView:bindEvents()
	EquipBreakthroughView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnBreakthrough:AddClickListener(self._onClickBreakthrough, self)
end

function EquipBreakthroughView:onExit()
	EquipBreakthroughView.super.onExit(self)

	if self._closeCall ~= nil then
		self._closeCall()
	end
end

function EquipBreakthroughView:buildUI()
	EquipBreakthroughView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._curEquip = self:getGo("curEquip")
	self._targetEquip = self:getGo("targetEquip")

	local attrs = self:getGo("attrs/gridAttrs")

	self._itemAttrs = ItemEquipAttrs.New(attrs)

	local mats = self:getGo("cost/gridMats")

	self._itemMats = ItemMatsGrid.New(mats)
	self._txtGoldNum = goutil.findChildComponent(self.mainGO, "txtGoldNum", "Text")
	self._btnBreakthrough = self:getBtn("btnBreakThrough")
end

function EquipBreakthroughView:onEnter()
	EquipBreakthroughView.super.onEnter(self)

	local params = self:getOpenParam()

	self._equipMo = params[1]
	self._petMo = params[2]
	self._slotIndex = params[3]
	self._closeCall = params[4]

	local equipId = self._equipMo.equipmentId
	local equipCfg = StarEquipmentConfig.instance:getEquipCfg(equipId)
	local targetEquipId = equipCfg.breakThrough

	MaterialMgr.setCellByCfg(string.format("%s:%s:0", MatType.StarEquipment, equipId), self._curEquip)

	local proxy = MaterialMgr.setCellByCfg(string.format("%s:%s:0", MatType.StarEquipment, targetEquipId), self._targetEquip)

	self._itemAttrs:onSetMoBreak(equipId, targetEquipId, self._equipMo.level)
	self._itemMats:onSetMo(equipCfg.breakThroughCostMp)

	local curNum = MaterialFacade.instance:getMatNumber(MatType.Coin, 1, costGoldNum)
	local needNum = checknumber(equipCfg.breakThroughCostCoin)

	self._isGoldEnough = needNum <= curNum

	local color = needNum <= curNum and "000000" or "ff0000"

	self._txtGoldNum.text = string.format("<color=#%s>%s</color>", color, needNum)
end

function EquipBreakthroughView:_onClickClose()
	self:close()
end

function EquipBreakthroughView:_onClickBreakthrough()
	if not self._itemMats:getMatsIsEnough() then
		FloatWordMgr.instance:show("当前材料不足！")
	elseif not self._isGoldEnough then
		FloatWordMgr.instance:show("当前金币不足！")
	else
		StarEquipmentAgent.instance:sendSE_BreakThroughReq(self._petMo.petId, self._slotIndex - 1, self._equipMo.equipmentId, self._onBreakthrough, self)
	end
end

function EquipBreakthroughView:_onBreakthrough()
	FloatWordMgr.instance:show("星辉突破成功了呢")
	self:close()
end

return EquipBreakthroughView
