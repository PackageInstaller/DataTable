-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/EquipRecycleQualityView.lua

module("logic.extensions.equipment.view.EquipRecycleQualityView", package.seeall)

local EquipRecycleQualityView = class("EquipRecycleQualityView", ViewComponent)

function EquipRecycleQualityView:ctor()
	EquipRecycleQualityView.super.ctor(self)
end

function EquipRecycleQualityView:bindEvents()
	EquipRecycleQualityView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._sureBtn:AddClickListener(self._onClickSureBtn, self)
	self._cancelBtn:AddClickListener(self.close, self)
end

function EquipRecycleQualityView:unbindEvents()
	EquipRecycleQualityView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._sureBtn:RemoveClickListener()
	self._cancelBtn:RemoveClickListener()
end

function EquipRecycleQualityView:onExit()
	EquipRecycleQualityView.super.onExit(self)

	self._strList = nil
	self._strList2 = nil
	self._strList3 = nil
end

function EquipRecycleQualityView:destroyUI()
	EquipRecycleQualityView.super.destroyUI(self)
end

function EquipRecycleQualityView:buildUI()
	EquipRecycleQualityView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._sureBtn = self:getBtn("sureBtn")
	self._cancelBtn = self:getBtn("cancelBtn")
	self._descTxt1 = self:getTxt("descTxt1")
	self._descTxt2 = self:getTxt("descTxt2")
	self._selectDrp = DropDownAdapter.GetFrom(self.mainGO, "selectDrp")
	self._selectDrp2 = DropDownAdapter.GetFrom(self.mainGO, "selectDrp2")
	self._selectDrp3 = DropDownAdapter.GetFrom(self.mainGO, "selectDrp3")
end

function EquipRecycleQualityView:onEnter()
	EquipRecycleQualityView.super.onEnter(self)

	self._descTxt1.text = lang("text_equip_desc_96")
	self._descTxt2.text = lang("text_equip_desc_97")

	self._selectDrp:ClearOptions()

	self._strList = PetEquipModel.instance:getEquipRecycleQualityList()

	for _, v in pairs(self._strList) do
		if v and not string.nilorempty(v.quaDesc) then
			self._selectDrp:AddOptions(v.quaDesc)
		end
	end

	local value = 1

	if PetEquipModel.instance.equipRecycleQua and PetEquipModel.instance.equipRecycleQua > 0 and #self._strList > 0 then
		for i = 1, #self._strList do
			if self._strList[i] and self._strList[i].quaCost == PetEquipModel.instance.equipRecycleQua then
				value = i

				break
			end
		end
	end

	self._selectDrp:SetValue(value - 1)

	local targetList = {}

	targetList[1] = {
		quaDesc = "停止自动分解",
		quaCost = 0
	}
	targetList[2] = {
		quaDesc = "<color=#0083e7>蓝色及以下星神</color>",
		quaCost = 2
	}
	targetList[3] = {
		quaDesc = "<color=#df5bff>紫色及以下星神</color>",
		quaCost = 3
	}

	self._selectDrp2:ClearOptions()

	self._strList2 = targetList

	for _, v in pairs(self._strList2) do
		if v and not string.nilorempty(v.quaDesc) then
			self._selectDrp2:AddOptions(v.quaDesc)
		end
	end

	value = 1

	if StargodplusModel.instance:getAutoDecomposeQuality() and StargodplusModel.instance:getAutoDecomposeQuality() > 0 and #self._strList2 > 0 then
		for i = 1, #self._strList2 do
			if self._strList2[i] and self._strList2[i].quaCost == StargodplusModel.instance:getAutoDecomposeQuality() then
				value = i

				break
			end
		end
	end

	self._selectDrp2:SetValue(value - 1)

	local targetList = {}

	targetList[1] = {
		quaDesc = "停止自动分解",
		quaCost = 0
	}
	targetList[2] = {
		quaDesc = "<color=#0083e7>蓝色及以下灵纹</color>",
		quaCost = 2
	}
	targetList[3] = {
		quaDesc = "<color=#df5bff>紫色及以下灵纹</color>",
		quaCost = 3
	}
	targetList[4] = {
		quaDesc = "<color=#FFA500>橙色及以下灵纹</color>",
		quaCost = 4
	}

	self._selectDrp3:ClearOptions()

	self._strList3 = targetList

	for _, v in pairs(self._strList3) do
		if v and not string.nilorempty(v.quaDesc) then
			self._selectDrp3:AddOptions(v.quaDesc)
		end
	end

	value = 1

	if HolyStripeModel.instance:getAutoDecomposeQuality() and HolyStripeModel.instance:getAutoDecomposeQuality() > 0 and #self._strList3 > 0 then
		for i = 1, #self._strList3 do
			if self._strList3[i] and self._strList3[i].quaCost == HolyStripeModel.instance:getAutoDecomposeQuality() then
				value = i

				break
			end
		end
	end

	self._selectDrp3:SetValue(value - 1)
end

function EquipRecycleQualityView:_onClickSureBtn()
	local value = self._selectDrp:GetValue() + 1

	if self._strList == nil or self._strList[value] == nil then
		return
	end

	if self._strList[value].quaCost ~= PetEquipModel.instance.equipRecycleQua then
		EquipmentAgent.instance:sendEQM_SetAutoDecomposeReq(self._strList[value].quaCost)
	end

	local value = self._selectDrp2:GetValue() + 1

	if self._strList2 == nil or self._strList2[value] == nil then
		return
	end

	if self._strList2[value].quaCost ~= StargodplusModel.instance:getAutoDecomposeQuality() then
		StargodplusModel.instance:setAutoDecomposeQuality(self._strList2[value].quaCost)
		StarGodPlusAgent.instance:sendPM_SetStarGodAutoDecomposeReq(self._strList2[value].quaCost)
	end

	local value = self._selectDrp3:GetValue() + 1

	if self._strList3 == nil or self._strList3[value] == nil then
		return
	end

	if self._strList3[value].quaCost ~= HolyStripeModel.instance:getAutoDecomposeQuality() then
		HolyStripeModel.instance:setAutoDecomposeQuality(self._strList3[value].quaCost)
		HolyStripeAgent.instance:sendPM_SetHolyStripeAutoDecomposeReq(self._strList3[value].quaCost)
	end

	self:close()
end

return EquipRecycleQualityView
