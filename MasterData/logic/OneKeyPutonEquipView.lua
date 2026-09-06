-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starequipment/view/OneKeyPutonEquipView.lua

module("logic.extensions.starequipment.view.OneKeyPutonEquipView", package.seeall)

local OneKeyPutonEquipView = class("OneKeyPutonEquipView", ViewComponent)

function OneKeyPutonEquipView:ctor()
	OneKeyPutonEquipView.super.ctor(self)
end

function OneKeyPutonEquipView:destroyUI()
	OneKeyPutonEquipView.super.destroyUI(self)
end

function OneKeyPutonEquipView:onExitFinished()
	OneKeyPutonEquipView.super.onExitFinished(self)
end

function OneKeyPutonEquipView:onEnterFinished()
	OneKeyPutonEquipView.super.onEnterFinished(self)
end

function OneKeyPutonEquipView:unbindEvents()
	OneKeyPutonEquipView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnOk:RemoveClickListener()
	self._btnCancle:RemoveClickListener()
end

function OneKeyPutonEquipView:bindEvents()
	OneKeyPutonEquipView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnOk:AddClickListener(self._onClickOk, self)
	self._btnCancle:AddClickListener(self._onClickClose, self)
end

function OneKeyPutonEquipView:onExit()
	OneKeyPutonEquipView.super.onExit(self)
end

function OneKeyPutonEquipView:buildUI()
	OneKeyPutonEquipView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")

	local main = self:getGo("main")

	self._equips = {}

	local equips = goutil.findChild(main, "equips")

	self._equipsTrans = equips.transform

	for i = 1, CharacterConfig.MAX_STAR_SLOT_COUNT do
		local equip = {}

		equip.mainGO = goutil.findChild(equips, i)

		table.insert(self._equips, equip)
	end

	self._btnOk = self:getBtn("main/btnOK")
	self._btnCancle = self:getBtn("main/btnCancle")
end

function OneKeyPutonEquipView:onEnter()
	OneKeyPutonEquipView.super.onEnter(self)

	local params = self:getOpenParam()

	self._petMo = params[1]
	self._equipIds = params[2]

	local i = 1

	for _, equipId in pairs(self._equipIds) do
		local equip = self._equips[i]

		goutil.setActive(equip.mainGO, true)

		local matStr = string.format("%s:%s:0", MatType.StarEquipment, equipId)

		MaterialMgr.setCellByCfg(matStr, equip.mainGO)

		i = i + 1
	end

	for j = i, CharacterConfig.MAX_STAR_SLOT_COUNT do
		goutil.setActive(self._equips[j].mainGO, false)
	end

	local x, y, z = Framework.TransformUtil.GetLocalPos(self._equipsTrans, 0, 0, 0)

	Framework.TransformUtil.SetLocalPos(self._equipsTrans, -60 * (i - 2), y, z)
end

function OneKeyPutonEquipView:_onClickClose()
	self:close()
end

function OneKeyPutonEquipView:_onClickOk()
	local equipIds = {}

	for slotIndex = 1, CharacterConfig.MAX_STAR_SLOT_COUNT do
		table.insert(equipIds, self._equipIds[slotIndex] or -1)
	end

	StarEquipmentAgent.instance:sendSE_BatchEquipReq(self._petMo.petId, equipIds, self._onBatchEquip, self)
end

function OneKeyPutonEquipView:_onBatchEquip()
	self:close()
	FloatWordMgr.instance:show("一键装备成功")
end

return OneKeyPutonEquipView
