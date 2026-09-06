-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uniqueworld/controller/UniqueWorldController.lua

module("logic.extensions.uniqueworld.controller.UniqueWorldController", package.seeall)

local UniqueWorldController = class("UniqueWorldController", BaseController)

UniqueWorldController.posList = {
	9.7,
	18.6,
	0,
	37.1,
	0,
	0,
	52
}

function UniqueWorldController:sendPM_UniqueWorldGetInfoReq(activityId)
	UniqueWorldAgent.instance:sendPM_UniqueWorldGetInfoReq(activityId)
end

function UniqueWorldController:handlePM_UniqueWorldGetInfoRes(msg)
	UniqueWorldModel.instance:handlePM_UniqueWorldGetInfoRes(msg)

	local mapInfo = msg.mapInfo
	local gameInfo = mapInfo and mapInfo.gameInfo

	if gameInfo then
		if not gameInfo.leftCoin then
			local preLeftCoin = 0

			self:savePreCoinNum(preLeftCoin)
			GlobalDispatcher:dispatch(GlobalNotify.PM_UniqueWorldGetInfoRes)
		end
	end
end

function UniqueWorldController:sendPM_UniqueWorldNewGameReq(activityId)
	UniqueWorldAgent.instance:sendPM_UniqueWorldNewGameReq(activityId)
end

function UniqueWorldController:handlePM_UniqueWorldNewGameRes(msg)
	UniqueWorldModel.instance:handlePM_UniqueWorldNewGameRes(msg)
	UniqueWorldModel.instance:setCurGameIsOver(false)
	GlobalDispatcher:dispatch(GlobalNotify.PM_UniqueWorldNewGameRes)
end

function UniqueWorldController:sendPM_UniqueWorldMoveReq(activityId, targetGridId)
	UniqueWorldAgent.instance:sendPM_UniqueWorldMoveReq(activityId, targetGridId)
end

function UniqueWorldController:handlePM_UniqueWorldMoveRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_UniqueWorldMoveRes, msg.targetGridId)
end

function UniqueWorldController:sendPM_UniqueWorldDoEventReq(activityId, targetGridId, param)
	UniqueWorldAgent.instance:sendPM_UniqueWorldDoEventReq(activityId, targetGridId, param)
end

function UniqueWorldController:handlePM_UniqueWorldDoEventRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_UniqueWorldDoEventRes, msg.targetGridId)
end

function UniqueWorldController:handlePM_UniqueWorldMapChangeRes(msg)
	self:showChangeCoinWordBeforeUpdateData(msg)
	UniqueWorldModel.instance:handlePM_UniqueWorldMapChangeRes(msg)

	if msg.extParam == UniqueWorldEnum.ExtParam.GameEnd then
		UniqueWorldModel.instance:setCurGameIsOver(true)
	end

	self:trySaveChangeSetId(msg)
	self:tryPopTreasureBoxChangeSetId(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_UniqueWorldMapChangeRes, msg.extParam)
end

function UniqueWorldController:trySaveChangeSetId(msg)
	local changeSetId = checknumber(msg.changeSetId)

	if changeSetId > 0 then
		MaterialController.instance:saveChangeSetToTemp(changeSetId)
	end

	local activityId = msg.activityId
	local changeMapInfo = msg.changeMapInfo
	local fightGridList = changeMapInfo and changeMapInfo.fightGridList
	local extParam = msg.extParam
	local normalGridIdList = changeMapInfo and changeMapInfo.normalGridIdList

	if fightGridList and (extParam == UniqueWorldEnum.ExtParam.GameEnd or extParam == UniqueWorldEnum.ExtParam.FightWin) then
		local info = UniqueWorldModel.instance:getInfo(msg.activityId)
		local mapInfo = info and info.mapInfo
		local gameInfo = mapInfo and mapInfo.gameInfo

		if gameInfo then
			if not gameInfo.gameId then
				local gameId = 1

				if gameInfo then
					if not gameInfo.curLevel then
						local curLevel = 1
						local mapId = UniqueWorldConfig.instance:getMapId(msg.activityId, gameId, curLevel)

						for _, fightInfo in ipairs(fightGridList) do
							local gridId = fightInfo.gridId
							local mapCfg = UniqueWorldConfig.instance:getMapCfg(mapId, gridId)
							local eventId = mapCfg.eventId
							local fightEventCfg = UniqueWorldConfig.instance:getFightEventCfg(eventId)

							if fightEventCfg and not string.nilorempty(fightEventCfg.prize) then
								UniqueWorldModel.instance:setChangeSetId(msg.activityId, msg.changeSetId)
							end
						end
					end
				end
			end
		end
	end

	if normalGridIdList then
		local gameInfo = changeMapInfo and changeMapInfo.gameInfo
		local gameId = gameInfo.gameId
		local curLevel = gameInfo.curLevel
		local mapId = UniqueWorldConfig.instance:getMapId(activityId, gameId, curLevel)

		for i, info in ipairs(normalGridIdList) do
			local gridId = info.gridId
			local gridCfg = UniqueWorldConfig.instance:getMapCfg(mapId, gridId)

			if gridCfg.eventType == UniqueWorldEnum.GridType.TreasureBox then
				local eventId = gridCfg.eventId
				local boxCfg = UniqueWorldConfig.instance:getBoxEventCfg(eventId)
				local prize = boxCfg.prize

				if not string.nilorempty(prize) then
					UniqueWorldModel.instance:setChangeSetId(msg.activityId, msg.changeSetId)
				end
			end
		end
	end
end

function UniqueWorldController:sendPM_UniqueWorldUseItemReq(activityId, itemId, param)
	UniqueWorldAgent.instance:sendPM_UniqueWorldUseItemReq(activityId, itemId, param)
end

function UniqueWorldController:handlePM_UniqueWorldUseItemRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_UniqueWorldUseItemRes)
end

function UniqueWorldController:sendPM_UniqueWorldGiveUpReq(activityId)
	UniqueWorldAgent.instance:sendPM_UniqueWorldGiveUpReq(activityId)
end

function UniqueWorldController:handlePM_UniqueWorldGiveUpRes(msg)
	UniqueWorldModel.instance:handlePM_UniqueWorldGiveUpRes()
	GlobalDispatcher:dispatch(GlobalNotify.PM_UniqueWorldGiveUpRes)
end

function UniqueWorldController:sendPM_UniqueWorldFightReq(activityId, form, gridId)
	UniqueWorldAgent.instance:sendPM_UniqueWorldFightReq(activityId, form, gridId)
end

function UniqueWorldController:handlePM_UniqueWorldFightRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_UniqueWorldFightRes)
end

function UniqueWorldController:isEventType(type)
	return type == UniqueWorldEnum.GridType.TreasureBox or type == UniqueWorldEnum.GridType.DigMine or type == UniqueWorldEnum.GridType.Shop or type == UniqueWorldEnum.GridType.Barrier
end

function UniqueWorldController:isCanFinishType(type)
	return type == UniqueWorldEnum.GridType.TreasureBox or type == UniqueWorldEnum.GridType.DigMine or type == UniqueWorldEnum.GridType.NPCDialogue or type == UniqueWorldEnum.GridType.Challenge or type == UniqueWorldEnum.GridType.BossChallenge
end

function UniqueWorldController:getEffectList(effects)
	local list = {}

	if effects then
		local arr = string.split(effects, "&")

		for i, str in ipairs(arr) do
			local effectArr = string.split(str, "$")
			local effectNum = checknumber(effectArr[2])

			if effectNum ~= 0 then
				local tb = {
					effect = effectArr[1],
					num = effectNum
				}

				table.insert(list, tb)
			else
				local arr = string.split(effectArr[2], "#")
				local tb = {
					effect = effectArr[1],
					id = checknumber(arr[1]),
					num = checknumber(arr[2])
				}

				table.insert(list, tb)
			end
		end
	end

	return list
end

function UniqueWorldController:getOnFmtCreepsIdList(activityId)
	local customFmtMo = UniqueWorldModel.instance:getFmtMo(activityId)
	local formation = customFmtMo:getCurFormation()
	local positions = formation:GetPositions()
	local creepsIdList = {}

	for _, creepsId in ipairs(positions) do
		if creepsId > 0 then
			table.insert(creepsIdList, creepsId)
		end
	end

	return creepsIdList
end

function UniqueWorldController:savePreCoinNum(num)
	self._preCoinNum = num
end

function UniqueWorldController:enterBattleClg(activityId, levelId, gridId)
	local customFmtMo = UniqueWorldModel.instance:getFmtMo(activityId)

	customFmtMo:updateCfg(activityId, levelId, gridId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function UniqueWorldController:getBossWanPercentRate(activityId, levelId, gridId)
	local info = UniqueWorldModel.instance:getInfo(activityId)
	local creepMasterId = self:getCreepsMasterId(activityId, levelId, gridId)
	local creepsMasterCfgs = UniqueWorldConfig.instance:getCreepsCfg(creepMasterId)

	if creepsMasterCfgs then
		if not #creepsMasterCfgs then
			local petNum = 0
			local totalCurBossHp = petNum * 10000
			local totalBossHp = petNum * 10000

			if info then
				local mapInfo = info.mapInfo

				if mapInfo then
					if not mapInfo.fightGridList then
						for _, fightGridInfo in ipairs(mapInfo.fightGridList) do
							if gridId == fightGridInfo.gridId then
								if not fightGridInfo.creepsIdAndHpWanPercent then
									for _, pair in ipairs(fightGridInfo.creepsIdAndHpWanPercent) do
										local hpWanPercent = pair.right

										totalCurBossHp = totalCurBossHp - (10000 - hpWanPercent)
									end
								end
							end
						end
					end
				end
			end

			return totalCurBossHp / totalBossHp
		end
	end
end

function UniqueWorldController:getCurFloorPercent(activityId, floorId)
	local actCfg = UniqueWorldConfig.instance:getActCfg(activityId)
	local info = UniqueWorldModel.instance:getInfo(activityId)
	local mapInfo = info and info.mapInfo
	local gameInfo = mapInfo and mapInfo.gameInfo

	if gameInfo then
		if not gameInfo.gameId then
			local gameId = 1
			local levelPlanCfg = UniqueWorldConfig.instance:getLevelPlanCfgsById(activityId, gameId, floorId)
			local mapId = levelPlanCfg and levelPlanCfg.mapId
			local mapCfg = UniqueWorldConfig.instance:getMapCfgs(mapId)
			local finishMap = UniqueWorldModel.instance:getFinishGridMap(activityId)
			local totalEventNum = 0
			local finishEventNum = 0

			for _, cfg in ipairs(mapCfg) do
				if self:isCanFinishType(cfg.eventType) then
					totalEventNum = totalEventNum + 1

					if finishMap[cfg.gridId] then
						finishEventNum = finishEventNum + 1
					end
				end
			end

			if totalEventNum <= 0 then
				return 1
			end

			return finishEventNum / totalEventNum
		end
	end
end

function UniqueWorldController:canShowBoss(activityId, floorId)
	local finishMap = UniqueWorldModel.instance:getFinishGridMap(activityId)
	local actCfg = UniqueWorldConfig.instance:getActCfg(activityId)
	local info = UniqueWorldModel.instance:getInfo(activityId)
	local mapInfo = info and info.mapInfo
	local gameInfo = mapInfo and mapInfo.gameInfo

	if gameInfo then
		if not gameInfo.gameId then
			local gameId = 1
			local levelPlanCfg = UniqueWorldConfig.instance:getLevelPlanCfgsById(activityId, gameId, floorId)
			local mapId = levelPlanCfg and levelPlanCfg.mapId
			local mapCfgs = UniqueWorldConfig.instance:getMapCfgs(mapId)

			for _, cfg in ipairs(mapCfgs) do
				if cfg.eventType == UniqueWorldEnum.GridType.Challenge and not finishMap[cfg.gridId] then
					return false
				end
			end

			return true
		end
	end
end

function UniqueWorldController:isPetProp(effect)
	return effect == UniqueWorldEnum.EffectType.AddHp or effect == UniqueWorldEnum.EffectType.Recover
end

function UniqueWorldController:getCurLoseHpPetCreepsIdList(activityId)
	local creepsIdList = {}
	local petHpMap = UniqueWorldModel.instance:getPetHpMap(activityId)

	for creepsId, hpWanPercent in pairs(petHpMap) do
		if hpWanPercent < 10000 and hpWanPercent > 0 then
			table.insert(creepsIdList, creepsId)
		end
	end

	table.sort(creepsIdList, function(a, b)
		return petHpMap[a] < petHpMap[b]
	end)

	return creepsIdList
end

function UniqueWorldController:getCurDiePetCreepsIdList(activityId)
	local creepsIdList = {}
	local petHpMap = UniqueWorldModel.instance:getPetHpMap(activityId)

	for creepsId, hpWanPercent in pairs(petHpMap) do
		if hpWanPercent <= 0 then
			table.insert(creepsIdList, creepsId)
		end
	end

	return creepsIdList
end

function UniqueWorldController:hasPetToFight(activityId)
	local info = UniqueWorldModel.instance:getInfo(activityId)

	if info then
		if not info.mapInfo then
			local mapInfo = {}

			if not mapInfo.petList then
				local petList = {}

				return #petList > 0
			end
		end
	end
end

function UniqueWorldController:getCreepsMasterId(activityId, level, gridId)
	local info = UniqueWorldModel.instance:getInfo(activityId)
	local mapInfo = info and info.mapInfo
	local gameInfo = mapInfo and mapInfo.gameInfo

	if gameInfo then
		if not gameInfo.gameId then
			local gameId = 1
			local levelPlanCfg = UniqueWorldConfig.instance:getLevelPlanCfgsById(activityId, gameId, level)
			local mapId = levelPlanCfg and levelPlanCfg.mapId
			local gridCfg = UniqueWorldConfig.instance:getMapCfg(mapId, gridId)
			local eventId = gridCfg and gridCfg.eventId
			local fightEventCfg = UniqueWorldConfig.instance:getFightEventCfg(eventId)

			return fightEventCfg and fightEventCfg.creepsMasterId
		end
	end
end

function UniqueWorldController:showChangeCoinWordBeforeUpdateData(msg)
	local activityId = msg.activityId
	local itemMap = UniqueWorldModel.instance:getItemMap(activityId)
	local changeMapInfo = msg.changeMapInfo
	local gameInfo = changeMapInfo and changeMapInfo.gameInfo
	local itemList = changeMapInfo and changeMapInfo.itemList
	local leftCoin = gameInfo and checknumber(gameInfo.leftCoin) or 0
	local diffCoinNum = leftCoin - checknumber(self._preCoinNum)

	if diffCoinNum > 0 then
		local actCfg = UniqueWorldConfig.instance:getActCfg(activityId)
		local coinMatStr = actCfg.coinMatStr
		local matName = MaterialMgr.getMaterialsNameByCfg(coinMatStr)

		FloatWordMgr.instance:show(string.format(lang("获得【%s】×%s"), matName, diffCoinNum))
	end

	if itemList and #itemList > 0 then
		for i, item in ipairs(itemList) do
			local itemId = item.itemId
			local count = item.count
			local preNum = itemMap and checknumber(itemMap[itemId]) or 0
			local diffNum = count - preNum

			if diffNum > 0 then
				local itemCfg = UniqueWorldConfig.instance:getItemCfg(itemId)
				local itemName = itemCfg.name

				FloatWordMgr.instance:show(string.format(lang("获得【%s】×%s"), itemName, diffNum))
			end
		end
	end
end

function UniqueWorldController:tryPopTreasureBoxChangeSetId(msg)
	local activityId = msg.activityId
	local changeMapInfo = msg.changeMapInfo
	local gameInfo = changeMapInfo and changeMapInfo.gameInfo

	if gameInfo then
		if not gameInfo.gameId then
			local gameId = 1

			if gameInfo then
				if not gameInfo.curLevel then
					local curLevel = 1
					local normalGridIdList = changeMapInfo and changeMapInfo.normalGridIdList

					if normalGridIdList then
						local mapId = UniqueWorldConfig.instance:getMapId(activityId, gameId, curLevel)

						for i, info in ipairs(normalGridIdList) do
							local gridId = info.gridId
							local gridCfg = UniqueWorldConfig.instance:getMapCfg(mapId, gridId)

							if gridCfg.eventType == UniqueWorldEnum.GridType.TreasureBox then
								local eventId = gridCfg.eventId
								local boxCfg = UniqueWorldConfig.instance:getBoxEventCfg(eventId)
								local prize = boxCfg.prize

								if not string.nilorempty(prize) then
									local changeSetId = UniqueWorldModel.instance:popChangeSetId(activityId)

									while changeSetId do
										MaterialController.instance:showChangeSetInTemp(changeSetId)

										changeSetId = UniqueWorldModel.instance:popChangeSetId(activityId)
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function UniqueWorldController:getCurHasPropList(activityId)
	local itemMap = UniqueWorldModel.instance:getItemMap(activityId)
	local info = UniqueWorldModel.instance:getInfo(activityId)
	local mapInfo = info and info.mapInfo
	local itemList = mapInfo and mapInfo.itemList

	itemList = itemList or {}

	local curProp = {}

	for i, propItem in ipairs(itemList) do
		local itemId = propItem.itemId
		local itemNum = checknumber(itemMap[itemId])

		if itemNum > 0 then
			table.insert(curProp, propItem)
		end
	end

	return curProp
end

function UniqueWorldController:getCurUsePropDesc(activityId)
	local desc
	local buffMap = UniqueWorldModel.instance:getBuffMap(activityId)
	local usePropList = {}

	for buffDefineId, buffInfo in pairs(buffMap) do
		local leftEffectTimes = buffInfo.leftEffectTimes

		if leftEffectTimes > 0 then
			table.insert(usePropList, buffInfo)
		end
	end

	if #usePropList > 0 then
		desc = lang("当前生效道具:")

		for i, buffInfo in ipairs(usePropList) do
			local buffDefineId = buffInfo.buffDefineId
			local buffCfg = UniqueWorldConfig.instance:getBuffCfgById(buffDefineId)

			if buffCfg then
				if not buffCfg.itemId then
					local itemId = 1
					local itemCfg = UniqueWorldConfig.instance:getItemCfg(itemId)
					local itemName = itemCfg.name

					desc = i < #usePropList and desc .. string.format("%s×%s、", itemName, buffInfo.leftEffectTimes) or desc .. string.format("%s×%s", itemName, buffInfo.leftEffectTimes)
				end
			end
		end
	end

	return desc
end

function UniqueWorldController:getSortShopCfg(activityId, eventId)
	local shopCfgs = UniqueWorldConfig.instance:getShopCfgs(eventId)
	local copyCfgs = TableUtil.deepcopy(shopCfgs)
	local opt = {
		ArraySort.DESCENDING
	}
	local shopList = UniqueWorldModel.instance:getShopList(activityId)
	local petHpMap = UniqueWorldModel.instance:getPetHpMap(activityId)
	local info = UniqueWorldModel.instance:getInfo(activityId)
	local mapInfo = info and info.mapInfo
	local gameInfo = mapInfo and mapInfo.gameInfo

	if gameInfo then
		if not gameInfo.leftCoin then
			local curCoinNum = 0
			local names = {
				function(data)
					local effects = data.effects
					local effectList = UniqueWorldController.instance:getEffectList(effects)
					local effectTb

					if #effectList > 0 then
						effectTb = effectList[1]
					end

					local isPet = false
					local isItem = false
					local id = 0
					local num = 0

					if effectTb then
						if effectTb.effect == UniqueWorldEnum.EffectType.AddPet then
							isPet = true
							id = effectTb.num
						elseif effectTb.effect == UniqueWorldEnum.EffectType.AddItem then
							isItem = true
							id = effectTb.id
							num = effectTb.num
						end
					end

					local hasBuy = table.indexof(shopList, data.shopItemId)
					local hasThisPet = petHpMap[id] ~= nil
					local canBuy = curCoinNum >= data.costCoin

					if hasBuy or hasThisPet or not canBuy then
						return 0
					else
						return 1
					end
				end
			}

			ArraySort.sortOn(copyCfgs, names, opt)

			return copyCfgs
		end
	end
end

UniqueWorldController.instance = UniqueWorldController.New()

return UniqueWorldController
