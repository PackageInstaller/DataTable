-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/controller/HolyStripeController.lua

module("logic.extensions.hoshigami.controller.HolyStripeController", package.seeall)

local HolyStripeController = class("HolyStripeController", BaseController)

HolyStripeController.PM_HolyStripeLoadAllRes = "HolyStripeController.PM_HolyStripeLoadAllRes"
HolyStripeController.PM_HolyStripeEquipRes = "HolyStripeController.PM_HolyStripeEquipRes"
HolyStripeController.PM_HolyStripeUnloadRes = "HolyStripeController.PM_HolyStripeUnloadRes"
HolyStripeController.PM_HolyStripeSmeltRes = "HolyStripeController.PM_HolyStripeSmeltRes"
HolyStripeController.PM_HolyStripeSetSmeltInfoRes = "HolyStripeController.PM_HolyStripeSetSmeltInfoRes"
HolyStripeController.PM_HolyStripeStrengthenRes = "HolyStripeController.PM_HolyStripeStrengthenRes"
HolyStripeController.PM_HolyStripeQuenchingRes = "HolyStripeController.PM_HolyStripeQuenchingRes"
HolyStripeController.On_Select_FilterType = "HolyStripeController.On_Select_FilterType"
HolyStripeController.On_Select_FilterSuit = "HolyStripeController.On_Select_FilterSuit"
HolyStripeController.On_Select_FilterPos = "HolyStripeController.On_Select_FilterPos"
HolyStripeController.On_Select_FilterQuality = "HolyStripeController.On_Select_FilterQuality"
HolyStripeController.On_Select_ConditionSort = "HolyStripeController.On_Select_ConditionSort"
HolyStripeController.On_Select_ConditionFilter = "HolyStripeController.On_Select_ConditionFilter"
HolyStripeController.Bag_Item_Tips_Show = "HolyStripeController.Bag_Item_Tips_Show"
HolyStripeController.Confirm_To_Replace = "HolyStripeController.Confirm_To_Replace"
HolyStripeController.PM_HolyStripeUnloadAllRes = "HolyStripeController.PM_HolyStripeUnloadAllRes"
HolyStripeController.PM_HolyStripeLockOperationRes = "HolyStripeController.PM_HolyStripeLockOperationRes"
HolyStripeController.PM_HolyStripeChangeReadyToDiscardRes = "HolyStripeController.PM_HolyStripeChangeReadyToDiscardRes"
HolyStripeController.PM_HolyStripeReplaceQuenchingDataRes = "HolyStripeController.PM_HolyStripeReplaceQuenchingDataRes"
HolyStripeController.DailyStrengthTip = "HolyStripeController.DailyStrengthTip"
HolyStripeController.ForceUpdateCuiling = "HolyStripeController.ForceUpdateCuiling"

function HolyStripeController:onInit()
	GlobalDispatcher:addListener(HolyStripeAgent.PM_HolyStripeLoadAllRes, self._PM_HolyStripeLoadAllRes, self)
	GlobalDispatcher:addListener(HolyStripeAgent.PM_HolyStripeEquipRes, self._PM_HolyStripeEquipRes, self)
	GlobalDispatcher:addListener(HolyStripeAgent.PM_HolyStripeUnloadRes, self._PM_HolyStripeUnloadRes, self)
	GlobalDispatcher:addListener(HolyStripeAgent.PM_HolyStripeSmeltRes, self._PM_HolyStripeSmeltRes, self)
	GlobalDispatcher:addListener(HolyStripeAgent.PM_HolyStripeSetSmeltInfoRes, self._PM_HolyStripeSetSmeltInfoRes, self)
	GlobalDispatcher:addListener(HolyStripeAgent.PM_HolyStripeStrengthenRes, self._PM_HolyStripeStrengthenRes, self)
	GlobalDispatcher:addListener(HolyStripeAgent.PM_HolyStripeQuenchingRes, self._PM_HolyStripeQuenchingRes, self)
	GlobalDispatcher:addListener(HolyStripeAgent.PM_HolyStripeUnloadAllRes, self._PM_HolyStripeUnloadAllRes, self)
	GlobalDispatcher:addListener(HolyStripeAgent.PM_HolyStripeLockOperationRes, self._PM_HolyStripeLockOperationRes, self)
	GlobalDispatcher:addListener(HolyStripeAgent.PM_HolyStripeChangeReadyToDiscardRes, self._PM_HolyStripeChangeReadyToDiscardRes, self)
	GlobalDispatcher:addListener(HolyStripeAgent.PM_HolyStripeChangeRes, self._PM_HolyStripeChangeRes, self)
	GlobalDispatcher:addListener(HolyStripeAgent.PM_HolyStripeReplaceQuenchingDataRes, self._PM_HolyStripeReplaceQuenchingDataRes, self)
	GlobalDispatcher:addListener(HolyStripeAgent.PM_SuitGetInfoRes, self._PM_SuitGetInfoRes, self)
	GlobalDispatcher:addListener(HolyStripeAgent.PM_ModifySuitGroupRes, self._PM_ModifySuitGroupRes, self)
	GlobalDispatcher:addListener(HolyStripeAgent.PM_DeleteSuitGroupRes, self._PM_DeleteSuitGroupRes, self)
	GlobalDispatcher:addListener(HolyStripeAgent.PM_ModifySuitRes, self._PM_ModifySuitRes, self)
	GlobalDispatcher:addListener(HolyStripeAgent.PM_DeleteSuitRes, self._PM_DeleteSuitRes, self)
	GlobalDispatcher:addListener(HolyStripeAgent.PM_HolyStripeWearSuitRes, self._PM_HolyStripeWearSuitRes, self)
	GlobalDispatcher:addListener(HolyStripeAgent.PM_NotifySuitInfoChangeRes, self._PM_NotifySuitInfoChangeRes, self)
	GlobalDispatcher:addListener(HolyStripeAgent.PM_NotifySuitGroupInfoChangeRes, self._PM_NotifySuitGroupInfoChangeRes, self)
	GlobalDispatcher:addListener(HolyStripeAgent.PM_SetHolyStripeAutoDecomposeRes, self._PM_SetHolyStripeAutoDecomposeRes, self)
	self:onReset()
end

function HolyStripeController:onReset()
	self._isLoadAllHolyStripe = false
	self._collectSweepHolyStripeChanges = false
	self._pendingSweepHolyStripeIds = {}
	self._pendingDiscardReqContext = nil
end

function HolyStripeController:sendPM_HolyStripeLoadAllReq()
	if self._isLoadAllHolyStripe then
		return
	end

	HolyStripeAgent.instance:sendPM_HolyStripeLoadAllReq()
end

function HolyStripeController:_PM_HolyStripeLoadAllRes(status, msg)
	if status == 0 then
		self._isLoadAllHolyStripe = true

		HolyStripeModel.instance:setHolyStripe(msg.infos)
		HolyStripeModel.instance:setAutoSmelt(msg.smeltInfo)
		HolyStripeModel.instance:setAutoDecomposeQuality(msg.autoDecomposeQuality)
		GlobalDispatcher:dispatch(HolyStripeController.PM_HolyStripeLoadAllRes)
	end
end

function HolyStripeController:_PM_HolyStripeEquipRes(status, msg)
	if status == 0 then
		if self._isEquipHolyStripes == true then
			self:_equipByTempList()
		else
			GlobalDispatcher:dispatch(HolyStripeController.PM_HolyStripeEquipRes)
		end
	end
end

function HolyStripeController:_PM_HolyStripeUnloadRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HolyStripeController.PM_HolyStripeUnloadRes)
	end
end

function HolyStripeController:_PM_HolyStripeSmeltRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HolyStripeController.PM_HolyStripeSmeltRes)
	end
end

function HolyStripeController:_PM_HolyStripeSetSmeltInfoRes(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show("保存成功")
		GlobalDispatcher:dispatch(HolyStripeController.PM_HolyStripeSetSmeltInfoRes)
	end
end

function HolyStripeController:sendPM_HolyStripeStrengthenReq(id, usingIds, usingMaterials)
	HolyStripeModel.instance:saveTempHolyStripe(HolyStripeModel.instance:getHolyStripeMo(id))
	HolyStripeAgent.instance:sendPM_HolyStripeStrengthenReq(id, usingIds, usingMaterials)
end

function HolyStripeController:_PM_HolyStripeStrengthenRes(status, msg)
	if status == 0 then
		local tempMo = HolyStripeModel.instance:getTempHolyStripe()

		if HolyStripeModel.instance:getHolyStripeMo(tempMo:getId()):getLv() ~= tempMo:getLv() then
			UIStateManager.instance:push(ViewName.HolyStripeStrengthLvUpView, tempMo)
		else
			FloatWordMgr.instance:show("强化成功")
		end

		GlobalDispatcher:dispatch(HolyStripeController.PM_HolyStripeStrengthenRes)
	end
end

function HolyStripeController:_PM_HolyStripeQuenchingRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HolyStripeController.PM_HolyStripeQuenchingRes, msg.quenchingReplaceDatas)
	end
end

function HolyStripeController:_PM_HolyStripeUnloadAllRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HolyStripeController.PM_HolyStripeUnloadAllRes)
	end
end

function HolyStripeController:_PM_HolyStripeLockOperationRes(status, msg)
	GlobalDispatcher:dispatch(HolyStripeController.PM_HolyStripeLockOperationRes, status)
end

function HolyStripeController:sendPM_HolyStripeBatchLockOperationReq(ids, isLock)
	if not ids or #ids <= 0 then
		return
	end

	HolyStripeAgent.instance:sendPM_HolyStripeLockOperationReq(ids, isLock == true and 1 or 0)
end

function HolyStripeController:sendPM_HolyStripeChangeReadyToDiscardReq(holyStripeMo, isDiscard)
	if not holyStripeMo then
		return
	end

	local setIds = {}
	local unSetIds = {}

	if isDiscard == true then
		table.insert(setIds, holyStripeMo:getId())
	else
		table.insert(unSetIds, holyStripeMo:getId())
	end

	self:sendPM_HolyStripeBatchChangeReadyToDiscardReq(setIds, unSetIds)
end

function HolyStripeController:_PM_HolyStripeChangeReadyToDiscardRes(status, msg)
	local context = self._pendingDiscardReqContext

	if status == 0 and context then
		for i, id in ipairs(context.setIds or {}) do
			local mo = HolyStripeModel.instance:getHolyStripeMo(id)

			if mo then
				mo:setReadyToDiscard(true)
			end
		end

		for i, id in ipairs(context.unSetIds or {}) do
			local mo = HolyStripeModel.instance:getHolyStripeMo(id)

			if mo then
				mo:setReadyToDiscard(false)
			end
		end
	end

	GlobalDispatcher:dispatch(HolyStripeController.PM_HolyStripeChangeReadyToDiscardRes, status, context and context.setIds, context and context.unSetIds)

	self._pendingDiscardReqContext = nil
end

function HolyStripeController:sendPM_HolyStripeBatchChangeReadyToDiscardReq(setIds, unSetIds)
	local setList = setIds or {}
	local unSetList = unSetIds or {}

	if #setList <= 0 and #unSetList <= 0 then
		return
	end

	self._pendingDiscardReqContext = {
		setIds = clone(setList),
		unSetIds = clone(unSetList)
	}

	HolyStripeAgent.instance:sendPM_HolyStripeChangeReadyToDiscardReq(setList, unSetList)
end

function HolyStripeController:_PM_HolyStripeChangeRes(status, msg)
	if status == 0 then
		local addedIds

		if self._collectSweepHolyStripeChanges then
			addedIds = {}

			for i, info in ipairs(msg.changedInfos or {}) do
				if info and info.id and not info.deleted and not HolyStripeModel.instance:getHolyStripeMo(info.id) then
					table.insert(addedIds, info.id)
				end
			end
		end

		HolyStripeModel.instance:addHolyStripeMos(msg.changedInfos)

		if addedIds and #addedIds > 0 then
			self._pendingSweepHolyStripeIds = self._pendingSweepHolyStripeIds or {}

			for i, id in ipairs(addedIds) do
				table.insert(self._pendingSweepHolyStripeIds, id)
			end
		end
	end
end

function HolyStripeController:beginCollectSweepHolyStripes()
	self._collectSweepHolyStripeChanges = true
	self._pendingSweepHolyStripeIds = {}
end

function HolyStripeController:endCollectSweepHolyStripes()
	self._collectSweepHolyStripeChanges = false
	self._pendingSweepHolyStripeIds = {}
end

function HolyStripeController:popCollectedSweepHolyStripeMoByDefineId(defineId)
	local ids = self._pendingSweepHolyStripeIds

	if not ids or #ids <= 0 then
		return nil
	end

	for i, id in ipairs(ids) do
		local mo = HolyStripeModel.instance:getHolyStripeMo(id)

		if mo and mo:getDefineId() == defineId then
			table.remove(ids, i)

			return mo
		end
	end

	return nil
end

function HolyStripeController:_PM_HolyStripeReplaceQuenchingDataRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(HolyStripeController.PM_HolyStripeReplaceQuenchingDataRes)
	end
end

function HolyStripeController:_PM_SuitGetInfoRes(msg)
	HolyStripeModel.instance:setSuitInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_HolyStripeSuitGetInfoRes)
end

function HolyStripeController:_PM_ModifySuitGroupRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_HolyStripeModifySuitGroupRes)
end

function HolyStripeController:_PM_DeleteSuitGroupRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_HolyStripeDeleteSuitGroupRes)
end

function HolyStripeController:_PM_ModifySuitRes(status, msg)
	if self._swapingSuitInfo == true and self._tempSuitId and self._tempSuitInfo then
		local wearItemIds = {}

		for i = 1, 5 do
			if self._tempSuitInfo.wearIds[i] then
				table.insert(wearItemIds, self._tempSuitInfo.wearIds[i])
			else
				table.insert(wearItemIds, -1)
			end
		end

		HolyStripeAgent.instance:sendPM_ModifySuitReq(self._tempSuitId, self._tempSuitInfo.suitName, self._tempSuitInfo.groupId, wearItemIds)

		self._swapingSuitInfo = false
		self._tempSuitId = nil
		self._tempSuitInfo = nil
	else
		GlobalDispatcher:dispatch(GlobalNotify.PM_HolyStripeModifySuitRes, status)
	end
end

function HolyStripeController:_PM_DeleteSuitRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_HolyStripeDeleteSuitRes)
end

function HolyStripeController:_PM_HolyStripeWearSuitRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_HolyStripeWearSuitRes)
end

function HolyStripeController:_PM_NotifySuitInfoChangeRes(msg)
	HolyStripeModel.instance:setSuitChange(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_NotifyHolyStripeSuitInfoChangeRes)
end

function HolyStripeController:_PM_NotifySuitGroupInfoChangeRes(msg)
	HolyStripeModel.instance:setSuitGroupChange(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_NotifyHolyStripeSuitGroupInfoChangeRes)
end

function HolyStripeController:_PM_SetHolyStripeAutoDecomposeRes(msg)
	return
end

function HolyStripeController:_resetDirtySuitInfo(suitId)
	local suitMo = HolyStripeModel.instance:getSuitMo(suitId)
	local wearItemIds = {}

	for i = 1, 5 do
		if suitMo.wearIds[i] then
			table.insert(wearItemIds, suitMo.wearIds[i])
		else
			table.insert(wearItemIds, -1)
		end
	end

	HolyStripeAgent.instance:sendPM_ModifySuitReq(suitId, nil, nil, wearItemIds)
end

function HolyStripeController:_swapSuitInfo(suitIdA, suitIdB)
	if not self._swapingSuitInfo then
		local suitIdAInfo = HolyStripeModel.instance:getSuitMo(suitIdA)
		local suitIdBInfo = HolyStripeModel.instance:getSuitMo(suitIdB)

		self._tempSuitId = suitIdA
		self._tempSuitInfo = HolyStripeSuitMo.New()

		local wearIds = {}

		for i, v in ipairs(suitIdBInfo.wearIds) do
			table.insert(wearIds, v)
		end

		self._tempSuitInfo:initData({
			groupId = suitIdBInfo.groupId,
			suitId = suitIdBInfo.suitId,
			wearItemIds = wearIds,
			suitName = suitIdBInfo.suitName
		})

		self._swapingSuitInfo = true

		local wearItemIds = {}

		for i = 1, 5 do
			if suitIdAInfo.wearIds[i] then
				table.insert(wearItemIds, suitIdAInfo.wearIds[i])
			else
				table.insert(wearItemIds, -1)
			end
		end

		HolyStripeAgent.instance:sendPM_ModifySuitReq(suitIdB, suitIdAInfo.suitName, suitIdAInfo.groupId, wearItemIds)
	end
end

function HolyStripeController:_calculateOneKeyEquip(petId, froceEmpty)
	local bestSuitMoList, bestMoList

	if froceEmpty == true then
		local moList = HolyStripeModel.instance:getExistHolyStripeMoList()

		bestSuitMoList, bestMoList = self:_getBestHolyStripeFormUnequip(moList)
	else
		bestSuitMoList, bestMoList = self:_getBestHolyStripeFormUnequip()
	end

	local result = {}
	local maxZdl = 0
	local equipMo = HolyStripeModel.instance:getEquippedByPetId(petId)

	if #equipMo <= 0 or froceEmpty == true then
		local recommenonIds = self:_getRecommenonIds(petId)

		maxZdl, result = self:_calculateBest4And1(bestSuitMoList, bestMoList, recommenonIds, maxZdl, result)

		if maxZdl > 0 then
			return result
		end

		maxZdl, result = self:_calculateBest2And2(bestSuitMoList, bestMoList, recommenonIds, maxZdl, result)

		if maxZdl > 0 then
			return result
		end

		local allSuitIds = {}

		for suitType, list in pairs(bestSuitMoList) do
			table.insert(allSuitIds, suitType)
		end

		maxZdl, result = self:_calculateBest4And1(bestSuitMoList, bestMoList, allSuitIds, maxZdl, result)

		if maxZdl > 0 then
			return result
		end

		maxZdl, result = self:_calculateAll2And2(bestSuitMoList, bestMoList, recommenonIds, allSuitIds, maxZdl, result)

		if maxZdl > 0 then
			return result
		end

		return bestMoList
	elseif #equipMo > 0 and #equipMo < 5 then
		local equipSuitType = {}
		local equipSuitMap = {}

		for i, v in ipairs(equipMo) do
			if not equipSuitMap[v:getSuitType()] then
				table.insert(equipSuitType, v:getSuitType())
			end

			equipSuitMap[v:getSuitType()] = true
		end

		bestSuitMoList, bestMoList = self:_getBestHolyStripeFormUnequip(equipMo, bestSuitMoList, bestMoList)
		maxZdl, result = self:_calculateBest4And1(bestSuitMoList, bestMoList, equipSuitType, maxZdl, result)

		if maxZdl > 0 then
			for i, v in ipairs(equipMo) do
				if result[v:getPosType()] then
					if result[v:getPosType()]:getId() == v:getId() then
						result[v:getPosType()] = nil
					end
				end
			end

			return result
		end

		maxZdl, result = self:_calculateBest2And2(bestSuitMoList, bestMoList, equipSuitType, maxZdl, result)

		if maxZdl > 0 then
			for i, v in ipairs(equipMo) do
				if result[v:getPosType()] then
					if result[v:getPosType()]:getId() == v:getId() then
						result[v:getPosType()] = nil
					end
				end
			end

			return result
		end

		for i, v in ipairs(equipMo) do
			if bestMoList[v:getPosType()] then
				bestMoList[v:getPosType()] = nil
			end
		end

		return bestMoList
	elseif #equipMo >= 5 then
		for i, v in ipairs(equipMo) do
			if bestSuitMoList[v:getSuitType()] then
				local targetMo = bestSuitMoList[v:getSuitType()][v:getPosType()]

				if targetMo and (targetMo:getQuality() > v:getQuality() or targetMo:getQuality() == v:getQuality() and targetMo:getZdl() > v:getZdl()) then
					result[v:getPosType()] = targetMo
				end
			end
		end
	end

	return result
end

function HolyStripeController:_calculateBest4And1(bestSuitMoList, bestMoList, recommenonIds, maxZdl, result)
	local suitIds = {}

	for i, v in ipairs(recommenonIds) do
		if bestSuitMoList[v] and bestSuitMoList[v].totalNum >= 4 then
			table.insert(suitIds, v)
		end
	end

	for i, suitId in ipairs(suitIds) do
		for bestPos = 1, 5 do
			local tempResult = {}
			local tempZdl = 0

			tempResult[bestPos] = bestMoList[bestPos]

			if bestMoList[bestPos] then
				tempZdl = tempZdl + bestMoList[bestPos]:getZdl()
			end

			for j = 1, 4 do
				local index = j

				if bestPos <= index then
					index = index + 1
				end

				tempResult[index] = bestSuitMoList[suitId][index]

				if bestSuitMoList[suitId][index] then
					tempZdl = tempZdl + bestSuitMoList[suitId][index]:getZdl()
				else
					tempZdl = 0

					break
				end
			end

			if maxZdl < tempZdl then
				result = tempResult
				maxZdl = tempZdl
			end
		end
	end

	return maxZdl, result
end

function HolyStripeController:_calculateBest2And2(bestSuitMoList, bestMoList, recommenonIds, maxZdl, result)
	local compareSuitIds = {}

	for i, v in ipairs(recommenonIds) do
		if bestSuitMoList[v] and bestSuitMoList[v].totalNum >= 2 then
			table.insert(compareSuitIds, v)
		end
	end

	if #compareSuitIds < 2 then
		return maxZdl, result
	end

	for i = 1, #compareSuitIds - 1 do
		for j = i + 1, #compareSuitIds do
			maxZdl, result = self:_calculate2And2Between2Suit(bestSuitMoList, bestMoList, compareSuitIds[i], compareSuitIds[j], maxZdl, result)
		end
	end

	return maxZdl, result
end

function HolyStripeController:_calculateAll2And2(bestSuitMoList, bestMoList, recommenonIds, allSuitIds, maxZdl, result)
	local compareSuitIds = {}

	for i, v in ipairs(recommenonIds) do
		if bestSuitMoList[v] and bestSuitMoList[v].totalNum >= 2 then
			table.insert(compareSuitIds, v)
		end
	end

	if #compareSuitIds <= 0 then
		maxZdl, result = self:_calculateBest2And2(bestSuitMoList, bestMoList, allSuitIds, maxZdl, result)
	elseif #compareSuitIds == 1 then
		for i, v in ipairs(allSuitIds) do
			if v ~= compareSuitIds[1] then
				maxZdl, result = self:_calculate2And2Between2Suit(bestSuitMoList, bestMoList, compareSuitIds[1], v, maxZdl, result)
			end
		end
	else
		for i = 1, #compareSuitIds - 1 do
			for j = i + 1, #compareSuitIds do
				maxZdl, result = self:_calculate2And2Between2Suit(bestSuitMoList, bestMoList, compareSuitIds[i], compareSuitIds[j], maxZdl, result)
			end
		end
	end

	return maxZdl, result
end

function HolyStripeController:_calculate2And2Between2Suit(bestSuitMoList, bestMoList, suitAId, suitBId, maxZdl, result)
	local popList = Stack.New()

	for i = 1, bestSuitMoList[suitAId].totalNum - 1 do
		local tempResult = {}
		local tempZdl = 0
		local indexTempi = 1

		for pos = 1, 5 do
			if bestSuitMoList[suitAId][pos] then
				if indexTempi == i then
					popList:push(pos)

					tempResult[pos] = bestSuitMoList[suitAId][pos]

					break
				else
					indexTempi = indexTempi + 1
				end
			end
		end

		for j = 2, bestSuitMoList[suitAId].totalNum do
			local indexTempj = 1

			for pos = 1, 5 do
				if bestSuitMoList[suitAId][pos] then
					if indexTempj == j then
						popList:push(pos)

						tempResult[pos] = bestSuitMoList[suitAId][pos]

						break
					else
						indexTempj = indexTempj + 1
					end
				end
			end

			for p = 1, 3 do
				local indexTemq = 1
				local isEmpty = false

				for pos = 1, 5 do
					if not tempResult[pos] then
						if indexTemq == p then
							popList:push(pos)

							tempResult[pos] = bestMoList[pos]
						else
							if not bestSuitMoList[suitBId][pos] then
								isEmpty = true
							end

							popList:push(pos)

							tempResult[pos] = bestSuitMoList[suitBId][pos]
						end

						indexTemq = indexTemq + 1
					end
				end

				if isEmpty == false then
					for pos = 1, 5 do
						if tempResult[pos] then
							tempZdl = tempZdl + tempResult[pos]:getZdl()
						end
					end

					if maxZdl < tempZdl then
						for i, v in ipairs(tempResult) do
							result[i] = v
						end

						maxZdl = tempZdl
					end
				end

				tempResult[popList:pop()] = nil
				tempResult[popList:pop()] = nil
				tempResult[popList:pop()] = nil
			end

			tempResult[popList:pop()] = nil
		end

		tempResult[popList:pop()] = nil
	end

	return maxZdl, result
end

function HolyStripeController:_getBestHolyStripeFormUnequip(moList, orignBestSuitMoList, orignBestMoList, compareMoHandler)
	local bestSuitMoList = {}
	local bestMoList = {}

	if orignBestSuitMoList and orignBestMoList then
		bestSuitMoList = orignBestSuitMoList
		bestMoList = orignBestMoList
	end

	for i, mo in ipairs((not moList or nil) and HolyStripeModel.instance:getUnequipHolyStripeMo()) do
		if not bestSuitMoList[mo:getSuitType()] then
			bestSuitMoList[mo:getSuitType()] = {}
			bestSuitMoList[mo:getSuitType()].totalNum = 0
		end

		if not bestSuitMoList[mo:getSuitType()][mo:getPosType()] then
			bestSuitMoList[mo:getSuitType()][mo:getPosType()] = mo
			bestSuitMoList[mo:getSuitType()].totalNum = bestSuitMoList[mo:getSuitType()].totalNum + 1
		else
			local target = bestSuitMoList[mo:getSuitType()][mo:getPosType()]

			if compareMoHandler then
				if GameUtil.callBack(compareMoHandler, mo, target) == true then
					bestSuitMoList[mo:getSuitType()][mo:getPosType()] = mo
				end
			elseif mo:getQuality() > target:getQuality() then
				bestSuitMoList[mo:getSuitType()][mo:getPosType()] = mo
			elseif mo:getQuality() == target:getQuality() and mo:getZdl() > target:getZdl() then
				bestSuitMoList[mo:getSuitType()][mo:getPosType()] = mo
			end
		end

		if not bestMoList[mo:getPosType()] then
			bestMoList[mo:getPosType()] = mo
		else
			local target = bestMoList[mo:getPosType()]

			if compareMoHandler then
				if GameUtil.callBack(compareMoHandler, mo, target) == true then
					bestMoList[mo:getPosType()] = mo
				end
			elseif mo:getQuality() > target:getQuality() then
				bestMoList[mo:getPosType()] = mo
			elseif mo:getQuality() == target:getQuality() and mo:getZdl() > target:getZdl() then
				bestMoList[mo:getPosType()] = mo
			end
		end
	end

	return bestSuitMoList, bestMoList
end

function HolyStripeController:calcHolyStripeSuitWithPriority(moList, suitId, subPriority)
	local function compareMoHandler(moA, moB)
		local attrsA = moA:getAttrs()
		local attrsB = moB:getAttrs()
		local isAHeight = false

		isAHeight = moA:getZdl() == moB:getZdl() and moA:getId() < moB:getId() or moA:getZdl() > moB:getZdl()

		for i, attrName in ipairs(subPriority) do
			if checknumber(attrsA[attrName]) ~= checknumber(attrsB[attrName]) then
				isAHeight = checknumber(attrsA[attrName]) > checknumber(attrsB[attrName])

				break
			end
		end

		return isAHeight
	end

	local bestSuitMoList, bestMoList = self:_getBestHolyStripeFormUnequip(moList, nil, nil, GameUtil.handler(compareMoHandler))
	local maxAttrs = {}
	local maxResult = {}
	local maxZdl = 0

	if bestSuitMoList[suitId] then
		for bestPos = 1, 5 do
			local tempResult = {}
			local tempAttrs = {}
			local tempZdl = 0

			tempResult[bestPos] = bestMoList[bestPos]

			if bestMoList[bestPos] then
				AttrMo.addSameAttrs(tempAttrs, bestMoList[bestPos]:getAttrs())

				tempZdl = tempZdl + bestMoList[bestPos]:getZdl()
			end

			local isFind4Pos = true

			for j = 1, 4 do
				local index = j

				if bestPos <= index then
					index = index + 1
				end

				tempResult[index] = bestSuitMoList[suitId][index]

				if bestSuitMoList[suitId][index] then
					AttrMo.addSameAttrs(tempAttrs, bestSuitMoList[suitId][index]:getZdl())
				else
					isFind4Pos = false

					break
				end
			end

			if isFind4Pos == true then
				local isTempHeight = false

				if #maxResult > 0 then
					local isCheckAttr = false

					for i, attrName in ipairs(subPriority) do
						if checknumber(maxAttrs[attrName]) ~= checknumber(tempAttrs[attrName]) then
							isCheckAttr = true
							isTempHeight = checknumber(tempAttrs[attrName]) > checknumber(maxAttrs[attrName])

							break
						end
					end

					if isCheckAttr == false and maxZdl < tempZdl then
						isTempHeight = true
					end
				else
					isTempHeight = true
				end

				if isTempHeight == true then
					maxAttrs = tempAttrs
					maxResult = tempResult
					maxZdl = tempZdl
				end
			end
		end
	end

	return maxResult
end

function HolyStripeController:_getRecommenonIds(petId)
	local petMo = BagPetsController.instance:getPet(petId)
	local cfg = PetSkinConfig.instance:getPetSkinCfg(petMo and petMo.curFaceId)
	local recommenonNames = string.split((cfg or nil) and cfg.recmdHolystripeId, "、")
	local recommenonIds = {}

	for i, v in ipairs(recommenonNames) do
		table.insert(recommenonIds, HolyStripeConfig.instance:getSuitType(v))
	end

	return recommenonIds
end

function HolyStripeController:equipHolyStripes(petId, list)
	if self._isEquipHolyStripes == true then
		FloatWordMgr.instance:show(lang("正在切换灵纹中"))

		return
	end

	self._isEquipHolyStripes = true
	self._equipTempInfo = {
		petId = petId,
		holyStripes = list
	}

	self:_equipByTempList()
end

function HolyStripeController:_equipByTempList()
	if not self._isEquipHolyStripes or not self._equipTempInfo or not self._equipTempInfo.holyStripes or #self._equipTempInfo.holyStripes <= 0 then
		self._isEquipHolyStripes = nil
		self._equipTempInfo = nil

		GlobalDispatcher:dispatch(HolyStripeController.PM_HolyStripeEquipRes)

		return
	end

	local holyStripeId = table.remove(self._equipTempInfo.holyStripes)

	HolyStripeAgent.instance:sendPM_HolyStripeEquipReq(self._equipTempInfo.petId, holyStripeId)
end

function HolyStripeController:getIsEquipHolyStripes()
	return self._isEquipHolyStripes or false
end

function HolyStripeController:getAttrTypeByName(name)
	if self.attrNameMap == nil then
		self.attrNameMap = {}

		local cnt = #GameEnum.HolyStripeAttrTypeName

		for i = 1, cnt do
			local key = GameEnum.HolyStripeAttrTypeName[i]

			self.attrNameMap[key] = i
		end
	end

	return self.attrNameMap[name]
end

function HolyStripeController:getAttrNameValue(attr)
	local isNe = 1
	local startP, endP = string.find(attr, "+")

	if not startP then
		isNe = -1
		startP, endP = string.find(attr, "-")
	end

	if startP and endP then
		local attrName = string.sub(attr, 1, endP - 1)
		local attrVal = string.sub(attr, endP + 1, #attr)

		return attrName, self:strToNumber(attrVal) * isNe
	else
		return "", 0
	end
end

function HolyStripeController:strToNumber(attrVal)
	local startP, endP = string.find(attrVal, "%%")

	if startP then
		attrVal = string.sub(attrVal, 1, endP - 1)
		attrVal = checknumber(attrVal) / 100

		return attrVal
	end

	return tonumber(attrVal)
end

function HolyStripeController:parseAttrValues(str)
	if string.nilorempty(str) then
		return
	end

	local attrs = string.split(str, "#")
	local attrValues

	for i = 1, #attrs do
		local attrName, attrVal = self:getAttrNameValue(attrs[i])
		local attrType = self:getAttrTypeByName(attrName)

		if attrType then
			attrValues = attrValues or {}
			attrValues[attrType] = attrVal
		end
	end

	return attrValues
end

HolyStripeController.instance = HolyStripeController.New()

return HolyStripeController
