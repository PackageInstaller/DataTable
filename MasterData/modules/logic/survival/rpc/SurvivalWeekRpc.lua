-- chunkname: @modules/logic/survival/rpc/SurvivalWeekRpc.lua

module("modules.logic.survival.rpc.SurvivalWeekRpc", package.seeall)

local SurvivalWeekRpc = class("SurvivalWeekRpc", BaseRpc)

function SurvivalWeekRpc:onReceiveSurvivalBagUpdatePush(resultCode, msg)
	if resultCode == 0 then
		SurvivalMapHelper.instance:addPushToFlow("SurvivalBagUpdatePush", msg)
	end
end

function SurvivalWeekRpc:sendSurvivalRemoveBagItem(bagType, uid, count, callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalRemoveBagItemRequest()

	req.bagType = bagType
	req.uid = uid
	req.count = count

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalRemoveBagItemReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SurvivalWeekRpc:sendSurvivalPanelOperationRequest(panelUid, operation, callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalPanelOperationRequest()

	req.panelUid = panelUid
	req.operation = operation

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalPanelOperationReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SurvivalWeekRpc:sendSurvivalClosePanelRequest(panelUid, callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalClosePanelRequest()

	req.panelUid = panelUid

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalClosePanelReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SurvivalWeekRpc:sendSurvivalStartWeekChooseDiff(difficulty, hardnessId, roleId, callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalStartWeekChooseDiffRequest()

	req.difficulty = difficulty
	req.roleId = roleId

	if hardnessId then
		for _, id in ipairs(hardnessId) do
			table.insert(req.hardnessId, id)
		end
	end

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalStartWeekChooseDiffReply(resultCode, msg)
	if resultCode == 0 then
		SurvivalShelterModel.instance:setWeekData(msg.weekInfo, true, msg.extendScore)

		if msg.weekInfo.difficulty ~= SurvivalConst.FirstPlayDifficulty then
			ViewMgr.instance:closeView(ViewName.SurvivalHardView)
			ViewMgr.instance:closeView(ViewName.SurvivalRoleSelectView)
		end

		local isFirstPlayer = msg.weekInfo.difficulty == SurvivalConst.FirstPlayDifficulty

		ViewMgr.instance:openView(ViewName.SurvivalSelectTalentTreeView, {
			isFirstPlayer = isFirstPlayer
		})
	end
end

function SurvivalWeekRpc:sendSurvivalGetWeekInfo(callback, callobj)
	SurvivalMapHelper.instance:clearSteps()

	local req = SurvivalWeekModule_pb.SurvivalGetWeekInfoRequest()

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalGetWeekInfoReply(resultCode, msg)
	if resultCode == 0 then
		local isHaveBoss = SurvivalShelterModel.instance:haveBoss()

		SurvivalShelterModel.instance:setWeekData(msg.weekInfo)

		if not isHaveBoss and SurvivalShelterModel.instance:haveBoss() then
			SurvivalShelterModel.instance:setNeedShowBossInvade(true)
		end
	end
end

function SurvivalWeekRpc:onReceiveSurvivalWeekInfoPush(resultCode, msg)
	if resultCode == 0 then
		local isHaveBoss = SurvivalShelterModel.instance:haveBoss()

		SurvivalShelterModel.instance:setWeekData(msg.weekInfo)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnWeekInfoUpdate)

		if not isHaveBoss and SurvivalShelterModel.instance:haveBoss() then
			SurvivalShelterModel.instance:setNeedShowBossInvade(true)
		end
	end
end

function SurvivalWeekRpc:sendSurvivalGetEquipInfo(callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalGetEquipInfoRequest()

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalGetEquipInfoReply(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		weekInfo.equipBox:init(msg.equipBox)
	end
end

function SurvivalWeekRpc:sendSurvivalEquipSetNewFlagRequest(slotId, callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalEquipSetNewFlagRequest()

	if slotId then
		for _, v in ipairs(slotId) do
			table.insert(req.slotId, v)
		end
	end

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalEquipSetNewFlagReply(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		for i, v in ipairs(msg.slots) do
			if weekInfo.equipBox.slots[v.slotId] then
				weekInfo.equipBox.slots[v.slotId]:init(v)
			end
		end

		weekInfo.equipBox:calcAttrs()
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnEquipInfoUpdate)
	end
end

function SurvivalWeekRpc:sendSurvivalEquipSwitchPlan(newPlanId, callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalEquipSwitchPlanRequest()

	req.newPlanId = newPlanId

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalEquipSwitchPlanReply(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		weekInfo.equipBox:init(msg.equipBox)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnEquipInfoUpdate)
		SurvivalEquipRedDotHelper.instance:checkRed()
	end
end

function SurvivalWeekRpc:sendSurvivalEquipWear(slotId, uid, callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalEquipWearRequest()

	req.slotId = slotId
	req.uid = uid

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalEquipWearReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SurvivalWeekRpc:sendSurvivalEquipDemount(slotId, callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalEquipDemountRequest()

	req.slotId = slotId

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalEquipDemountReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SurvivalWeekRpc:sendSurvivalJewelryEquipWear(slotId, uid, callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalJewelryEquipWearRequest()

	req.slotId = slotId
	req.uid = uid

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalJewelryEquipWearReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SurvivalWeekRpc:sendSurvivalJewelryEquipDemount(slotId, callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalJewelryEquipDemountRequest()

	req.slotId = slotId

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalJewelryEquipDemountReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SurvivalWeekRpc:sendSurvivalEquipOneKeyWear(tagId, callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalEquipOneKeyWearRequest()

	req.tagId = tagId
	self.oneKeyTagId = tagId

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalEquipOneKeyWearReply(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if not weekInfo or not self.oneKeyTagId then
			return
		end

		local nowTagId = weekInfo.equipBox.maxTagId

		if nowTagId ~= self.oneKeyTagId then
			local isEmpty = true

			for k, v in pairs(weekInfo.equipBox.slots) do
				if not v.item:isEmpty() then
					isEmpty = false

					break
				end
			end

			if isEmpty then
				return
			end

			local preTagCo = lua_survival_equip_found.configDict[self.oneKeyTagId]
			local nowTagCo = lua_survival_equip_found.configDict[nowTagId]

			if not preTagCo or not nowTagCo then
				GameFacade.showToast(ToastEnum.SurvivalEquipTagNoEnough2)
			else
				GameFacade.showToast(ToastEnum.SurvivalEquipTagNoEnough, preTagCo.name, nowTagCo.name)
			end
		end
	end
end

function SurvivalWeekRpc:sendSurvivalEquipOneKeyDemount(callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalEquipOneKeyDemountRequest()

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalEquipOneKeyDemountReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SurvivalWeekRpc:onReceiveSurvivalEquipUpdatePush(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		weekInfo.equipBox:init(msg.equipBox)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnEquipInfoUpdate)
		SurvivalEquipRedDotHelper.instance:checkRed()
	end
end

function SurvivalWeekRpc:sendSurvivalEquipCompound(uid, callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalEquipCompoundRequest()

	if uid then
		for _, v in ipairs(uid) do
			table.insert(req.uid, v)
		end
	end

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalEquipCompoundReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SurvivalWeekRpc:sendSurvivalChooseBooty(npcIds, equipIds, callback, callobj, isBlock)
	local req = SurvivalWeekModule_pb.SurvivalChooseBootyRequest()

	if npcIds then
		for _, v in ipairs(npcIds) do
			table.insert(req.npcId, v)
		end
	end

	if equipIds then
		for _, v in ipairs(equipIds) do
			table.insert(req.equipId, v)
		end
	end

	if isBlock then
		UIBlockHelper.instance:startBlock(UIBlockKey.SurvivalCommon, 3)

		self.isBlock = true
	end

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalChooseBootyReply(resultCode, msg)
	if self.isBlock then
		UIBlockMgr.instance:endBlock(UIBlockKey.SurvivalCommon)

		self.isBlock = nil
	end

	if resultCode == 0 then
		SurvivalShelterModel.instance:setWeekData(msg.weekInfo, true)

		local outSideMo = SurvivalModel.instance:getOutSideInfo()

		if outSideMo then
			outSideMo.inWeek = true
		end

		SurvivalController.instance:enterSurvivalShelterScene()
	end
end

function SurvivalWeekRpc:sendSurvivalAbandonWeek(callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalAbandonWeekRequest()

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalAbandonWeekReply(resultCode, msg)
	if resultCode == 0 then
		SurvivalOutSideRpc.instance:sendSurvivalOutSideGetInfo()
	end
end

function SurvivalWeekRpc:onReceiveSurvivalSettleWeekPush(resultCode, msg)
	if resultCode == 0 then
		SurvivalController.instance:playSettleWork(msg)
	end
end

function SurvivalWeekRpc:sendSurvivalBuildRequest(id, callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalBuildRequest()

	req.id = id

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalBuildReply(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo then
			weekInfo:updateBuildingInfo(msg.building)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnBuildingInfoUpdate, msg.building.id)
		end
	end
end

function SurvivalWeekRpc:sendSurvivalRepairRequest(id, callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalRepairRequest()

	req.id = id

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalRepairReply(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo then
			weekInfo:updateBuildingInfo(msg.building)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnBuildingInfoUpdate)
		end
	end
end

function SurvivalWeekRpc:sendSurvivalUpgradeRequest(id, callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalUpgradeRequest()

	req.id = id

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if weekInfo then
		weekInfo:lockBuildingLevel(id)
	end

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalUpgradeReply(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo then
			weekInfo:updateBuildingInfo(msg.building, true)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnBuildingInfoUpdate, msg.building.id)
		end
	end
end

function SurvivalWeekRpc:onReceiveSurvivalAttrContainerUpdatePush(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo then
			weekInfo:updateAttrs(msg.updates)
		end
	end
end

function SurvivalWeekRpc:sendSurvivalNpcChangePositionRequest(npcId, buildingId, position, callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalNpcChangePositionRequest()

	req.npcId = npcId
	req.buildingId = buildingId
	req.position = position

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalNpcChangePositionReply(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo then
			weekInfo:changeNpcPostion(msg.npcId, msg.buildingId, msg.position)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnNpcPostionChange)
		end
	end
end

function SurvivalWeekRpc:sendSurvivalNpcExchangePositionRequest(srcNpcId, targetNpcId, callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalNpcExchangePositionRequest()

	req.srcNpcId = srcNpcId
	req.targetNpcId = targetNpcId

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalNpcExchangePositionReply(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo then
			weekInfo:exchangeNpcPosition(msg.srcNpcId, msg.targetNpcId)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnNpcPostionChange)
		end
	end
end

function SurvivalWeekRpc:sendSurvivalBatchHeroChangePositionRequest(heroId, buildingId, callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalBatchHeroChangePositionRequest()

	if heroId then
		for _, v in ipairs(heroId) do
			table.insert(req.heroId, v)
		end
	end

	req.buildingId = buildingId

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalBatchHeroChangePositionReply(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo then
			weekInfo:batchHeroPostion(msg.heroId, msg.buildingId)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnBuildingInfoUpdate)
		end
	end
end

function SurvivalWeekRpc:sendSurvivalHeroChangePositionRequest(heroId, buildingId, position, callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalHeroChangePositionRequest()

	req.heroId = heroId
	req.buildingId = buildingId
	req.position = position

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalHeroChangePositionReply(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo then
			weekInfo:changeHeroPostion(msg.heroId, msg.buildingId, msg.position)
		end
	end
end

function SurvivalWeekRpc:sendSurvivalHeroExchangePositionRequest(srcHeroId, targetHeroId, callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalHeroExchangePositionRequest()

	req.srcHeroId = srcHeroId
	req.targetHeroId = targetHeroId

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalHeroExchangePositionReply(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo then
			weekInfo:exchangeHeroPosition(msg.srcHeroId, msg.targetHeroId)
		end
	end
end

function SurvivalWeekRpc:sendSurvivalShopSellRequest(uid, shopType, shopId, count, callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalShopSellRequest()

	req.uid = uid
	req.count = count
	req.shopType = shopType
	req.shopId = shopId

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalShopSellReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SurvivalWeekRpc:sendSurvivalShopBuyRequest(uid, count, shopType, shopId, callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalShopBuyRequest()

	req.uid = uid
	req.count = count
	req.shopType = shopType
	req.shopId = shopId

	UIBlockHelper.instance:startBlock(UIBlockKey.SurvivalBagInfoPart, 2)

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalShopBuyReply(resultCode, msg)
	UIBlockHelper.instance:endBlock(UIBlockKey.SurvivalBagInfoPart)

	if resultCode == 0 then
		local shopType = msg.shopType
		local shopId = msg.shopId
		local shopMo = SurvivalMapHelper.instance:getShopById(shopId)

		if shopType == SurvivalEnum.ShopType.Reputation then
			local mo = shopMo:getItemByUid(msg.uid)

			if mo:isNPC() then
				local itemMo = SurvivalBagItemMo.New()

				itemMo:init({
					id = mo.id,
					count = msg.count
				})

				local items = {
					itemMo
				}

				PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalGetRewardView, {
					items = items
				})
			end
		end

		if shopType == SurvivalEnum.ShopType.Reputation or shopType == SurvivalEnum.ShopType.PreExplore or shopType == SurvivalEnum.ShopType.GeneralShop then
			shopMo:reduceItem(msg.uid, msg.count)
		else
			shopMo:removeItem(msg.uid, msg.count)
		end

		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnReceiveSurvivalShopBuyReply, msg)
	end
end

function SurvivalWeekRpc:onReceiveSurvivalShopUpdatePush(resultCode, msg)
	if resultCode == 0 then
		local id = msg.shop.id
		local shopMo = SurvivalMapHelper.instance:getShopById(id)

		if shopMo then
			shopMo:init(msg.shop, shopMo.reputationId, shopMo.reputationLevel)
		end
	end
end

function SurvivalWeekRpc:sendSurvivalReputationRewardRequest(reputationId, level, callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalReputationRewardRequest()

	req.reputationId = reputationId
	req.level = level

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalReputationRewardReply(resultCode, msg)
	if resultCode == 0 then
		local reputationId = msg.reputationId
		local level = msg.level
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
		local survivalShelterBuildingMo = weekInfo:getBuildingMoByReputationId(reputationId)

		survivalShelterBuildingMo.survivalReputationPropMo:onReceiveSurvivalReputationRewardReply(level)
		survivalShelterBuildingMo:refreshReputationRedDot()
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnReceiveSurvivalReputationRewardReply, msg)

		local freeReward = SurvivalConfig.instance:getShopFreeReward(reputationId, level)
		local itemMo = SurvivalBagItemMo.New()

		itemMo:init({
			id = freeReward[1],
			freeReward[2]
		})

		if itemMo:isNPC() then
			local items = {
				itemMo
			}

			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalGetRewardView, {
				items = items
			})
		end
	end
end

function SurvivalWeekRpc:onReceiveSurvivalTaskUpdatePush(resultCode, msg)
	if resultCode == 0 then
		SurvivalMapHelper.instance:addPushToFlow("SurvivalTaskUpdatePush", msg)
	end
end

function SurvivalWeekRpc:onReceiveSurvivalHeroUpdatePush(resultCode, msg)
	if resultCode == 0 then
		SurvivalMapHelper.instance:addPushToFlow("SurvivalHeroUpdatePush", msg)
	end
end

function SurvivalWeekRpc:onReceiveSurvivalItemTipsPush(resultCode, msg)
	if resultCode == 0 then
		local curSceneType = GameSceneMgr.instance:getCurSceneType()

		if curSceneType == SceneType.Fight then
			SurvivalModel.instance:cacheBossFightItem(msg)
		else
			SurvivalMapHelper.instance:addPushToFlow("SurvivalItemTipsPush", msg)
		end
	end
end

function SurvivalWeekRpc:sendSurvivalIntrudeReExterminateRequest(callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalIntrudeReExterminateRequest()

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalIntrudeReExterminateReply(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo then
			weekInfo.intrudeBox.fight:init(msg.fight)
		end

		SurvivalController.instance:dispatchEvent(SurvivalEvent.UpdateView)
	end
end

function SurvivalWeekRpc:sendSurvivalIntrudeAbandonExterminateRequest(callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalIntrudeAbandonExterminateRequest()

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalIntrudeAbandonExterminateReply(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo then
			weekInfo.intrudeBox.fight:init(msg.fight)
		end

		SurvivalController.instance:dispatchEvent(SurvivalEvent.AbandonFight)
	end
end

function SurvivalWeekRpc:onReceiveSurvivalIntrudeFightSettlePush(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo then
			weekInfo.intrudeBox.fight:init(msg.fight)

			local fightId = msg.fight.fightId

			if msg.fight.status == SurvivalEnum.ShelterMonsterFightState.Win and fightId ~= nil and fightId ~= 0 then
				SurvivalModel.instance:addDebugSettleStr("onReceiveSurvivalIntrudeFightSettlePush")
				SurvivalShelterModel.instance:setNeedShowFightSuccess(true, fightId)
			end
		end
	end
end

function SurvivalWeekRpc:onReceiveSurvivalStepPush(resultCode, msg)
	if resultCode == 0 then
		SurvivalMapHelper.instance:cacheSteps(msg.step)
	end
end

function SurvivalWeekRpc:sendSurvivalDecreePromulgateRequest(no, callback, callbackObj)
	local req = SurvivalWeekModule_pb.SurvivalDecreePromulgateRequest()

	req.no = no

	return self:sendMsg(req, callback, callbackObj)
end

function SurvivalWeekRpc:onReceiveSurvivalDecreePromulgateReply(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo then
			weekInfo:getDecreeBox():updateDecreeInfo(msg.decree)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnDecreeDataUpdate)
		end
	end
end

function SurvivalWeekRpc:sendSurvivalDecreeChoosePolicyRequest(no, policyIndex, callback, callbackObj)
	local req = SurvivalWeekModule_pb.SurvivalDecreeChoosePolicyRequest()

	req.no = no
	req.policyIndex = policyIndex

	return self:sendMsg(req, callback, callbackObj)
end

function SurvivalWeekRpc:onReceiveSurvivalDecreeChoosePolicyReply(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo then
			local decreeBox = weekInfo:getDecreeBox()

			decreeBox:updateDecreeInfo(msg.decree)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnDecreeDataUpdate)

			local decreeInfo = decreeBox:getDecreeInfo(msg.decree.no)

			SurvivalController.instance:startDecreeVote(decreeInfo)
		end
	else
		PopupController.instance:setPause(ViewName.SurvivalDecreeVoteView, false)
	end
end

function SurvivalWeekRpc:onReceiveSurvivalDecreeChangeUpdatePush(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo then
			weekInfo:getDecreeBox():updateDecreeInfo(msg.decree)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnDecreeDataUpdate)
		end
	end
end

function SurvivalWeekRpc:onReceiveMsg(resultCode, cmd, recvProtoName, msg, downTag, socketId)
	SurvivalWeekRpc.super.onReceiveMsg(self, resultCode, cmd, recvProtoName, msg, downTag, socketId)

	if resultCode == 0 and string.find(recvProtoName, "Reply$") then
		SurvivalMapHelper.instance:tryStartFlow(recvProtoName)
	end
end

function SurvivalWeekRpc:sendSurvivalRefreshRecruitTagRequest(callback, callbackObj)
	local req = SurvivalWeekModule_pb.SurvivalRefreshRecruitTagRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function SurvivalWeekRpc:onReceiveSurvivalRefreshRecruitTagReply(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo then
			weekInfo:updateRecruitInfo(msg.recruitInfo)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnRecruitRefresh)
		end
	end
end

function SurvivalWeekRpc:sendSurvivalPublishRecruitTagRequest(tagId, callback, callbackObj)
	local req = SurvivalWeekModule_pb.SurvivalPublishRecruitTagRequest()

	if tagId then
		for _, v in ipairs(tagId) do
			table.insert(req.tagId, v)
		end
	end

	return self:sendMsg(req, callback, callbackObj)
end

function SurvivalWeekRpc:onReceiveSurvivalPublishRecruitTagReply(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo then
			weekInfo:updateRecruitInfo(msg.recruitInfo)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnRecruitDataUpdate)
		end
	end
end

function SurvivalWeekRpc:sendSurvivalRecruitNpcRequest(npcId, callback, callbackObj)
	local req = SurvivalWeekModule_pb.SurvivalRecruitNpcRequest()

	req.npcId = npcId

	return self:sendMsg(req, callback, callbackObj)
end

function SurvivalWeekRpc:onReceiveSurvivalRecruitNpcReply(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo then
			weekInfo:updateRecruitInfo(msg.recruitInfo)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnRecruitDataUpdate)
		end
	end
end

function SurvivalWeekRpc:sendSurvivalAbandonRecruitNpcRequest(callback, callbackObj)
	local req = SurvivalWeekModule_pb.SurvivalAbandonRecruitNpcRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function SurvivalWeekRpc:onReceiveSurvivalAbandonRecruitNpcReply(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo then
			weekInfo:updateRecruitInfo(msg.recruitInfo)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnRecruitDataUpdate)
		end
	end
end

function SurvivalWeekRpc:onReceiveSurvivalRecruitInfoPush(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo then
			weekInfo:updateRecruitInfo(msg.recruitInfo)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnRecruitDataUpdate)
		end
	end
end

function SurvivalWeekRpc:sendSurvivalNpcAcceptTaskRequest(npcId, behaviorId, callback, callbackObj)
	local req = SurvivalWeekModule_pb.SurvivalNpcAcceptTaskRequest()

	req.npcId = npcId
	req.behaviorId = behaviorId

	return self:sendMsg(req, callback, callbackObj)
end

function SurvivalWeekRpc:onReceiveSurvivalNpcAcceptTaskReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SurvivalWeekRpc:sendSurvivalReceiveTaskRewardRequest(moduleId, taskId, callback, callbackObj)
	local req = SurvivalWeekModule_pb.SurvivalReceiveTaskRewardRequest()

	req.moduleId = moduleId
	req.taskId = taskId

	return self:sendMsg(req, callback, callbackObj)
end

function SurvivalWeekRpc:onReceiveSurvivalReceiveTaskRewardReply(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo then
			local taskBoxMo = weekInfo.taskPanel:getTaskBoxMo(msg.moduleId)
			local taskMo = taskBoxMo:getTaskInfo(msg.taskId)

			if taskMo then
				taskMo:setTaskFinish()
				SurvivalController.instance:dispatchEvent(SurvivalEvent.OnTaskDataUpdate)
			end
		end
	end
end

function SurvivalWeekRpc:sendSurvivalSurvivalWeekClientData(data, callback, callobj)
	local req = SurvivalWeekModule_pb.SurvivalSurvivalWeekClientDataRequest()

	req.data = data

	return self:sendMsg(req, callback, callobj)
end

function SurvivalWeekRpc:onReceiveSurvivalSurvivalWeekClientDataReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SurvivalWeekRpc:onReceiveSurvivalBuildingUpdatePush(resultCode, msg)
	return
end

function SurvivalWeekRpc:sendSurvivalReputationExpRequest(reputationId, callback, callbackObj)
	local req = SurvivalWeekModule_pb.SurvivalReputationExpRequest()

	req.reputationId = reputationId

	UIBlockHelper.instance:startBlock(UIBlockKey.SurvivalReputationSelectView, 2)

	return self:sendMsg(req, callback, callbackObj)
end

function SurvivalWeekRpc:onReceiveSurvivalReputationExpReply(resultCode, msg)
	UIBlockHelper.instance:endBlock(UIBlockKey.SurvivalReputationSelectView)

	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
		local survivalShelterBuildingMo = weekInfo:getBuildingInfo(msg.building.id)

		survivalShelterBuildingMo:setReputationData(msg.building.reputationProp)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnReceiveSurvivalReputationExpReply, {
			msg = msg
		})
	end
end

function SurvivalWeekRpc:sendSurvivalUnlockInsideTechRequest(id)
	local req = SurvivalWeekModule_pb.SurvivalUnlockInsideTechRequest()

	req.id = id

	return self:sendMsg(req)
end

function SurvivalWeekRpc:onReceiveSurvivalUnlockInsideTechReply(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
		local survivalShelterBuildingMo = weekInfo:getTechBuild()

		survivalShelterBuildingMo.survivalTechShelterMo:onReceiveSurvivalUnlockInsideTechReply(msg)
	end
end

function SurvivalWeekRpc:sendSurvivalLossReturnRewardRequest()
	local req = SurvivalWeekModule_pb.SurvivalLossReturnRewardRequest()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	self.lossReturnItems = weekInfo.lossReturnItems

	return self:sendMsg(req)
end

function SurvivalWeekRpc:onReceiveSurvivalLossReturnRewardReply(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
		local items = {}

		if self.lossReturnItems then
			for i, v in ipairs(self.lossReturnItems) do
				local itemMo = SurvivalBagItemMo.New()

				itemMo:init({
					id = v.itemId,
					count = v.count
				})
				table.insert(items, itemMo)
			end

			self.lossReturnItems = nil
		end

		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalGetRewardView, {
			items = items
		})

		weekInfo.lossReturnItems = nil

		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnReceiveSurvivalLossReturnRewardReply)
	end
end

function SurvivalWeekRpc:onReceiveSurvivalDerivedContainerUpdatePush(resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo then
			weekInfo:onReceiveSurvivalDerivedContainerUpdatePush(msg)
		end
	end
end

function SurvivalWeekRpc:onReceiveSurvivalNpcBoxPush(resultCode, msg)
	return
end

SurvivalWeekRpc.instance = SurvivalWeekRpc.New()

return SurvivalWeekRpc
