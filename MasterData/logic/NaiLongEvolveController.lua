-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailongevolve/controller/NaiLongEvolveController.lua

module("logic.extensions.nailongevolve.controller.NaiLongEvolveController", package.seeall)

local NaiLongEvolveController = class("NaiLongEvolveController", BaseController)

function NaiLongEvolveController:getSkinId(activityId)
	return NaiLongEvolveConfig.instance:getSkinId(activityId)
end

function NaiLongEvolveController:getRaceId(activityId)
	return PetSkinConfig.instance:getPetSkinRaceId(self:getSkinId(activityId))
end

function NaiLongEvolveController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function NaiLongEvolveController:sendPM_MilkDragonClgGetInfoReq(activityId)
	NaiLongEvolveAgent.instance:sendPM_MilkDragonClgGetInfoReq(activityId)
end

function NaiLongEvolveController:handlePM_MilkDragonClgGetInfoRes(msg)
	NaiLongEvolveModel.instance:handlePM_MilkDragonClgGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MilkDragonClgGetInfoRes)
end

function NaiLongEvolveController:sendPM_MilkDragonClgSignInReq(activityId)
	NaiLongEvolveAgent.instance:sendPM_MilkDragonClgSignInReq(activityId)
end

function NaiLongEvolveController:handlePM_MilkDragonClgSignInRes(msg)
	NaiLongEvolveModel.instance:handlePM_MilkDragonClgSignInRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MilkDragonClgSignInRes)
end

function NaiLongEvolveController:sendPM_MilkDragonClgPosLvlUpReq(activityId, posType)
	NaiLongEvolveAgent.instance:sendPM_MilkDragonClgPosLvlUpReq(activityId, posType)
end

function NaiLongEvolveController:handlePM_MilkDragonClgPosLvlUpRes(msg)
	NaiLongEvolveModel.instance:handlePM_MilkDragonClgPosLvlUpRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MilkDragonClgPosLvlUpRes)
end

function NaiLongEvolveController:sendPM_MilkDragonClgResetPosLvlReq(activityId)
	NaiLongEvolveAgent.instance:sendPM_MilkDragonClgResetPosLvlReq(activityId)
end

function NaiLongEvolveController:handlePM_MilkDragonClgResetPosLvlRes(msg)
	NaiLongEvolveModel.instance:handlePM_MilkDragonClgResetPosLvlRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MilkDragonClgResetPosLvlRes)
end

function NaiLongEvolveController:sendPM_MilkDragonFightReq(activityId, form)
	NaiLongEvolveAgent.instance:sendPM_MilkDragonFightReq(activityId, form)
end

function NaiLongEvolveController:handlePM_NotifyMilkDragonFightEndRes(msg)
	NaiLongEvolveModel.instance:handlePM_NotifyMilkDragonFightEndRes(msg)

	if msg.changeSetId then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)

		local stageData = NaiLongEvolveConfig.instance:getStageDataByStageId(msg.activityId, msg.curFightStageId)

		if stageData.passAddScore > 0 then
			local fakeMatStr = self:_getFakeItemStr(msg.activityId, msg.curFightStageId)

			BattleSettlementModel.instance:setFakeMatStrList(fakeMatStr)
		end
	end

	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onResFightEnd, self, msg))
	GlobalDispatcher:dispatch(GlobalNotify.PM_NotifyMilkDragonFightEndRes)
end

function NaiLongEvolveController:_onResFightEnd(msg)
	local winId = NaiLongEvolveConfig.instance:getWinId(msg.activityId, msg.curFightStageId)
	local conditionType = BattleModel.instance:getConditionType()

	if winId >= 211 and winId <= 219 and conditionType == GameEnum.Evaluate.Combination then
		local winnerOpCfg = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(winId)
		local conditionParams = BattleModel.instance:getConditionParams()
		local jConditionParams = GameUtil.jsonToTable(conditionParams)
		local battleWinOpParams = winnerOpCfg.params
		local arr = string.split(battleWinOpParams, "&")

		for i, str in ipairs(arr) do
			local winId = checknumber(str)

			if winId == 0 then
				local arr = string.split(str, "|")
				local winIds = {}

				for i, str in ipairs(arr) do
					if string.find(str, "%(") then
						local arr2 = string.split(str, "(")

						table.insert(winIds, checknumber(arr2[2]))
					elseif string.find(str, "%)") then
						local arr2 = string.split(str, ")")

						table.insert(winIds, checknumber(arr2[1]))
					end
				end

				if #winIds > 0 then
					local isReach = false
					local cfgWinnerOp1 = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(checknumber(winIds[1]))
					local cfgWinnerOp2 = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(checknumber(winIds[2]))
					local cfgWinnerOpType1 = BattleSettlementConfig.instance:getBattleWinnerOpTypeCfgByType(cfgWinnerOp1.type)
					local cfgWinnerOpType2 = BattleSettlementConfig.instance:getBattleWinnerOpTypeCfgByType(cfgWinnerOp2.type)
					local paramName1 = cfgWinnerOpType1.paramNames[1]
					local paramName2 = cfgWinnerOpType2.paramNames[1]
					local desc1 = cfgWinnerOp1.desc
					local desc2 = cfgWinnerOp2.desc
					local txtDesc = desc1 .. "或" .. desc2

					if msg.win then
						isReach = true
					elseif self:_allEnemyIsDead(msg.activityId, msg.curFightStageId) then
						isReach = false
					else
						local paramList1 = string.split(cfgWinnerOp1.params, ",")
						local goalNum1 = checknumber(paramList1[2])
						local paramList2 = string.split(cfgWinnerOp2.params, ",")
						local goalNum2 = checknumber(paramList2[2])
						local json1 = jConditionParams[winIds[1] .. ""]
						local json2 = jConditionParams[winIds[2] .. ""]
						local jsonTable1 = GameUtil.jsonToTable(json1)
						local jsonTable2 = GameUtil.jsonToTable(json2)
						local finalNum1 = checknumber(jsonTable1[paramName1])
						local finalNum2 = checknumber(jsonTable2[paramName2])

						isReach = goalNum1 <= finalNum1 or goalNum2 <= finalNum2
					end

					BattleSettlementController.instance:addConditionElement(txtDesc, isReach)
				end
			else
				for id, singleConditionParam in pairs(jConditionParams) do
					if checknumber(id) == winId then
						if checknumber(id) == 165 then
							local cfgWinnerOp = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(winId)
							local cfg = BattleSettlementConfig.instance:getBattleWinnerOpTypeCfgByType(cfgWinnerOp.type)
							local conditionParams = BattleModel.instance:getConditionParams()

							self:addCommonCondition(msg.activityId, msg.curFightStageId)
						elseif checknumber(id) >= 208 and checknumber(id) <= 210 then
							local cfgWinnerOp = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(checknumber(id))

							if cfgWinnerOp then
								self:addSpecialCondition(cfgWinnerOp.type, singleConditionParam, cfgWinnerOp.params, cfgWinnerOp.desc)
							end
						end
					end
				end
			end
		end
	else
		BattleSettlementController.instance:addDefaultConditions()
	end

	if msg.win then
		UIStateManager.instance:open(ViewName.BattleSettlementSuccess)
	else
		UIStateManager.instance:open(ViewName.BattleSettlementFail)
	end

	return true
end

function NaiLongEvolveController:enterBattleClg(activityId, stageId)
	local customFmtMo = NaiLongEvolveModel.instance:getFmtMo(activityId)

	customFmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function NaiLongEvolveController:_condictionIsReachAndGetCondiction(conditionType, conditionParams, conditionTypeParams)
	local cfg = BattleSettlementConfig.instance:getBattleWinnerOpTypeCfgByType(conditionType)

	if cfg then
		local jConditionParams = GameUtil.jsonToTable(conditionParams)
		local cfgStr = conditionTypeParams
		local arr = string.split(cfgStr, ",")
		local goalScore = checknumber(arr[2])
		local curNum = checknumber((cfg.paramNames and cfg.paramNames[1] and jConditionParams and jConditionParams[cfg.paramNames[1]] or nil) and jConditionParams[cfg.paramNames[1]])

		return goalScore <= curNum, goalScore
	end
end

function NaiLongEvolveController:getCurchanllengeId(activityId)
	local info = NaiLongEvolveModel.instance:getInfo(activityId)
	local stageCfgs = NaiLongEvolveConfig.instance:getStageData(activityId)
	local curPassStageId = info.curPassStageId
	local stageNum = #stageCfgs

	if curPassStageId == stageNum then
		return curPassStageId
	end

	return curPassStageId + 1
end

function NaiLongEvolveController:isPass(activityId)
	local info = NaiLongEvolveModel.instance:getInfo(activityId)
	local stageCfgs = NaiLongEvolveConfig.instance:getStageData(activityId)
	local curPassStageId = info.curPassStageId
	local stageNum = #stageCfgs

	return stageNum <= curPassStageId
end

function NaiLongEvolveController:_getFakeItemStr(activityId, curFightStageId)
	local stageData = NaiLongEvolveConfig.instance:getStageDataByStageId(activityId, curFightStageId)
	local actData = NaiLongEvolveConfig.instance:getActData(activityId)
	local fakeItemStr = actData.scoreIcon

	fakeItemStr = fakeItemStr .. ":" .. stageData.passAddScore

	return fakeItemStr
end

function NaiLongEvolveController:getCurActiveAccuBuffIndex(activityId)
	local info = NaiLongEvolveModel.instance:getInfo(activityId)
	local accuBuffCfgs = NaiLongEvolveConfig.instance:getAccuBuffSortList(activityId)
	local consumedScore = info.consumedScore
	local activeIdx = 1

	for i, cfg in ipairs(accuBuffCfgs) do
		if consumedScore >= cfg.accScore then
			activeIdx = i
		end
	end

	return activeIdx
end

function NaiLongEvolveController:addCommonCondition()
	local enemys = BattleModel.instance:getEnemyUnits()
	local totalNum = 0
	local curNum = 0
	local isReach

	for k, v in pairs(enemys) do
		if not v.attrs.isFakePet() then
			totalNum = totalNum + 1

			if v.attrs:getCurHp() <= 0 then
				curNum = curNum + 1
			end
		end
	end

	isReach = totalNum <= curNum

	local color = self:_getColorStr(isReach)

	BattleSettlementController.instance:addConditionElement(string.format("击败敌阵全部精灵  <color=#%s>(%d/%d)</color>", color, curNum, totalNum), isReach)
end

function NaiLongEvolveController:addSpecialCondition(conditionType, conditionParams, conditionTypeParams, desc)
	local cfg = BattleSettlementConfig.instance:getBattleWinnerOpTypeCfgByType(conditionType)
	local element1 = {}

	element1.txtDesc = ""

	local jConditionParams = GameUtil.jsonToTable(conditionParams)
	local cfgStr = conditionTypeParams
	local curActNum = checknumber((cfg.paramNames and cfg.paramNames[1] and jConditionParams and jConditionParams[cfg.paramNames[1]] or nil) and jConditionParams[cfg.paramNames[1]])
	local arr = string.split(cfgStr, "_")
	local raceId = checknumber(arr[1])
	local goalRate = checknumber(arr[2])

	raceId = checknumber(raceId)

	local petData = CharacterConfig.instance:getPetCo(raceId)

	if petData then
		if not petData.name then
			local petName = ""
			local isReach = curActNum >= checknumber(goalRate)
			local color = self:_getColorStr(isReach)

			curActNum = curActNum <= 0 and 0 or math.floor(curActNum * 100)
			element1.txtDesc = string.format(cfg.desc, petName, goalRate * 100, color, curActNum, goalRate * 100)
			element1.isReach = isReach

			BattleSettlementController.instance:addConditionElement(element1.txtDesc, element1.isReach)
		end
	end
end

function NaiLongEvolveController:_getColorStr(bValue)
	return (bValue or nil) and (SettlementTarget.Colors.Sucess or SettlementTarget.Colors.Fail)
end

function NaiLongEvolveController:_allEnemyIsDead(activityId, stageId)
	local enemys = BattleModel.instance:getEnemyUnits()
	local totalNum = NaiLongEvolveConfig.instance:getEnemyNum(activityId, stageId)
	local curNum = 0
	local isReach

	for k, v in pairs(enemys) do
		if v.attrs:getCurHp() <= 0 then
			curNum = curNum + 1
		end
	end

	return totalNum <= curNum
end

NaiLongEvolveController.instance = NaiLongEvolveController.New()

return NaiLongEvolveController
