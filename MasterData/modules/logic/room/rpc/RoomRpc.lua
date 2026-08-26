-- chunkname: @modules/logic/room/rpc/RoomRpc.lua

module("modules.logic.room.rpc.RoomRpc", package.seeall)

local RoomRpc = class("RoomRpc", BaseRpc)

RoomRpc.GainProductionLineRequest = -29380

function RoomRpc:sendGetRoomInfoRequest(callback, callbackObj)
	local req = RoomModule_pb.GetRoomInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveGetRoomInfoReply(resultCode, msg)
	if resultCode == 0 then
		RoomModel.instance:setEditInfo(msg)
	end
end

function RoomRpc:sendUseBlockRequest(blockId, packageId, rotate, x, y, callback, callbackObj)
	local req = RoomModule_pb.UseBlockRequest()

	req.blockId = blockId
	req.blockPackageId = packageId
	req.rotate = rotate
	req.x = x
	req.y = y

	return self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveUseBlockReply(resultCode, msg)
	if resultCode == 0 then
		RoomMapController.instance:useBlockReply(msg)
		RoomStatController.instance:blockOp({
			msg.blockId
		}, true)
	end
end

function RoomRpc:sendUnUseBlockRequest(blockIds, callback, callbackObj)
	local req = RoomModule_pb.UnUseBlockRequest()

	for i = 1, #blockIds do
		table.insert(req.blockIds, blockIds[i])
	end

	return self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveUnUseBlockReply(resultCode, msg)
	if resultCode == 0 then
		RoomMapController.instance:unUseBlockReply(msg)
		RoomStatController.instance:blockOp(msg.blockIds, false)
	end
end

function RoomRpc:sendGetBlockPackageInfoRequset(callback, callbackObj)
	local req = RoomModule_pb.GetBlockPackageInfoRequset()

	return self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveGetBlockPackageInfoReply(resultCode, msg)
	if resultCode == 0 then
		RoomController.instance:getBlockPackageInfoReply(msg)
	end
end

function RoomRpc:onReceiveBlockPackageGainPush(resultCode, msg)
	if resultCode == 0 then
		RoomController.instance:blockPackageGainPush(msg)
		RoomMapController.instance:dispatchEvent(RoomEvent.NewBlockPackagePush)
	end
end

function RoomRpc:onReceiveGainSpecialBlockPush(resultCode, msg)
	if resultCode == 0 then
		RoomController.instance:gainSpecialBlockPush(msg)
	end
end

function RoomRpc:sendGetBuildingInfoRequest(callback, callbackObj)
	local req = RoomModule_pb.GetBuildingInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveGetBuildingInfoReply(resultCode, msg)
	if resultCode == 0 then
		RoomController.instance:getBuildingInfoReply(msg)
	end
end

function RoomRpc:sendResetRoomRequest(callback, callbackObj)
	local req = RoomModule_pb.ResetRoomRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveResetRoomReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function RoomRpc:onReceiveBuildingGainPush(resultCode, msg)
	if resultCode == 0 then
		RoomModel.instance:updateBuildingInfos(msg.buildingInfos)
		RoomInventoryBuildingModel.instance:addBuilding(msg.buildingInfos)
		RoomMapController.instance:buildingLevelUpByInfos(msg.buildingInfos)
		RoomMapController.instance:dispatchEvent(RoomEvent.NewBuildingPush)
	end
end

function RoomRpc:sendUseBuildingRequest(buildingUid, rotate, x, y, callback, callbackObj)
	local req = RoomModule_pb.UseBuildingRequest()

	req.uid = buildingUid
	req.rotate = rotate
	req.x = x
	req.y = y

	return self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveUseBuildingReply(resultCode, msg)
	if resultCode == 0 then
		RoomModel.instance:updateBuildingInfos({
			msg.buildingInfo
		})
		RoomMapController.instance:useBuildingReply(msg)
		RoomMapController.instance:dispatchEvent(RoomEvent.UseBuildingReply)
	end
end

function RoomRpc:sendUnUseBuildingRequest(buildingUid, callback, callbackObj)
	local req = RoomModule_pb.UnUseBuildingRequest()

	req.uid = buildingUid

	return self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveUnUseBuildingReply(resultCode, msg)
	if resultCode == 0 then
		RoomModel.instance:updateBuildingInfos(msg.buildingInfos)
		RoomMapController.instance:unUseBuildingReply(msg)
	end
end

function RoomRpc:sendGetRoomObInfoRequest(needBlockData, callback, callbackObj)
	local req = RoomModule_pb.GetRoomObInfoRequest()

	req.needBlockData = needBlockData

	return self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveGetRoomObInfoReply(resultCode, msg)
	if resultCode == 0 then
		RoomModel.instance:updateRoomLevel(msg.roomLevel)
		RoomModel.instance:updateBuildingInfos(msg.buildingInfos)
		RoomModel.instance:setFormulaInfos(msg.formulaInfos)
		RoomModel.instance:setGetThemeRewardIds(msg.hasGetRoomThemes)

		if msg.needBlockData == true then
			local info = RoomLayoutHelper.createInfoByObInfo(msg)

			info.id = RoomEnum.LayoutUsedPlanId

			RoomLayoutModel.instance:updateRoomPlanInfoReply(info)
			RoomModel.instance:setCharacterList(msg.roomHeroDatas)
		end

		RoomProductionModel.instance:updateProductionLines(msg.productionLines)
		RoomSkinModel.instance:updateRoomSkinInfo(msg.skins, true)
	end
end

function RoomRpc:sendRoomConfirmRequest(callback, callbackObj)
	local req = RoomModule_pb.RoomConfirmRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveRoomConfirmReply(resultCode, msg)
	return
end

function RoomRpc:sendRoomRevertRequest(callback, callbackObj)
	local req = RoomModule_pb.RoomRevertRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveRoomRevertReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function RoomRpc:onReceiveFormulaGainPush(resultCode, msg)
	if resultCode == 0 then
		RoomModel.instance:addFormulaInfos(msg.formulaInfos)
		RoomFormulaModel.instance:addFormulaList(msg.formulaInfos)
		RoomBuildingController.instance:dispatchEvent(RoomEvent.NewFormulaPush)
	end
end

function RoomRpc:sendBuildingChangeLevelRequest(buildingUid, levels, callback, callbackObj)
	local req = RoomModule_pb.BuildingChangeLevelRequest()

	req.buildingUid = buildingUid

	for i, level in ipairs(levels) do
		table.insert(req.levels, level)
	end

	return self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveBuildingChangeLevelReply(resultCode, msg)
	if resultCode == 0 then
		RoomMapBuildingModel.instance:updateBuildingLevels(msg.buildingUid, msg.levels)
		RoomResourceModel.instance:clearResourceAreaList()
		RoomBuildingController.instance:dispatchEvent(RoomEvent.UpdateBuildingLevels, msg.buildingUid)
	end
end

function RoomRpc:sendRoomAccelerateRequest(buildingUid, useItemCount, slot, callback, callbackObj)
	local req = RoomModule_pb.RoomAccelerateRequest()

	req.buildingUid = buildingUid
	req.useItemCount = useItemCount
	req.slot = slot or 0

	return self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveRoomAccelerateReply(resultCode, msg)
	if resultCode == 0 then
		RoomBuildingController.instance:dispatchEvent(RoomEvent.AccelerateSuccess)
	end
end

function RoomRpc:sendGetOtherRoomObInfoRequest(targetUid, callback, callbackObj)
	local req = RoomModule_pb.GetOtherRoomObInfoRequest()

	req.targetUid = targetUid

	return self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveGetOtherRoomObInfoReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function RoomRpc:sendRoomLevelUpRequest(callback, callbackObj)
	RoomMapModel.instance:setRoomLeveling(true)

	local req = RoomModule_pb.RoomLevelUpRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveRoomLevelUpReply(resultCode, msg)
	if resultCode == 0 then
		RoomModel.instance:updateRoomLevel(msg.roomLevel)
		RoomMapModel.instance:updateRoomLevel(msg.roomLevel)
		RoomProductionModel.instance:checkUnlockLine(msg.roomLevel)
		RoomProductionModel.instance:updateProductionLines(msg.productionLines)
		RoomProductionModel.instance:updateLineMaxLevel()
		RoomMapController.instance:dispatchEvent(RoomEvent.UpdateRoomLevel)
	end

	RoomMapModel.instance:setRoomLeveling(false)
end

function RoomRpc:sendStartProductionLineRequest(id, formulaList, costMaterialList, cb, cbObj)
	local req = RoomModule_pb.StartProductionLineRequest()

	req.id = id

	for _, formulaItem in ipairs(formulaList) do
		local formulaProduce = RoomModule_pb.FormulaProduce()

		formulaProduce.formulaId = formulaItem.formulaId
		formulaProduce.count = formulaItem.count

		table.insert(req.formulaProduce, formulaProduce)
	end

	if costMaterialList then
		for _, costMaterial in ipairs(costMaterialList) do
			local materialData = MaterialModule_pb.MaterialData()

			materialData.materilType = costMaterial.type
			materialData.materilId = costMaterial.id
			materialData.quantity = costMaterial.quantity

			table.insert(req.costCheck, materialData)
		end
	end

	return self:sendMsg(req, cb, cbObj)
end

function RoomRpc:onReceiveStartProductionLineReply(resultCode, msg)
	RoomController.instance:dispatchEvent(RoomEvent.StartProductionLineReply, resultCode, msg)
end

function RoomRpc:sendProductionLineInfoRequest(ids, callback, callbackObj)
	local req = RoomModule_pb.ProductionLineInfoRequest()

	if ids ~= nil then
		for i, id in ipairs(ids) do
			table.insert(req.ids, id)
		end
	end

	return self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveProductionLineInfoReply(resultCode, msg)
	if resultCode == 0 then
		RoomProductionModel.instance:updateProductionLines(msg.productionLines)
	end
end

function RoomRpc:sendGainProductionLineRequest(ids, ignoreBlock)
	local req = RoomModule_pb.GainProductionLineRequest()

	if ids ~= nil then
		for i, id in ipairs(ids) do
			table.insert(req.ids, id)
		end
	end

	ignoreBlock = ignoreBlock or false
	GameMsgLockState.IgnoreCmds[RoomRpc.GainProductionLineRequest] = ignoreBlock

	return self:sendMsg(req)
end

function RoomRpc:onReceiveGainProductionLineReply(resultCode, msg)
	local lineIds

	if resultCode == 0 then
		lineIds = {}

		local lineInfos = msg.productionLines

		RoomProductionModel.instance:updateProductionLines(lineInfos)

		for _, productionLine in ipairs(lineInfos) do
			if productionLine.id ~= 0 then
				table.insert(lineIds, productionLine.id)
			end
		end
	end

	RoomController.instance:dispatchEvent(RoomEvent.GainProductionLineReply, resultCode, lineIds)
end

function RoomRpc:sendProductionLineLvUpRequest(id, newLevel, callback, callbackObj)
	local req = RoomModule_pb.ProductionLineLvUpRequest()

	req.id = id
	req.newLevel = newLevel

	return self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveProductionLineLvUpReply(resultCode, msg)
	if resultCode == 0 then
		RoomProductionModel.instance:updateProductionLines({
			msg.productionLine
		})
		RoomController.instance:dispatchEvent(RoomEvent.ProduceLineLevelUp)
	end
end

function RoomRpc:sendProductionLineAccelerateRequest(id, useItemCount, callback, callbackObj)
	local req = RoomModule_pb.ProductionLineAccelerateRequest()

	req.id = id
	req.useItemCount = useItemCount

	return self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveProductionLineAccelerateReply(resultCode, msg)
	if resultCode == 0 then
		RoomProductionModel.instance:updateProductionLines({
			msg.productionLine
		})
	end
end

function RoomRpc:sendUpdateRoomHeroDataRequest(roomHeroIds, callback, callbackObj)
	local req = RoomModule_pb.UpdateRoomHeroDataRequest()

	for i, roomHeroId in ipairs(roomHeroIds) do
		table.insert(req.roomHeroIds, roomHeroId)
	end

	return self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveUpdateRoomHeroDataReply(resultCode, msg)
	if resultCode == 0 then
		RoomModel.instance:setCharacterList(msg.roomHeroDatas)
	end
end

function RoomRpc:sendGainRoomHeroFaithRequest(heroIds, callback, callbackObj)
	local req = RoomModule_pb.GainRoomHeroFaithRequest()

	if heroIds then
		for i, heroId in ipairs(heroIds) do
			table.insert(req.heroIds, heroId)
		end
	end

	return self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveGainRoomHeroFaithReply(resultCode, msg)
	if resultCode == 0 then
		RoomCharacterController.instance:updateCharacterFaith(msg.roomHeroDatas)
		RoomCharacterController.instance:playCharacterFaithEffect(msg.roomHeroDatas)
	end
end

function RoomRpc:sendHideBuildingReddotRequset(buildingId)
	local req = RoomModule_pb.HideBuildingReddotRequset()

	req.id = buildingId

	return self:sendMsg(req)
end

function RoomRpc:onReceiveHideBuildingReddotReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function RoomRpc:sendHideBlockPackageReddotRequest(blockPackageId)
	local req = RoomModule_pb.HideBlockPackageReddotRequest()

	req.id = blockPackageId

	return self:sendMsg(req)
end

function RoomRpc:onReceiveHideBlockPackageReddotReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function RoomRpc:sendStartCharacterInteractionRequest(id, callback, callbackObj)
	local req = RoomModule_pb.StartCharacterInteractionRequest()

	req.id = id

	return self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveStartCharacterInteractionReply(resultCode, msg)
	if resultCode == 0 then
		RoomModel.instance:interactStart(msg.id)
	end
end

function RoomRpc:sendGetCharacterInteractionBonusRequest(id, selectIds)
	local req = RoomModule_pb.GetCharacterInteractionBonusRequest()

	req.id = id

	if selectIds then
		for i, selectId in ipairs(selectIds) do
			table.insert(req.selectIds, selectId)
		end
	end

	return self:sendMsg(req)
end

function RoomRpc:onReceiveGetCharacterInteractionBonusReply(resultCode, msg)
	if resultCode == 0 then
		RoomModel.instance:interactComplete(msg.id)
	end
end

function RoomRpc:sendGetCharacterInteractionInfoRequest(callback, callbackObj)
	local req = RoomModule_pb.GetCharacterInteractionInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveGetCharacterInteractionInfoReply(resultCode, msg)
	if resultCode == 0 then
		RoomModel.instance:updateInteraction(msg)
	end
end

function RoomRpc:sendGetRoomThemeCollectionBonusRequest(themeId)
	local req = RoomModule_pb.GetRoomThemeCollectionBonusRequest()

	req.id = themeId

	return self:sendMsg(req)
end

function RoomRpc:onReceiveGetRoomThemeCollectionBonusReply(resultCode, msg)
	if resultCode == 0 then
		RoomController.instance:getRoomThemeCollectionBonusReply(msg)
	end
end

function RoomRpc:sendGetRoomPlanInfoRequest(callback, callbackObj)
	local req = RoomModule_pb.GetRoomPlanInfoRequest()

	self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveGetRoomPlanInfoReply(resultCode, msg)
	if resultCode == 0 then
		RoomLayoutController.instance:getRoomPlanInfoReply(msg)
	end
end

function RoomRpc:sendGetRoomPlanDetailsRequest(planId)
	local req = RoomModule_pb.GetRoomPlanDetailsRequest()

	req.id = planId

	self:sendMsg(req)
end

function RoomRpc:onReceiveGetRoomPlanDetailsReply(resultCode, msg)
	if resultCode == 0 then
		RoomLayoutController.instance:getRoomPlanDestailsReply(msg)
	end
end

function RoomRpc:sendSetRoomPlanRequest(planId, coverId, name)
	local req = RoomModule_pb.SetRoomPlanRequest()

	req.id = planId
	req.coverId = coverId or 1
	req.name = name or ""

	self:sendMsg(req)
end

function RoomRpc:onReceiveSetRoomPlanReply(resultCode, msg)
	if resultCode == 0 then
		RoomLayoutController.instance:setRoomPlanReply(msg)
	end
end

function RoomRpc:sendSetRoomPlanNameRequest(planId, planName, callback, callbackObj)
	local req = RoomModule_pb.SetRoomPlanNameRequest()

	req.id = planId
	req.name = planName

	self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveSetRoomPlanNameReply(resultCode, msg)
	if resultCode == 0 then
		RoomLayoutController.instance:setRoomPlanNameReply(msg)
	end
end

function RoomRpc:sendSetRoomPlanCoverRequest(planId, coverId)
	local req = RoomModule_pb.SetRoomPlanCoverRequest()

	req.id = planId
	req.coverId = coverId

	self:sendMsg(req)
end

function RoomRpc:onReceiveSetRoomPlanCoverReply(resultCode, msg)
	if resultCode == 0 then
		RoomLayoutController.instance:setRoomPlanCoverReply(msg)
	end
end

function RoomRpc:sendUseRoomPlanRequest(planId)
	local req = RoomModule_pb.UseRoomPlanRequest()

	req.id = planId

	self:sendMsg(req)
end

function RoomRpc:onReceiveUseRoomPlanReply(resultCode, msg)
	if resultCode == 0 then
		RoomLayoutController.instance:useRoomPlanReply(msg)
	end
end

function RoomRpc:sendSwitchRoomPlanRequest(planAId, planBId, callback, callbackObj)
	local req = RoomModule_pb.SwitchRoomPlanRequest()

	req.idA = planAId
	req.idB = planBId

	self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveSwitchRoomPlanReply(resultCode, msg)
	if resultCode == 0 then
		RoomLayoutController.instance:switchRoomPlanReply(msg)
	end
end

function RoomRpc:sendDeleteRoomPlanRequest(planId)
	local req = RoomModule_pb.DeleteRoomPlanRequest()

	req.id = planId

	self:sendMsg(req)
end

function RoomRpc:onReceiveDeleteRoomPlanReply(resultCode, msg)
	if resultCode == 0 then
		RoomLayoutController.instance:deleteRoomPlanReply(msg)
	end
end

function RoomRpc:sendCopyOtherRoomPlanRequest(targetUid, planId, coverId, name, callback, callbackObj)
	local req = RoomModule_pb.CopyOtherRoomPlanRequest()

	req.targetUid = targetUid
	req.id = planId
	req.coverId = coverId
	req.name = name

	self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveCopyOtherRoomPlanReply(resultCode, msg)
	if resultCode == 0 then
		RoomLayoutController.instance:copyOtherRoomPlanReply(msg)
	end
end

function RoomRpc:sendGetRoomShareRequest(shareCode, callback, callbackObj)
	local req = RoomModule_pb.GetRoomShareRequest()

	req.shareCode = shareCode

	self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveGetRoomShareReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function RoomRpc:sendUseRoomShareRequest(shareCode, planId, coverId, name, callback, callbackObj)
	local req = RoomModule_pb.UseRoomShareRequest()

	req.shareCode = shareCode
	req.id = planId
	req.coverId = coverId
	req.name = name

	self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveUseRoomShareReply(resultCode, msg)
	if resultCode == 0 then
		RoomLayoutController.instance:useRoomShareReply(msg)
	end
end

function RoomRpc:sendShareRoomPlanRequest(planId, callback, callbackObj)
	local req = RoomModule_pb.ShareRoomPlanRequest()

	req.id = planId

	self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveShareRoomPlanReply(resultCode, msg)
	if resultCode == 0 then
		RoomLayoutController.instance:shareRoomPlanReply(msg)
	end
end

function RoomRpc:sendDeleteRoomShareRequest(planId, callback, callbackObj)
	local req = RoomModule_pb.DeleteRoomShareRequest()

	req.id = planId

	self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveDeleteRoomShareReply(resultCode, msg)
	if resultCode == 0 then
		RoomLayoutController.instance:deleteRoomShareReply(msg)
	end
end

function RoomRpc:sendReportRoomRequest(reportedUserId, reportType, content, shareCode, callback, callbackObj)
	local req = RoomModule_pb.ReportRoomRequest()

	req.reportedUserId = reportedUserId
	req.reportType = reportType or ""
	req.content = content or ""
	req.shareCode = shareCode or ""

	self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveReportRoomReply(resultCode, msg)
	return
end

function RoomRpc:onReceiveBuildingLevelUpPush(resultCode, msg)
	if resultCode == 0 then
		RoomModel.instance:updateBuildingInfos(msg.buildingInfos)
		RoomInventoryBuildingModel.instance:addBuilding(msg.buildingInfos)
		RoomMapController.instance:buildingLevelUpByInfos(msg.buildingInfos, true)
	end
end

function RoomRpc:sendSetWaterTypeRequest(changeWaterTypeDict, cb, cbObj)
	if not changeWaterTypeDict then
		return
	end

	local req = RoomModule_pb.SetWaterTypeRequest()

	for blockId, waterType in pairs(changeWaterTypeDict) do
		local waterInfo = RoomModule_pb.WaterInfo()

		waterInfo.blockId = blockId
		waterInfo.waterType = waterType

		table.insert(req.waterInfos, waterInfo)
	end

	self:sendMsg(req, cb, cbObj)
end

function RoomRpc:onReceiveSetWaterTypeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local tmpBlockIdDict = {}
	local mapBlockMODict = RoomMapBlockModel.instance:getBlockMODict()

	for _, dict in pairs(mapBlockMODict) do
		for _, blockMO in pairs(dict) do
			tmpBlockIdDict[blockMO.id] = blockMO
		end
	end

	for _, blockInfo in ipairs(msg.infos) do
		local blockMO = tmpBlockIdDict[blockInfo.blockId]

		if blockMO then
			blockMO:setWaterType(blockInfo.waterType)
			blockMO:setTempWaterType()
		end
	end

	GameFacade.showToast(ToastEnum.WaterReformSuccess)
	RoomWaterReformController.instance:refreshSelectWaterBlockEntity()
	RoomWaterReformController.instance:dispatchEvent(RoomEvent.OnRoomBlockReform)
end

function RoomRpc:sendSetBlockColorRequest(changeBlockColorDict, cb, cbObj)
	if not changeBlockColorDict then
		return
	end

	local req = RoomModule_pb.SetBlockColorRequest()

	for blockId, blockColor in pairs(changeBlockColorDict) do
		local blockColorInfo = RoomModule_pb.BlockColorInfo()

		blockColorInfo.blockId = blockId
		blockColorInfo.blockColor = blockColor

		table.insert(req.blockColorInfos, blockColorInfo)
	end

	self:sendMsg(req, cb, cbObj)
end

function RoomRpc:onReceiveSetBlockColorReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local tmpBlockIdDict = {}
	local mapBlockMODict = RoomMapBlockModel.instance:getBlockMODict()

	for _, dict in pairs(mapBlockMODict) do
		for _, blockMO in pairs(dict) do
			tmpBlockIdDict[blockMO.id] = blockMO
		end
	end

	for _, blockInfo in ipairs(msg.infos) do
		local blockMO = tmpBlockIdDict[blockInfo.blockId]

		if blockMO then
			blockMO:setBlockColorType(blockInfo.blockColor)
			blockMO:setTempBlockColorType()
		end
	end

	GameFacade.showToast(ToastEnum.WaterReformSuccess)
	RoomWaterReformController.instance:refreshSelectedBlockEntity()
	RoomWaterReformController.instance:dispatchEvent(RoomEvent.OnRoomBlockReform)
end

function RoomRpc:sendSetRoomSkinRequest(partId, skinId, cb, cbObj)
	if not partId or not skinId then
		return
	end

	local req = RoomModule_pb.SetRoomSkinRequest()

	req.id = partId
	req.skinId = skinId

	self:sendMsg(req, cb, cbObj)
end

function RoomRpc:onReceiveSetRoomSkinReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local partId = msg.skin.id
	local skinId = msg.skin.skinId

	RoomSkinModel.instance:setRoomSkinEquipped(partId, skinId)
	RoomSkinController.instance:dispatchEvent(RoomSkinEvent.ChangeEquipRoomSkin)
end

function RoomRpc:sendReadRoomSkinRequest(skinId, cb, cbObj)
	if not skinId then
		return
	end

	local req = RoomModule_pb.ReadRoomSkinRequest()

	req.skinId = skinId

	self:sendMsg(req, cb, cbObj)
end

function RoomRpc:onReceiveReadRoomSkinReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoomSkinController.instance:dispatchEvent(RoomSkinEvent.RoomSkinMarkUpdate)
end

function RoomRpc:sendBuyManufactureBuildingRequest(buildingId, cb, cbObj)
	local req = RoomModule_pb.BuyManufactureBuildingRequest()

	req.buildingId = buildingId

	self:sendMsg(req, cb, cbObj)
end

function RoomRpc:onReceiveBuyManufactureBuildingInfoReply(resultCode, msg)
	if resultCode == 0 then
		RoomBuildingController.instance:buyManufactureBuildingInfoReply(msg)
	end
end

function RoomRpc:sendGenerateRoadRequest(pathMOList, idList, cb, cbObj)
	local req = RoomModule_pb.GenerateRoadRequest()

	for _, pathMO in ipairs(pathMOList) do
		local roadInfo = RoomModule_pb.RoadInfo()

		if pathMO.id > 0 then
			roadInfo.id = pathMO.id or 0
		end

		roadInfo.fromType = pathMO.fromType
		roadInfo.toType = pathMO.toType
		roadInfo.critterUid = pathMO.critterUid or 0
		roadInfo.buildingUid = pathMO.buildingUid or 0
		roadInfo.blockCleanType = pathMO.blockCleanType or 0

		local hexPointList = pathMO:getHexPointList()

		for __, hexPoint in ipairs(hexPointList) do
			local roadPoint = RoomModule_pb.RoadPoint()

			roadPoint.x = hexPoint.x
			roadPoint.y = hexPoint.y

			table.insert(roadInfo.roadPoints, roadPoint)
		end

		table.insert(req.roadInfos, roadInfo)
	end

	if idList then
		for _, id in ipairs(idList) do
			table.insert(req.ids, id)
		end
	end

	self:sendMsg(req, cb, cbObj)
end

function RoomRpc:onReceiveGenerateRoadReply(resultCode, msg)
	if resultCode == 0 then
		RoomModel.instance:setRoadInfoListByMode(msg.validRoadInfos, RoomEnum.GameMode.Edit)
	end
end

function RoomRpc:sendDeleteRoadRequest(idList, cb, cbObj)
	local req = RoomModule_pb.DeleteRoadRequest()

	for _, id in ipairs(idList) do
		table.insert(req.ids, id)
	end

	self:sendMsg(req, cb, cbObj)
end

function RoomRpc:onReceiveDeleteRoadReply(resultCode, msg)
	if resultCode == 0 then
		local ids = {}

		tabletool.addValues(ids, msg.ids)
		RoomModel.instance:removeRoadInfoByIdsMode(ids, RoomEnum.GameMode.Edit)
		RoomTransportController.instance:deleteRoadReply(msg)
	end
end

function RoomRpc:sendAllotCritterRequestt(id, critterUid, cb, cbObj)
	local req = RoomModule_pb.AllotCritterRequest()

	req.id = id
	req.critterUid = critterUid

	self:sendMsg(req, cb, cbObj)
end

function RoomRpc:onReceiveAllotCritterReply(resultCode, msg)
	if resultCode == 0 then
		RoomTransportController.instance:allotCritterReply(msg)

		local critterList = {
			msg.critterUid
		}
		local playEffDict = {
			[msg.id] = critterList
		}

		ManufactureController.instance:removeRestingCritterList(critterList)
		CritterController.instance:dispatchEvent(CritterEvent.PlayAddCritterEff, playEffDict, true)
	end
end

function RoomRpc:sendAllotVehicleRequest(id, buildingUid, skinId, cb, cbObj)
	local req = RoomModule_pb.AllotVehicleRequest()

	req.id = id
	req.buildingUid = buildingUid
	req.skinId = skinId

	self:sendMsg(req, cb, cbObj)
end

function RoomRpc:onReceiveAllotVehicleReply(resultCode, msg)
	if resultCode == 0 then
		RoomTransportController.instance:allotVehicleReply(msg)
	end
end

function RoomRpc:sendGetManufactureInfoRequest(cb, cbObj)
	local req = RoomModule_pb.GetManufactureInfoRequest()

	self:sendMsg(req, cb, cbObj)
end

function RoomRpc:onReceiveGetManufactureInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ManufactureController.instance:updateManufactureInfo(msg)
end

function RoomRpc:onReceiveManuBuildingInfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ManufactureController.instance:updateFrozenItem(msg.frozenItems2Count)
	ManufactureController.instance:updateManuBuildingInfoList(msg.manuBuildingInfos)

	local playAddEffDict = ManufactureController.instance:getPlayAddEffDict(msg.manuBuildingInfos)

	ManufactureController.instance:dispatchEvent(ManufactureEvent.PlayAddManufactureItemEff, playAddEffDict)
end

function RoomRpc:sendManuBuildingUpgradeRequest(buildingUid, cb, cbObj)
	local req = RoomModule_pb.ManuBuildingUpgradeRequest()

	req.uid = buildingUid

	self:sendMsg(req, cb, cbObj)
end

function RoomRpc:onReceiveManuBuildingUpgradeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local manuBuildingInfo = msg.manuBuildingInfo

	ManufactureController.instance:updateManuBuildingInfo(manuBuildingInfo)
end

function RoomRpc:sendSelectSlotProductionPlanRequest(buildingUid, slotOperationInfoList)
	local req = RoomModule_pb.SelectSlotProductionPlanRequest()

	req.uid = buildingUid

	for _, slotOperationInfo in ipairs(slotOperationInfoList) do
		local operationInfo = RoomModule_pb.OperationInfo()

		operationInfo.slotId = slotOperationInfo.slotId
		operationInfo.operation = slotOperationInfo.operation
		operationInfo.productionId = slotOperationInfo.productionId
		operationInfo.priority = slotOperationInfo.priority

		table.insert(req.operationInfos, operationInfo)
	end

	self:sendMsg(req)
end

function RoomRpc:onReceiveSelectSlotProductionPlanReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ManufactureController.instance:updateManuBuildingInfoList(msg.manuBuildingInfos, true)

	local playAddEffDict = ManufactureController.instance:getPlayAddEffDict(msg.manuBuildingInfos)

	ManufactureController.instance:dispatchEvent(ManufactureEvent.PlayAddManufactureItemEff, playAddEffDict)
end

function RoomRpc:sendManufactureAccelerateRequest(buildingUid, useItemData, slotId)
	local req = RoomModule_pb.ManufactureAccelerateRequest()

	req.uid = buildingUid
	req.slotId = slotId
	req.useItemData.materilType = useItemData.type
	req.useItemData.materilId = useItemData.id
	req.useItemData.quantity = useItemData.quantity

	self:sendMsg(req)
end

function RoomRpc:onReceiveManufactureAccelerateReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ManufactureController.instance:updateManuBuildingInfoList(msg.manuBuildingInfos, true)
end

function RoomRpc:sendReapFinishSlotRequest(buildingUid)
	local req = RoomModule_pb.ReapFinishSlotRequest()

	req.buildingUid = buildingUid

	self:sendMsg(req)
end

function RoomRpc:onReceiveReapFinishSlotReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local normalList = {}

	for _, matData in ipairs(msg.normalReapItem) do
		local materialData = MaterialDataMO.New()

		materialData:init(matData)
		table.insert(normalList, materialData)
	end

	for _, matData in ipairs(msg.criReapItem) do
		local materialData = MaterialDataMO.New()

		materialData:init(matData)

		materialData.isShowExtra = true

		table.insert(normalList, materialData)
	end

	local usedList = {}

	for _, matData in ipairs(msg.occupiedCriItem) do
		local materialData = MaterialDataMO.New()

		materialData:init(matData)
		table.insert(usedList, materialData)
	end

	if next(normalList) or next(usedList) then
		ViewMgr.instance:openView(ViewName.RoomManufactureGetView, {
			normalList = normalList,
			usedList = usedList
		})
	else
		GameFacade.showToast(ToastEnum.RoomNoManufactureItemGet)
	end

	ManufactureController.instance:updateManuBuildingInfoList(msg.manuBuildingInfos, true)
end

function RoomRpc:sendDispatchCritterRequest(buildingUid, critterUid, critterSlotId)
	local req = RoomModule_pb.DispatchCritterRequest()

	req.buildingUid = buildingUid
	req.critterUid = critterUid
	req.critterSlotId = critterSlotId

	self:sendMsg(req)
end

function RoomRpc:onReceiveDispatchCritterReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ManufactureController.instance:updateWorkCritterInfo(msg.buildingUid)

	if msg.putSlotId then
		local playEffDict = {
			[msg.buildingUid] = {
				[msg.putSlotId] = msg.critterUid
			}
		}

		CritterController.instance:dispatchEvent(CritterEvent.PlayAddCritterEff, playEffDict)
	end

	if msg.infos then
		for _, info in ipairs(msg.infos) do
			RoomTransportController.instance:allotCritterReply(info)
		end
	end
end

function RoomRpc:sendBuyRestSlotRequest(buildingUid, seatSlotId)
	local req = RoomModule_pb.BuyRestSlotRequest()

	req.buildingUid = buildingUid
	req.buySlotId = seatSlotId

	self:sendMsg(req)
end

function RoomRpc:onReceiveBuyRestSlotReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	CritterController.instance:buySeatSlotCb(msg.buildingUid, msg.buySlotId)
end

function RoomRpc:sendChangeRestCritterRequest(buildingUid, operation, slotId1, critterUid, slotId2, cb, cbObj)
	local req = RoomModule_pb.ChangeRestCritterRequest()

	req.buildingUid = buildingUid
	req.operation = operation
	req.slotId1 = slotId1
	req.critterUid = critterUid
	req.slotId2 = slotId2

	self:sendMsg(req, cb, cbObj)
end

function RoomRpc:onReceiveChangeRestCritterReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function RoomRpc:onReceiveRestBuildingInfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	CritterController.instance:setCritterBuildingInfoList(msg.restBuildingInfos)
end

function RoomRpc:onReceiveRoadInfoPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoomTransportController.instance:batchCritterReply(msg.roadInfos)
end

function RoomRpc:sendFeedCritterRequest(critterUid, useFoodData, cb, cbObj)
	local req = RoomModule_pb.FeedCritterRequest()

	req.critterUid = critterUid
	req.useFoodData.materilType = useFoodData.type
	req.useFoodData.materilId = useFoodData.id
	req.useFoodData.quantity = useFoodData.quantity

	self:sendMsg(req, cb, cbObj)
end

function RoomRpc:onReceiveFeedCritterReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function RoomRpc:sendBatchDispatchCrittersRequest(type)
	local req = RoomModule_pb.BatchDispatchCrittersRequest()

	req.type = type

	self:sendMsg(req)
end

function RoomRpc:onReceiveBatchDispatchCrittersReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ManufactureController.instance:openRouseCritterView(msg)
end

function RoomRpc:sendRouseCrittersRequest(type, infosList)
	local req = RoomModule_pb.RouseCrittersRequest()

	req.type = type

	for _, info in ipairs(infosList) do
		local batchDispatchInfo = RoomModule_pb.BatchDispatchInfo()

		batchDispatchInfo.buildingUid = info.buildingUid
		batchDispatchInfo.roadId = info.roadId

		for _, critterUid in ipairs(info.critterUids) do
			table.insert(batchDispatchInfo.critterUids, critterUid)
		end

		table.insert(req.infos, batchDispatchInfo)
	end

	self:sendMsg(req)
end

function RoomRpc:onReceiveRouseCrittersReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local playEffDict = {}
	local isTransport = msg.type == CritterEnum.OneKeyType.Transport

	if isTransport then
		RoomTransportController.instance:batchCritterReply(msg.roadInfos)
	end

	local rouseCritterList = {}

	if msg.validInfos then
		for _, info in ipairs(msg.validInfos) do
			if isTransport then
				if not info.roadId then
					local id = info.buildingUid

					playEffDict[id] = playEffDict[id] or {}

					for _, critterInfo in ipairs(info.infos) do
						local critterUid = critterInfo.critterUid

						playEffDict[id][critterInfo.slotId] = critterUid
						rouseCritterList[#rouseCritterList + 1] = critterUid
					end
				end
			end
		end
	end

	ManufactureController.instance:removeRestingCritterList(rouseCritterList)
	CritterController.instance:dispatchEvent(CritterEvent.PlayAddCritterEff, playEffDict, isTransport)
end

function RoomRpc:sendBatchAddProctionsRequest(type, buildingType, buildingId, itemId, quantity)
	local req = RoomModule_pb.BatchAddProctionsRequest()

	req.type = type
	req.freeInfo.buildingType = buildingType or 0
	req.freeInfo.buildingDefineId = buildingId or 0

	local entry = MaterialModule_pb.M2QEntry()

	entry.materialId = itemId or 0
	entry.quantity = quantity or 0

	table.insert(req.freeInfo.item2Count, entry)
	self:sendMsg(req)
end

function RoomRpc:onReceiveBatchAddProctionsReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function RoomRpc:sendGetFrozenItemInfoRequest()
	local req = RoomModule_pb.GetFrozenItemInfoRequest()

	self:sendMsg(req)
end

function RoomRpc:onReceiveGetFrozenItemInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ManufactureController.instance:updateFrozenItem(msg.frozenItems2Count)
end

function RoomRpc:sendGetOrderInfoRequest(callback, callbackobj)
	local req = RoomModule_pb.GetOrderInfoRequest()

	self:sendMsg(req, callback, callbackobj)
end

function RoomRpc:onReceiveGetOrderInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoomTradeModel.instance:onGetOrderInfo(msg)
	RoomTradeController.instance:dispatchEvent(RoomTradeEvent.OnGetTradeOrderInfo)
end

function RoomRpc:sendFinishOrderRequest(orderType, orderId, sellCount)
	local req = RoomModule_pb.FinishOrderRequest()

	req.orderType = orderType
	req.orderId = orderId

	if sellCount then
		req.sellCount = sellCount
	end

	self:sendMsg(req)
end

function RoomRpc:onReceiveFinishOrderReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoomTradeController.instance:onFinishOrderReply(msg)
end

function RoomRpc:sendRefreshPurchaseOrderRequest(orderId, guideId, stepId, callback, callbackObj)
	local req = RoomModule_pb.RefreshPurchaseOrderRequest()

	req.orderId = orderId
	req.guideId = guideId or 0
	req.step = stepId or 0

	self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveRefreshPurchaseOrderReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoomTradeController.instance:onRefreshDailyOrderReply(msg)
end

function RoomRpc:sendChangePurchaseOrderTraceStateRequest(orderId, isTrace)
	local req = RoomModule_pb.ChangePurchaseOrderTraceStateRequest()

	req.orderId = orderId
	req.isTrace = isTrace

	self:sendMsg(req)
end

function RoomRpc:onReceiveChangePurchaseOrderTraceStateReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoomTradeController.instance:onTracedDailyOrderReply(msg)
end

function RoomRpc:sendLockOrderRequest(orderId, isLocked)
	local req = RoomModule_pb.LockOrderRequest()

	req.orderId = orderId
	req.operation = isLocked and 1 or 2

	self:sendMsg(req)
end

function RoomRpc:onReceiveLockOrderReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoomTradeController.instance:onLockedDailyOrderReply(msg)
end

function RoomRpc:sendGetTradeTaskInfoRequest(callback, callbackObj)
	local req = RoomModule_pb.GetTradeTaskInfoRequest()

	self:sendMsg(req, callback, callbackObj)
end

function RoomRpc:onReceiveGetTradeTaskInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoomTradeTaskModel.instance:onGetTradeTaskInfo(msg)
end

function RoomRpc:sendReadNewTradeTaskRequest(ids)
	local req = RoomModule_pb.ReadNewTradeTaskRequest()

	for i, id in pairs(ids) do
		req.ids:append(id)
	end

	self:sendMsg(req)
end

function RoomRpc:onReceiveReadNewTradeTaskReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoomTradeTaskModel.instance:onReadNewTradeTask(msg.ids)
end

function RoomRpc:sendGetTradeSupportBonusRequest(id)
	local req = RoomModule_pb.GetTradeSupportBonusRequest()

	req.id = id

	self:sendMsg(req)
end

function RoomRpc:onReceiveGetTradeSupportBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoomTradeTaskModel.instance:onGetLevelBonus(msg.id)
	RoomTradeController.instance:dispatchEvent(RoomTradeEvent.OnGetTradeSupportBonusReply)
end

function RoomRpc:sendTradeLevelUpRequest()
	local req = RoomModule_pb.TradeLevelUpRequest()

	self:sendMsg(req)
end

function RoomRpc:onReceiveTradeLevelUpReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ManufactureModel.instance:setTradeLevel(msg.level)
	RoomTradeController.instance:dispatchEvent(RoomTradeEvent.OnTradeLevelUpReply, msg.level)
end

function RoomRpc:onReceiveTradeTaskPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoomTradeTaskModel.instance:onRefeshTaskMo(msg.infos)
	self:sendGetTradeTaskInfoRequest()
end

function RoomRpc:sendGetTradeTaskExtraBonusRequest()
	local req = RoomModule_pb.GetTradeTaskExtraBonusRequest()

	self:sendMsg(req)
end

function RoomRpc:onReceiveGetTradeTaskExtraBonusReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoomTradeTaskModel.instance:setCanGetExtraBonus()
	RoomTradeController.instance:dispatchEvent(RoomTradeEvent.OnGetTradeTaskExtraBonusReply)
end

function RoomRpc:sendGetRoomLogRequest()
	local req = RoomModule_pb.GetRoomLogRequest()

	self:sendMsg(req)
end

function RoomRpc:onReceiveGetRoomLogReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoomLogModel.instance:setInfos(msg.infos)
end

function RoomRpc:sendReadRoomLogNewRequest(index)
	local req = RoomModule_pb.ReadRoomLogNewRequest()

	self:sendMsg(req)
end

function RoomRpc:onReceiveReadRoomLogNewReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function RoomRpc:sendGainGuideBuildingRequest(guideId, step)
	local req = RoomModule_pb.GainGuideBuildingRequest()

	req.guideId = guideId
	req.step = step

	self:sendMsg(req)
end

function RoomRpc:onReceiveGainGuideBuildingReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoomController.instance:dispatchEvent(RoomEvent.GetGuideBuilding, msg)
end

function RoomRpc:sendAccelerateGuidePlanRequest(guideId, step)
	local req = RoomModule_pb.AccelerateGuidePlanRequest()

	req.guideId = guideId
	req.step = step

	self:sendMsg(req)
end

function RoomRpc:onReceiveAccelerateGuidePlanReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoomController.instance:dispatchEvent(RoomEvent.AccelerateGuidePlan, msg)
end

function RoomRpc:sendUnloadRestBuildingCrittersRequest(buildingUid, cb, cbObj)
	local req = RoomModule_pb.UnloadRestBuildingCrittersRequest()

	req.buildingUid = buildingUid

	self:sendMsg(req, cb, cbObj)
end

function RoomRpc:onReceiveUnloadRestBuildingCrittersReply(resultCode, msg)
	return
end

function RoomRpc:sendReplaceRestBuildingCrittersRequest(buildingUid, cb, cbObj)
	local req = RoomModule_pb.ReplaceRestBuildingCrittersRequest()

	req.buildingUid = buildingUid

	self:sendMsg(req, cb, cbObj)
end

function RoomRpc:onReceiveReplaceRestBuildingCrittersReply(resultCode, msg)
	return
end

function RoomRpc:sendGetBlockPermanentInfoRequest(blockIds, cb, cbObj)
	if not blockIds or #blockIds < 0 then
		return
	end

	local req = RoomModule_pb.GetBlockPermanentInfoRequest()

	for _, blockId in ipairs(blockIds) do
		table.insert(req.blockIds, blockId)
	end

	self:sendMsg(req, cb, cbObj)
end

function RoomRpc:onReceiveGetBlockPermanentInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	RoomWaterReformController.instance:onGetBlockReformPermanentInfo(msg.permanentInfos)
end

RoomRpc.instance = RoomRpc.New()

return RoomRpc
