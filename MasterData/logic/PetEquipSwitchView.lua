-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starequipment/view/PetEquipSwitchView.lua

module("logic.extensions.starequipment.view.PetEquipSwitchView", package.seeall)

local PetEquipSwitchView = class("PetEquipSwitchView", ViewComponent)

function PetEquipSwitchView:ctor()
	PetEquipSwitchView.super.ctor(self)
end

function PetEquipSwitchView:destroyUI()
	PetEquipSwitchView.super.destroyUI(self)
end

function PetEquipSwitchView:onExitFinished()
	PetEquipSwitchView.super.onExitFinished(self)
end

function PetEquipSwitchView:onEnterFinished()
	PetEquipSwitchView.super.onEnterFinished(self)
end

function PetEquipSwitchView:unbindEvents()
	PetEquipSwitchView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function PetEquipSwitchView:bindEvents()
	PetEquipSwitchView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function PetEquipSwitchView:onExit()
	PetEquipSwitchView.super.onExit(self)

	if self._closeCall ~= nil then
		self._closeCall()
	end
end

function PetEquipSwitchView:buildUI()
	PetEquipSwitchView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._items = {}

	local items = self:getGo("items")

	for i = 1, 3 do
		local item = {}
		local go = goutil.findChild(items, i)

		item.mainGO = go
		item.fill = goutil.findChild(go, "fill")
		item.empty = goutil.findChild(go, "empty")
		item.itemPoint = goutil.findChild(item.fill, "itemPoint")
		item.txtName = goutil.findChildComponent(item.fill, "txtName", "Text")
		item.txtLevel = goutil.findChildComponent(item.fill, "txtLevel", "Text")

		local attrs = goutil.findChild(item.fill, "attrs")

		item.attrs = ItemEquipAttrs.New(attrs)
		item.btnSwitch = Framework.ButtonAdapter.GetFrom(item.fill, "btnSwitch")
		item.txtSwitch = goutil.findChildComponent(item.btnSwitch.gameObject, "Text", "Text")
		item.selected = goutil.findChild(item.btnSwitch.gameObject, "imgGou")
		item.btnOpenEquipSelect = Framework.ButtonAdapter.GetFrom(item.empty, "btnOpenEquipSelect")

		item.btnOpenEquipSelect:AddClickListener(self._onClickOpenEquipSelect, self)
		table.insert(self._items, item)
	end
end

function PetEquipSwitchView:onEnter()
	PetEquipSwitchView.super.onEnter(self)

	local params = self:getOpenParam()

	self._petMo = params[1]
	self._slotIndex = params[2]
	self._closeCall = params[3]
	self._equipIds = {}

	self:_udpateUI()
end

function PetEquipSwitchView:_udpateUI()
	local equipMos = self._petMo:getSlotEquipInfos(self._slotIndex)

	for _, equipMo in ipairs(equipMos) do
		local isFind = false

		for _, equipId in ipairs(self._equipIds) do
			if equipId == equipMo.equipmentId then
				isFind = true

				break
			end
		end

		if not isFind then
			table.insert(self._equipIds, equipMo.equipmentId)
		end
	end

	local curUseEquip = self._petMo:getSlotEquip(self._slotIndex)

	for i = 1, 3 do
		local item = self._items[i]

		goutil.setActive(item.fill, i <= #self._equipIds)
		goutil.setActive(item.empty, i > #self._equipIds)

		if i <= #self._equipIds then
			local equipMo = self._petMo:getSlotEquipById(self._slotIndex, self._equipIds[i])
			local equipId = equipMo.equipmentId
			local equipCfg = StarEquipmentConfig.instance:getEquipCfg(equipId)

			MaterialMgr.setCellByCfg(string.format("%s:%s:0", MatType.StarEquipment, equipId), item.itemPoint)

			item.txtName.text = equipCfg.name
			item.txtLevel.text = string.format("Lv.%s", equipMo.level)

			item.attrs:onSetMo(equipId, equipMo.level)

			if equipMo == curUseEquip then
				item.txtSwitch.text = "使用中"

				goutil.setActive(item.selected, true)
				item.btnSwitch:RemoveClickListener()
			else
				item.txtSwitch.text = "未使用"

				goutil.setActive(item.selected, false)
				item.btnSwitch:AddClickListener(function()
					self:_onClickSwitch(equipId)
				end)
			end
		end
	end
end

function PetEquipSwitchView:_onClickSwitch(equipId)
	StarEquipmentAgent.instance:sendSE_SwitchReq(self._petMo.petId, self._slotIndex - 1, equipId, self._onSwitch, self)
end

function PetEquipSwitchView:_onClickOpenEquipSelect()
	UIStateManager.instance:open(ViewName.EquipSelect, self._petMo, self._slotIndex, function()
		self:_udpateUI()
	end)
end

function PetEquipSwitchView:_onSwitch()
	FloatWordMgr.instance:show("切换成功了呢")
	self:_udpateUI()
end

function PetEquipSwitchView:_onClickClose()
	self:close()
end

return PetEquipSwitchView
