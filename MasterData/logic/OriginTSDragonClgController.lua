-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origintsdragonclg/controller/OriginTSDragonClgController.lua

module("logic.extensions.origintsdragonclg.controller.OriginTSDragonClgController", package.seeall)

local OriginTSDragonClgController = class("OriginTSDragonClgController", BaseController)

OriginTSDragonClgController.FULL_HP_VALUE = 10000
OriginTSDragonClgController.PuzType = {
	AllDirect = 1,
	Between = 2
}
OriginTSDragonClgController.DirectRotaZ = {
	Down = -90,
	Up = -270,
	LeftDown = -145,
	LeftUp = -210,
	Left = -180,
	RightUp = -330,
	RightDown = -32,
	Right = 0
}
OriginTSDragonClgController.RowNum = 3
OriginTSDragonClgController.ColNum = 3

function OriginTSDragonClgController:ctor()
	return
end

function OriginTSDragonClgController:onInit()
	self:onReset()
end

function OriginTSDragonClgController:onReset()
	return
end

function OriginTSDragonClgController:sendPM_OriginTSDragonClgInfoReq(activityId)
	OriginTSDragonClgAgent.instance:sendPM_OriginTSDragonClgInfoReq(activityId)
end

function OriginTSDragonClgController:handlePM_OriginTSDragonClgInfoRes(msg)
	OriginTSDragonClgModel.instance:handlePM_OriginTSDragonClgInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginTSDragonClgInfoRes)
end

function OriginTSDragonClgController:sendPM_OriginTSDragonChallengeReq(activityId, phaseId, stageId, simpleForm, puzzleId)
	OriginTSDragonClgAgent.instance:sendPM_OriginTSDragonChallengeReq(activityId, phaseId, stageId, simpleForm, puzzleId)
end

function OriginTSDragonClgController:handlePM_OriginTSDragonChallengeRes(msg)
	OriginTSDragonClgModel.instance:handlePM_OriginTSDragonChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginTSDragonChallengeRes, msg)
end

function OriginTSDragonClgController:sendPM_OriginTSDragonConfirmReq(activityId, phaseId, stageId, save)
	OriginTSDragonClgAgent.instance:sendPM_OriginTSDragonConfirmReq(activityId, phaseId, stageId, save)
end

function OriginTSDragonClgController:handlePM_OriginTSDragonConfirmRes(msg)
	OriginTSDragonClgModel.instance:handlePM_OriginTSDragonConfirmRes(msg)

	if msg.changeSetId then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginTSDragonConfirmRes, msg)
end

function OriginTSDragonClgController:sendPM_OriginTSDragonResetReq(activityId)
	OriginTSDragonClgAgent.instance:sendPM_OriginTSDragonResetReq(activityId)
end

function OriginTSDragonClgController:handlePM_OriginTSDragonResetRes(msg)
	OriginTSDragonClgModel.instance:handlePM_OriginTSDragonResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginTSDragonResetRes)
end

function OriginTSDragonClgController:handlePM_NotifyTSDragonChallengeFinishRes(msg)
	OriginTSDragonClgModel.instance:handlePM_NotifyTSDragonChallengeFinishRes(msg)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onResFightEnd, self, msg))
end

function OriginTSDragonClgController:_onResFightEnd(msg)
	BattleFacade.instance:registerResultHandler(nil, nil)
	UIStateManager.instance:push(ViewName.OriginTSDragonClgFightEndView, GameUtil.pbToTable(msg))

	return true
end

function OriginTSDragonClgController:enterBattleClg(activityId, phaseId, stageId)
	local customFmtMo = OriginTSDragonClgModel.instance:getFmtMo(activityId)

	customFmtMo:updateCfg(activityId, phaseId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function OriginTSDragonClgController:getDiePetRaceIdMap(activityId)
	local petInfoHpMap = OriginTSDragonClgModel.instance:getPetInfoMaps(activityId)
	local raceIdMap = {}

	if petInfoHpMap then
		for petId, hp in pairs(petInfoHpMap) do
			if hp <= 0 then
				local bagPet = BagPetsController.instance:getPet(petId)

				if bagPet then
					local raceId = bagPet.raceId

					raceIdMap[raceId] = true
				end
			end
		end
	end

	return raceIdMap
end

function OriginTSDragonClgController:getPassConditionList(activityId, phaseId, stageId, isWin)
	local creepsMasterId = OriginTSDragonClgConfig.instance:getCreepMasterId(activityId, phaseId, stageId)
	local masterCfg = OriginTSDragonClgConfig.instance:getMasterCfg(creepsMasterId)
	local creepsCfgs = OriginTSDragonClgConfig.instance:getCreepCfg(creepsMasterId)

	if masterCfg then
		if not masterCfg.winId then
			local winId = 0
			local conditionList = {}
			local battleResultData = BattleModel.instance:hasReceivedResult()
			local conditionParams = battleResultData.conditionParams
			local totalEnemyNum = 0

			for i, cfg in ipairs(creepsCfgs) do
				if cfg.posId > 0 then
					totalEnemyNum = totalEnemyNum + 1
				end
			end

			local numDesc = lang("击败敌阵所有敌人(<color=%s>%s/%s</color>)")

			if winId > 0 then
				local jsonTable = GameUtil.jsonToTable(conditionParams)
				local winnerOpCfg = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(winId)

				if winnerOpCfg.type == "Combination" then
					local params = winnerOpCfg.params
					local paramArr = string.split(params, "&")

					for i, curWinId in ipairs(paramArr) do
						local curCfg = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(checknumber(curWinId))

						if curCfg.type == "BuffNum" then
							local hasNum = jsonTable.buffNum
							local targetNum = curCfg and curCfg.params
							local hasPass = targetNum <= hasNum
							local winDesc = string.format(curCfg.desc, curCfg.params, (hasPass or nil) and "green", hasNum, targetNum)
							local tb = {
								desc = winDesc,
								pass = hasPass
							}

							table.insert(conditionList, tb)
						elseif curCfg.type == GameEnum.Evaluate.EnemyActiveLessThanCount then
							local hasAliveNum = checknumber(jsonTable.enemyActiveLessThanCount)
							local isLessWin = hasAliveNum <= 0

							if checknumber(curCfg.params) <= 0 then
								local tb = {
									desc = langPara("击败敌阵所有敌人"),
									pass = isLessWin
								}

								table.insert(conditionList, tb)
							else
								local resultDesc = BattleSettlementController.instance:getDescByWinId(checknumber(curWinId))
								local tb = {
									desc = resultDesc,
									pass = isLessWin
								}

								table.insert(conditionList, tb)
							end
						else
							local resultDesc = BattleSettlementController.instance:getDescByWinId(checknumber(curWinId))
							local tb = {
								desc = resultDesc,
								pass = isWin
							}

							table.insert(conditionList, tb)
						end
					end
				else
					local resultDesc = BattleSettlementController.instance:getDescByWinId(checknumber(winId))
					local tb = {
						desc = resultDesc,
						pass = isWin
					}

					table.insert(conditionList, tb)
				end
			else
				local tb = {
					desc = langPara("击败敌阵所有敌人"),
					pass = isWin
				}

				table.insert(conditionList, tb)
			end

			return conditionList
		end
	end
end

function OriginTSDragonClgController:saveCurPointerMap(pointedMap)
	self._pointedMap = pointedMap
end

function OriginTSDragonClgController:getCurPointerMap()
	return self._pointedMap
end

function OriginTSDragonClgController:isAllPass(activityId)
	return OriginTSDragonClgModel.instance:isGainPrize(activityId)
end

function OriginTSDragonClgController:getActivePuzzleIds(activityId, phaseId, stageId)
	local ids = {}

	for i = -1, 1 do
		for j = -1, 1 do
			local puzzleId = OriginTSDragonClgModel.instance:getUsePuzId(activityId, phaseId + i, stageId + j)

			if checknumber(puzzleId) ~= 0 then
				local puzzleCfg = OriginTSDragonClgConfig.instance:getPuzzleCfg(activityId, phaseId + i, puzzleId)

				if puzzleCfg and (puzzleCfg.puzzleType == OriginTSDragonClgController.PuzType.AllDirect or puzzleCfg.puzzleType == OriginTSDragonClgController.PuzType.Between and phaseId == phaseId + i) then
					table.insert(ids, {
						phaseId = phaseId + i,
						puzzleId = puzzleId
					})
				end
			end
		end
	end

	return ids
end

OriginTSDragonClgController.instance = OriginTSDragonClgController.New()

return OriginTSDragonClgController
