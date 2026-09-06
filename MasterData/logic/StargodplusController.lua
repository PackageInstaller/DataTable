-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodplus/controller/StargodplusController.lua

module("logic.extensions.stargodplus.controller.StargodplusController", package.seeall)

local StargodplusController = class("StargodplusController", BaseController)

StargodplusController.PM_LoadAllFillerRes = "StargodplusController.PM_LoadAllFillerRes"
StargodplusController.PM_EquipFillerRes = "StargodplusController.PM_EquipFillerRes"
StargodplusController.PM_UnloadFillerRes = "StargodplusController.PM_UnloadFillerRes"
StargodplusController.PM_UpgradeSlotRes = "StargodplusController.PM_UpgradeSlotRes"
StargodplusController.PM_NotifyFillersChangeRes = "StargodplusController.PM_NotifyFillersChangeRes"
StargodplusController.On_Select_FilterType = "StargodplusController.On_Select_FilterType"
StargodplusController.PM_OneKeyEquipFillersRes = "StargodplusController.PM_OneKeyEquipFillersRes"
StargodplusController.PM_SetStarGodAutoDecomposeRes = "StargodplusController.PM_SetStarGodAutoDecomposeRes"
StargodplusController.PM_StarGodUnbindRaceIdRes = "StargodplusController.PM_SetStarGodAutoDecomposeRes"

function StargodplusController:ctor()
	return
end

function StargodplusController:onInit()
	GlobalDispatcher:addListener(StarGodPlusAgent.PM_LoadAllFillerRes, self._PM_LoadAllFillerRes, self)
	GlobalDispatcher:addListener(StarGodPlusAgent.PM_EquipFillerRes, self._PM_EquipFillerRes, self)
	GlobalDispatcher:addListener(StarGodPlusAgent.PM_UnloadFillerRes, self._PM_UnloadFillerRes, self)
	GlobalDispatcher:addListener(StarGodPlusAgent.PM_UpgradeSlotRes, self._PM_UpgradeSlotRes, self)
	GlobalDispatcher:addListener(StarGodPlusAgent.PM_NotifyFillersChangeRes, self._PM_NotifyFillersChangeRes, self)
	GlobalDispatcher:addListener(StarGodPlusAgent.PM_OneKeyEquipFillersRes, self._PM_OneKeyEquipFillersRes, self)
	GlobalDispatcher:addListener(StarGodPlusAgent.PM_SetStarGodAutoDecomposeRes, self._PM_SetStarGodAutoDecomposeRes, self)
	GlobalDispatcher:addListener(StarGodPlusAgent.PM_StarGodUnbindRaceIdRes, self._PM_StarGodUnbindRaceIdRes, self)
	GlobalDispatcher:addListener(GlobalNotify.BagPetAttrChanged, self._onPetChange, self)
	self:onReset()
end

function StargodplusController:onReset()
	self._isloadAllFiller = false
	self._upgrdeRes = false
end

function StargodplusController:sendPM_LoadAllFillerReq()
	if self._isloadAllFiller then
		return
	end

	StarGodPlusAgent.instance:sendPM_LoadAllFillerReq()
end

function StargodplusController:_PM_LoadAllFillerRes(status, msg)
	if status == 0 then
		self._loadAllFiller = true

		StargodplusModel.instance:setAllFillerinfos(msg.fillers)
		StargodplusModel.instance:setAutoDecomposeQuality(msg.autoDecomposeQuality)
		GlobalDispatcher:dispatch(StargodplusController.PM_LoadAllFillerRes)
	end
end

function StargodplusController:_PM_EquipFillerRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("穿戴成功")
		GlobalDispatcher:dispatch(StargodplusController.PM_EquipFillerRes)
	end
end

function StargodplusController:_PM_UnloadFillerRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(StargodplusController.PM_UnloadFillerRes)
	end
end

function StargodplusController:_PM_UpgradeSlotRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("强化成功")

		self._upgrdeRes = true

		if self._cachePetChangeData then
			self:_onPetChange(self._cachePetChangeData.oldPet, self._cachePetChangeData.newPet)
		end

		GlobalDispatcher:dispatch(StargodplusController.PM_UpgradeSlotRes)
	end
end

function StargodplusController:_PM_NotifyFillersChangeRes(status, msg)
	if status == 0 then
		self:_checkPetWearOrTakeoffEquip(msg.changedFillers)
		StargodplusModel.instance:fillersChangeRes(msg.changedFillers)
		GlobalDispatcher:dispatch(StargodplusController.PM_NotifyFillersChangeRes)
	end
end

function StargodplusController:_PM_OneKeyEquipFillersRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(StargodplusController.PM_OneKeyEquipFillersRes)
	end
end

function StargodplusController:_PM_SetStarGodAutoDecomposeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(StargodplusController.PM_SetStarGodAutoDecomposeRes)
	end
end

function StargodplusController:_PM_StarGodUnbindRaceIdRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(StargodplusController.PM_StarGodUnbindRaceIdRes)
	end
end

function StargodplusController:_onPetChange(oldPet, newPet)
	if not self._upgrdeRes then
		self._cachePetChangeData = {
			oldPet = oldPet,
			newPet = newPet
		}

		return
	else
		self._cachePetChangeData = nil
	end

	self._upgrdeRes = false

	local oldstarGodPlusSlots = oldPet:getStarGodPlusSlots()
	local newstarGodPlusSlots = newPet:getStarGodPlusSlots()
	local hasSlotData = {}

	if oldstarGodPlusSlots and #oldstarGodPlusSlots > 0 then
		for k, v in ipairs(oldstarGodPlusSlots) do
			hasSlotData[v.slot] = v
		end
	end

	if newstarGodPlusSlots and #newstarGodPlusSlots > 0 then
		local canBreak = false

		for i, v in ipairs(newstarGodPlusSlots) do
			local data = hasSlotData[v.slot]

			if data and data.exp < v.exp then
				local cfg = StargodplusConfig.instance:getSlotCfg(v.slot)
				local lvcfgs = StargodplusConfig.instance:getSlotLvPlan(cfg.slotLvPlan)

				for _, lvcfg in ipairs(lvcfgs) do
					if data.exp < lvcfg.exp and v.exp >= lvcfg.exp then
						local oldLv = StargodplusModel.instance:getSlotLv(v.slot, data.exp)
						local newLv = StargodplusModel.instance:getSlotLv(v.slot, v.exp)

						if newLv - oldLv >= 1 then
							self:_calAttrCompare(newPet.petId, data.fillerDefineId, oldLv, newLv)
						end

						canBreak = true

						break
					end
				end
			end

			if canBreak then
				break
			end
		end
	end
end

function StargodplusController:_calAttrCompare(petId, fillerDefineId, oldLv, newLv)
	local resList = StargodplusModel.instance:getSlotCompareList(fillerDefineId, oldLv, newLv)

	UIStateManager.instance:push(ViewName.CommonlvupView, resList)
	BagPetsController.instance:updateStarGodPlusAttrById(petId)
end

function StargodplusController:_checkPetWearOrTakeoffEquip(changedFillers)
	local list = StargodplusModel.instance:getFillerMoList()
	local fillerId2petIdList = {}

	for i, mo in pairs(list) do
		local petId = mo:getUsePetId()
		local fillerId = mo:getId()

		if petId > 0 and fillerId > 0 then
			fillerId2petIdList[fillerId] = petId
		end
	end

	local needCalIdList = {}

	for i, v in ipairs(changedFillers) do
		if not fillerId2petIdList[v.fillerId] then
			local petId = 0

			if v.deleted then
				if petId and petId > 0 then
					needCalIdList[petId] = true
				end
			else
				needCalIdList[petId] = true

				if v.equippedPetId > 0 and v.equippedPetId ~= petId then
					needCalIdList[v.equippedPetId] = true
				end
			end
		end
	end

	for petId, v in pairs(needCalIdList) do
		if petId > 0 then
			BagPetsController.instance:updateStarGodPlusAttrById(petId)
		end
	end
end

StargodplusController.instance = StargodplusController.New()

return StargodplusController
