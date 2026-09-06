-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/controller/PetEquipController.lua

module("logic.extensions.equipment.controller.PetEquipController", package.seeall)

local PetEquipController = class("PetEquipController", BaseController)

function PetEquipController:ctor()
	self._openTabIndex = nil
end

function PetEquipController:onInit()
	self:onReset()
	EquipmentAgent.instance:addHandler(EquipmentAgent.EQM_LoadAllEquipmentsRes, self.SCLoadAllEquipmentsInfo, self)
	EquipmentAgent.instance:addHandler(EquipmentAgent.EQM_NotifyEquipmentsChangeRes, self.SCEquipInfoChange, self)
	EquipmentAgent.instance:addHandler(EquipmentAgent.EQM_UpgradeRes, self.SCEquipInfoUpgrade, self)
	DecorationAgent.instance:addHandler(DecorationAgent.PM_LoadAllDecorationRes, self.SCLoadAllDecoration, self)
	DecorationAgent.instance:addHandler(DecorationAgent.PM_UpgradeDecorationRes, self.SCUpgradeDecoration, self)
	DecorationAgent.instance:addHandler(DecorationAgent.PM_NotifyDecorationsChangeRes, self.SCDecorationInfoChange, self)
	PetCommentAgent.instance:addHandler(PetCommentAgent.PM_PetCommentUserInfoRes, self.SCGetPetCommentInfo, self)
	PetCommentAgent.instance:addHandler(PetCommentAgent.PM_PetCommentInfoRes, self.SCPinglunInfoList, self)
	PetCommentAgent.instance:addHandler(PetCommentAgent.PM_PetCommentLikeRes, self.SCGiveRoleDianzan, self)
	PetCommentAgent.instance:addHandler(PetCommentAgent.PM_SendPetCommentRes, self.SCPinglunPetContent, self)
	PetCommentAgent.instance:addHandler(PetCommentAgent.PM_PetCommentReportRes, self.SCJubaoRoleComment, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._tickDailyRefreshData, self)
end

function PetEquipController:onReset()
	self.isWaiting = false
	self.isEquipInit = false
	self._openTabIndex = nil
	self._curInfoMo = nil
end

function PetEquipController:_tickDailyRefreshData()
	if ViewMgr.instance:isOpen(ViewName.EquipFactory) then
		self:csGetComposeTimesReq()
	end
end

function PetEquipController:mergeStrengthenEquipList(infoMo, sifterList, isFill)
	if infoMo == nil then
		return
	end

	local list = PetEquipModel.instance:getStrengthenMaterials(infoMo, sifterList)

	if not isFill then
		return list
	end

	if list then
		if not #list then
			local count = 0

			if count == 0 then
				return {}
			end

			if count >= 25 then
				return list
			end

			list = list or {}

			for i = count + 1, 25 do
				list[i] = {
					isEmpty = true
				}
			end

			return list
		end
	end
end

function PetEquipController:GetQualityStrByNum(num, isDark)
	local nameStr = "白色"
	local colorStr = isDark and "b8c8e8" or "ffffff"

	if num == 1 then
		nameStr = "绿色"
		colorStr = isDark and "6fdcc1" or "11A568FF"
	elseif num == 2 then
		nameStr = "蓝色"
		colorStr = isDark and "5da9f0" or "08A0D8FF"
	elseif num == 3 then
		nameStr = "紫色"
		colorStr = isDark and "d3b2f4" or "DF4DFFFF"
	elseif num == 4 then
		nameStr = "橙色"
		colorStr = isDark and "ebd84f" or "D56D08FF"
	elseif num == 5 then
		nameStr = "红色"
		colorStr = isDark and "f07f5e" or "eb4642"
	end

	nameStr = nameStr .. "品质"
	colorStr = "#" .. colorStr

	return nameStr, colorStr
end

function PetEquipController:setEquipFunctionTabIndex(index)
	self._openTabIndex = index
end

function PetEquipController:getEquipFunctionTabIndex()
	return math.max(checknumber(self._openTabIndex), 1)
end

function PetEquipController:setCurrentEquipInfoMo(mo)
	self._curInfoMo = mo
end

function PetEquipController:getCurrentEquipInfoMo()
	return self._curInfoMo
end

function PetEquipController:GetPetAllEquipRedPoint(petId, redType)
	if self:IsPetShangezhenAndZhihe(petId) then
		redType = redType or PetEquipModel.PetEquipRedType.Wear

		return PetEquipModel.instance:GetPetCardRedPoint(petId, redType)
	end
end

function PetEquipController:GetPetEquipPosRedPoint(petId, pos, redType)
	if self:IsPetShangezhenAndZhihe(petId) then
		redType = redType or PetEquipModel.PetEquipRedType.Wear

		return PetEquipModel.instance:GetPetEquipPosRedPoint(petId, pos, redType)
	end
end

function PetEquipController:IsPetShangezhenAndZhihe(petId)
	local cfg = FuncOpenConfig.instance:getFunctionOpenById(50)

	if cfg == nil or not FuncOpenController.instance:getConditionReached(cfg.openCondition, cfg.openTime) then
		return
	end

	petId = petId or BagPetsController.instance:GetCurPetId()

	return FormationGroupModel.instance:checkIsInTeam(petId)
end

function PetEquipController:GetPlayAndSlotPetRed()
	local cfg = FuncOpenConfig.instance:getFunctionOpenById(50)

	if cfg == nil or not FuncOpenController.instance:getConditionReached(cfg.openCondition, cfg.openTime) then
		return
	end

	local petIds = FormationNewModel.instance:getHasPets()

	for _, petId in ipairs(petIds) do
		if BagModel.instance:getPetTalentStatus(petId) or PetEquipModel.instance:GetPetCardRedPoint(petId, PetEquipModel.PetEquipRedType.Wear) then
			return true
		end
	end

	petIds = nil

	local slotInfos = PowerCrystalModel.instance:getSlotInfos()

	for _, info in ipairs(slotInfos) do
		local id = checknumber(info.petId)

		if id > 0 and BagModel.instance:getPetTalentStatus(id) or PetEquipModel.instance:GetPetCardRedPoint(id, PetEquipModel.PetEquipRedType.Wear) then
			return true
		end
	end
end

function PetEquipController:GetPetDecorationRedPoint(petInfo)
	if petInfo == nil then
		return false
	end

	if self:IsPetShangezhenAndZhihe(petInfo.petId) then
		return PetEquipModel.instance:IsHaveBestDecoration(petInfo)
	end
end

function PetEquipController:CSLoadAllEquipmentsReq()
	self.isEquipInit = false

	EquipmentAgent.instance:sendEQM_LoadAllEquipmentsReq()
end

function PetEquipController:SCLoadAllEquipmentsInfo(msg)
	PetEquipModel.instance.equipRecycleQua = msg.autoDecomposeQuality

	PetEquipModel.instance:SynchronizationAllEquipInfo(msg.allEquipments, true)

	self.isEquipInit = true

	self:_updateEquipRecycleRed()
end

function PetEquipController:CSWearOneEquipReq(petId, equipmentId)
	EquipmentAgent.instance:sendEQM_EquipReq(petId, equipmentId)
end

function PetEquipController:SCWearOneEquip(msg)
	return
end

function PetEquipController:CSUnloadOneEquipReq(petId, equipmentId)
	EquipmentAgent.instance:sendEQM_UnloadReq(petId, equipmentId)
end

function PetEquipController:SCUnloadOneEquip(msg)
	return
end

function PetEquipController:CSOneKeyWearEquipReq(petId, equipIds, dectId)
	local req = EquipmentExtension_pb.EQM_OneKeyEquipReq()

	for i = 1, #equipIds do
		req.equipmentIds:append(equipIds[i])
	end

	EquipmentAgent.instance:sendEQM_OneKeyEquipReq(petId, req.equipmentIds, dectId)
end

function PetEquipController:SCOneKeyWearEquip(msg)
	return
end

function PetEquipController:CSOneKeyUnloadEquipReq(petIdList)
	EquipmentAgent.instance:sendEQM_OneKeyUnloadReq(petIdList)
end

function PetEquipController:SCOneKeyUnloadEquip(msg)
	return
end

function PetEquipController:SCEquipInfoChange(msg)
	local changes = msg.changes

	if changes == nil or #changes == 0 then
		return
	end

	PetEquipModel.instance:SynchronizationAllEquipInfo(changes)
end

function PetEquipController:CSStrengthenEquipReq(equipId, equIds, matIds)
	local req = EquipmentExtension_pb.EQM_UpgradeReq()
	local arr = {}

	if matIds and #matIds > 0 then
		for i = 1, #matIds do
			local usingMaterials = req.usingMaterials:add()

			usingMaterials.id = matIds[i].id
			usingMaterials.num = matIds[i].num

			table.insert(arr, usingMaterials)
		end
	end

	EquipmentAgent.instance:sendEQM_UpgradeReq(equipId, equIds, arr)
end

function PetEquipController:SCEquipInfoUpgrade(msg)
	local info = PetEquipModel.instance:GetCurrentUpgradeInfo()

	if info and info.matType == MatType.Equipment then
		local nowInfo = PetEquipModel.instance:GetEquipInfo(info.onlyId)

		if nowInfo then
			BagPetsController.instance:updatePetEquipAttrById(nowInfo.equipPetId)

			if nowInfo.starCount > info.starCount then
				UIStateManager.instance:open(ViewName.PetEquipUpgrade, nowInfo)
			end
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.PET_EQUIP_UPGRADE)
end

function PetEquipController:CSDelectAllEquipInfo()
	GMAgent.instance:sendPM_DeleteAllEquipmentsReq()
end

function PetEquipController:CSEquipTupoReq(leftInfoMo, otherIds, stoneId)
	if leftInfoMo == nil then
		return
	end

	local req = EquipmentExtension_pb.EQM_BreakoutReq()

	for i = 1, #otherIds do
		req.otherEquipmentIds:append(otherIds[i])
	end

	local arr = {}

	if checknumber(stoneId) > 0 then
		local usingMaterials = req.usingMaterials:add()

		usingMaterials.id = stoneId
		usingMaterials.num = 1

		table.insert(arr, usingMaterials)
	end

	local oldInfoMo = PetEquipModel.instance:GetTemporaryEquip(leftInfoMo.baseId, leftInfoMo.starCount, nil)

	EquipmentAgent.instance:sendEQM_BreakoutReq(leftInfoMo.onlyId, req.otherEquipmentIds, arr, function(msg)
		if msg and checknumber(msg.defineId) > 0 then
			local newInfoMo = PetEquipModel.instance:GetTemporaryEquip(msg.defineId, 0, nil)

			UIStateManager.instance:push(ViewName.TupoUpgrade, oldInfoMo, newInfoMo)

			local newEquipInfo = PetEquipModel.instance:GetEquipInfo(msg.newEquipmentId)

			GlobalDispatcher:dispatch("UpdataEquipTupoUpgrade", newEquipInfo)
		end
	end)
end

function PetEquipController:CSComposeEquipmentReq(alchemyType, costQua, onlyIds, times, choiceId)
	if alchemyType == PetEquipModel.AlchemyType.Equip then
		local req = EquipmentComposeExtension_pb.PM_ComposeEquipmentReq()

		for i = 1, #onlyIds do
			req.equipmentIds:append(onlyIds[i])
		end

		EquipmentComposeAgent.instance:sendPM_ComposeEquipmentReq(alchemyType, costQua, req.equipmentIds, times, choiceId, function()
			PetEquipModel.instance:setEquipFactoryCount(alchemyType, costQua)
			GlobalDispatcher:dispatch(GlobalNotify.Factory_UpdataShowInfo, PetEquipModel.AlchemyType.Equip)
		end)
	elseif alchemyType == PetEquipModel.AlchemyType.Artifact then
		local req = EquipmentComposeExtension_pb.PM_ComposeThroneReq()

		for i = 1, #onlyIds do
			req.throneIds:append(onlyIds[i])
		end

		EquipmentComposeAgent.instance:sendPM_ComposeThroneReq(alchemyType, costQua, req.throneIds, times, choiceId, function()
			PetEquipModel.instance:setEquipFactoryCount(alchemyType, costQua)
			GlobalDispatcher:dispatch(GlobalNotify.Factory_UpdataShowInfo, PetEquipModel.AlchemyType.Artifact)
		end)
	elseif alchemyType == PetEquipModel.AlchemyType.StarGod then
		local req = EquipmentComposeExtension_pb.PM_ComposeStarGodFillerReq()

		for i = 1, #onlyIds do
			req.fillerIds:append(onlyIds[i])
		end

		EquipmentComposeAgent.instance:sendPM_ComposeStarGodFillerReq(alchemyType, costQua, req.fillerIds, choiceId, times, function()
			PetEquipModel.instance:setEquipFactoryCount(alchemyType, costQua)
			GlobalDispatcher:dispatch(GlobalNotify.Factory_UpdataShowInfo, PetEquipModel.AlchemyType.StarGod)
		end)
	end
end

function PetEquipController:CSDecompseEquipmentReq(onlyIds)
	local req = EquipmentComposeExtension_pb.PM_DecompseEquipmentReq()

	for i = 1, #onlyIds do
		req.equipmentIds:append(onlyIds[i])
	end

	EquipmentComposeAgent.instance:sendPM_DecompseEquipmentReq(req.equipmentIds, function()
		GlobalDispatcher:dispatch("UpdataEquipRecycleShow")
	end)
end

function PetEquipController:csGetComposeTimesReq()
	EquipmentComposeAgent.instance:sendPM_GetComposeTimesReq()
end

function PetEquipController:scSendComposeTimes(msg)
	PetEquipModel.instance:scSendComposeTimes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.Factory_UpdataShowCount)
end

function PetEquipController:_updateEquipRecycleRed()
	if PetEquipModel.instance.equipRecycleQua ~= nil and PetEquipModel.instance.equipRecycleQua ~= -1 and FuncOpenController.instance:checkFuncIdOrShowLockTips(660) or false then
		RedPointController.instance:regUserMoonRedPoint(RedPointModel.ID_EQUIPRECYCLE)
	else
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_EQUIPRECYCLE, false)
	end
end

function PetEquipController:CSLoadAllDecorationReq()
	DecorationAgent.instance:sendPM_LoadAllDecorationReq()
end

function PetEquipController:SCLoadAllDecoration(msg)
	PetEquipModel.instance:SetAllDecorationInfo(msg.decorations, true)
	BagPetsController.instance:calcAllDecorationAttr()
end

function PetEquipController:CSWearDecorationReq(petId, decorationId)
	DecorationAgent.instance:sendPM_EquipDecorationReq(decorationId, petId)
end

function PetEquipController:SCWearDecoration(msg)
	return
end

function PetEquipController:CSUnloadDecorationReq(petId, decorationId)
	DecorationAgent.instance:sendPM_UnloadDecorationReq(decorationId, petId)
end

function PetEquipController:SCUnloadDecoration(msg)
	return
end

function PetEquipController:CSStrengthenDecorationReq(decorationId, decIds, matIds)
	local req = DecorationExtension_pb.PM_UpgradeDecorationReq()
	local arr = {}

	if matIds and #matIds > 0 then
		for i = 1, #matIds do
			local usedMaterials = req.usedMaterials:add()

			usedMaterials.id = matIds[i].id
			usedMaterials.num = matIds[i].num

			table.insert(arr, usedMaterials)
		end
	end

	DecorationAgent.instance:sendPM_UpgradeDecorationReq(decorationId, decIds, arr)
end

function PetEquipController:SCUpgradeDecoration(msg)
	local info = PetEquipModel.instance:GetCurrentUpgradeInfo()

	if info and info.matType == MatType.Decoration then
		local nowInfo = PetEquipModel.instance:GetDecorationInfoByOnlyId(info.onlyId)

		if nowInfo then
			if nowInfo.starCount > info.starCount then
				UIStateManager.instance:open(ViewName.PetDectnUpgrade, info)
			end

			if nowInfo.equipPetId > 0 then
				BagPetsController.instance:updateDecorationAttrById(nowInfo.equipPetId)
			end
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.PET_EQUIP_UPGRADE)
end

function PetEquipController:SCDecorationInfoChange(msg)
	if msg == nil or msg.changedDecorations == nil then
		return
	end

	local changes = msg.changedDecorations

	if #changes == 0 then
		return
	end

	PetEquipModel.instance:SetAllDecorationInfo(changes)
end

function PetEquipController:CSDecompseDecorationReq(onlyIds)
	local req = DecorationExtension_pb.PM_DecomposeDecorationReq()

	for i = 1, #onlyIds do
		req.decorationIds:append(onlyIds[i])
	end

	DecorationAgent.instance:sendPM_DecomposeDecorationReq(req.decorationIds, function()
		GlobalDispatcher:dispatch("UpdataEquipRecycleShow")
	end)
end

function PetEquipController:CSGetPetCommentInfo(raceId)
	self.isWaiting = true

	PetCommentAgent.instance:sendPM_PetCommentUserInfoReq(raceId)
end

function PetEquipController:SCGetPetCommentInfo(msg)
	self.isWaiting = false

	local isOK = PetEquipModel.instance:SetPinglunPetInfo(msg)

	if isOK then
		self:CSGetPinglunInfoList(msg.raceId)
	end
end

function PetEquipController:CSGetPinglunInfoList(raceId)
	self.isWaiting = true

	PetCommentAgent.instance:sendPM_PetCommentInfoReq(raceId)
end

function PetEquipController:SCPinglunInfoList(msg)
	self.isWaiting = false

	PetEquipModel.instance:SetPinglunInfoList(msg)
end

function PetEquipController:CSGiveRoleDianzan(raceId, plId)
	self.isWaiting = true

	PetCommentAgent.instance:sendPM_PetCommentLikeReq(raceId, plId)
end

function PetEquipController:SCGiveRoleDianzan(msg)
	self.isWaiting = false

	PetEquipModel.instance:SetPinglunDianzan(msg.raceId, msg.commentId)
end

function PetEquipController:CSPinglunPetContent(raceId, str)
	self.isWaiting = true

	PetCommentAgent.instance:sendPM_SendPetCommentReq(raceId, str)
end

function PetEquipController:SCPinglunPetContent(msg)
	self.isWaiting = false

	PetEquipModel.instance:SetOwnPinglunInfo(msg)
end

function PetEquipController:CSJubaoRoleComment(raceId, plId, index, str)
	self.isWaiting = true

	PetCommentAgent.instance:sendPM_PetCommentReportReq(raceId, plId, index, str)
end

function PetEquipController:SCJubaoRoleComment(msg)
	self.isWaiting = false
end

function PetEquipController:getPetIdForEquipLevelUp()
	local petsMo = {}
	local petIdsInFormation = FormationNewModel.instance:getHasPets()

	for i, petId in ipairs(petIdsInFormation) do
		local isLevelUp = self:GetPetAllEquipRedPoint(petId, PetEquipModel.PetEquipRedType.Strengthen)

		if isLevelUp then
			table.insert(petsMo, BagPetsController.instance:getPet(petId))
		end
	end

	if #petsMo > 0 then
		BagModel.instance:sortPetForTaskGuide(petsMo)

		return petsMo[1]:getPetId()
	end

	local petMos = BagModel.instance:getBagPets()

	for k, v in pairs(petMos) do
		local petId = v:getPetId()
		local isLevelUp = self:GetPetAllEquipRedPoint(petId, PetEquipModel.PetEquipRedType.Strengthen)

		if isLevelUp then
			table.insert(petsMo, v)
		end
	end

	if #petsMo > 0 then
		BagModel.instance:sortPetForTaskGuide(petsMo)

		return petsMo[1]:getPetId()
	end

	return nil
end

function PetEquipController:sendEQM_BatchBreakoutReq(infoList)
	local list = {}

	for i, v in ipairs(infoList) do
		local info = EquipmentExtension_pb.EQM_BreakoutInfo()

		info.mainEquipmentId = v.mainEquipmentId

		for j, id in ipairs(v.otherEquipmentIds) do
			info.otherEquipmentIds:append(id)
		end

		for j, matInfo in ipairs(v.matList) do
			if matInfo.num > 0 then
				local item = MaterialExtension_pb.MaterialItemNO()

				item.id = matInfo.id
				item.num = matInfo.num

				local mat = info.usingMaterials:add()

				mat:ParseFromString(item:SerializeToString())
			end
		end

		info.upgradeAfterBreakout = v.upgradeAfterBreakout

		table.insert(list, info)
	end

	EquipmentAgent.instance:sendEQM_BatchBreakoutReq(list)
end

function PetEquipController:handleEQM_BatchBreakoutRes(msg)
	local infos = {}
	local info = {}

	info.items = {}
	info.materialType = MatType.Equipment

	for i, v in ipairs(msg.resultList) do
		local equipMo = PetEquipModel.instance:GetInfoMoByOnlyId(v.newEquipmentId, MatType.Equipment)

		if equipMo then
			equipMo.haveAllExp = v.newEquipmentExp

			equipMo:CalculationEquipAttrInfo()
			table.insert(info.items, {
				num = 1,
				id = v.newEquipmentId
			})
		end
	end

	table.insert(infos, info)

	if msg.changeSetId then
		MaterialModel.instance:addChangeSetItems(msg.changeSetId, infos)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		MaterialController.instance:setChangeSetPopup(msg.changeSetId, MaterialController.CI_SHOW_TYPE_POPUP)
		MaterialController.instance:showChangeSetInTemp(msg.changeSetId)
	end

	FloatWordMgr.instance:show(lang("一键操作成功"))
	GlobalDispatcher:dispatch(GlobalNotify.EQM_BatchBreakoutRes)
end

PetEquipController.instance = PetEquipController.New()

return PetEquipController
