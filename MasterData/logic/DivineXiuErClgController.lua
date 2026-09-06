-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/controller/DivineXiuErClgController.lua

module("logic.extensions.divinexiuerclg.controller.DivineXiuErClgController", package.seeall)

local DivineXiuErClgController = class("DivineXiuErClgController", BaseController)

function DivineXiuErClgController:ctor()
	return
end

function DivineXiuErClgController:onInit()
	return
end

function DivineXiuErClgController:onReset()
	return
end

function DivineXiuErClgController:sendPM_DivineXiuErClgGetInfoReq(activityId)
	DivineXiuErClgAgent.instance:sendPM_DivineXiuErClgGetInfoReq(activityId)
end

function DivineXiuErClgController:handlePM_DivineXiuErClgGetInfoRes(msg)
	local mo = self:getDxecMo(msg.activityId)

	mo:handlePM_DivineXiuErClgGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_DivineXiuErClgGetInfoRes)
end

function DivineXiuErClgController:sendPM_DivineXiuErClgNormalFightReq(activityId, groupId, dataBitId, form)
	BattleFacade.instance:startDivineXiuErClgNorBattle(activityId, groupId, dataBitId)
	DivineXiuErClgAgent.instance:sendPM_DivineXiuErClgNormalFightReq(activityId, dataBitId, form)
end

function DivineXiuErClgController:handlePM_DivineXiuErClgNormalFightRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_DivineXiuErClgNormalFightRes)
end

function DivineXiuErClgController:handlePM_DivineXiuErClgNotifyNormalFightResultRes(msg)
	local mo = self:getDxecMo(msg.activityId)

	mo:handlePM_DivineXiuErClgNotifyNormalFightResultRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_DivineXiuErClgNotifyNormalFightResultRes)
end

function DivineXiuErClgController:sendPM_DivineXiuErClgExtremeFightReq(activityId, tierId, dataBitId, form)
	BattleFacade.instance:startDivineXiuErClgExtBattle(activityId, tierId, dataBitId)
	DivineXiuErClgAgent.instance:sendPM_DivineXiuErClgExtremeFightReq(activityId, dataBitId, form)
end

function DivineXiuErClgController:handlePM_DivineXiuErClgExtremeFightRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_DivineXiuErClgExtremeFightRes)
end

function DivineXiuErClgController:handlePM_DivineXiuErClgNotifyExtremeFightResultRes(msg)
	local mo = self:getDxecMo(msg.activityId)

	mo:handlePM_DivineXiuErClgNotifyExtremeFightResultRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_DivineXiuErClgNotifyExtremeFightResultRes)
end

function DivineXiuErClgController:sendPM_DivineXiuErExtremeFightConfirmReq(activityId, confirmNum, save)
	DivineXiuErClgAgent.instance:sendPM_DivineXiuErExtremeFightConfirmReq(activityId, confirmNum, save)
end

function DivineXiuErClgController:handlePM_DivineXiuErExtremeFightConfirmRes(msg)
	local mo = self:getDxecMo(msg.activityId)

	mo:handlePM_DivineXiuErExtremeFightConfirmRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_DivineXiuErExtremeFightConfirmRes)
end

function DivineXiuErClgController:sendPM_DivineXiuErResetExtremeClgStageReq(activityId, dataBitId)
	DivineXiuErClgAgent.instance:sendPM_DivineXiuErResetExtremeClgStageReq(activityId, dataBitId)
end

function DivineXiuErClgController:handlePM_DivineXiuErResetExtremeClgStageRes(msg)
	local mo = self:getDxecMo(msg.activityId)

	mo:handlePM_DivineXiuErResetExtremeClgStageRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_DivineXiuErResetExtremeClgStageRes)
end

function DivineXiuErClgController:sendPM_DivineXiuErGainNormalClgPrizeReq(activityId)
	DivineXiuErClgAgent.instance:sendPM_DivineXiuErGainNormalClgPrizeReq(activityId)
end

function DivineXiuErClgController:handlePM_DivineXiuErGainNormalClgPrizeRes(msg)
	local mo = self:getDxecMo(msg.activityId)

	mo:handlePM_DivineXiuErGainNormalClgPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_DivineXiuErGainNormalClgPrizeRes)
end

function DivineXiuErClgController:sendPM_DivineXiuErGainExtremeClgPrizeReq(activityId)
	DivineXiuErClgAgent.instance:sendPM_DivineXiuErGainExtremeClgPrizeReq(activityId)
end

function DivineXiuErClgController:handlePM_DivineXiuErGainExtremeClgPrizeRes(msg)
	local mo = self:getDxecMo(msg.activityId)

	mo:handlePM_DivineXiuErGainExtremeClgPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_DivineXiuErGainExtremeClgPrizeRes)
end

function DivineXiuErClgController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function DivineXiuErClgController:getActivityType()
	return GameEnum.ActivityType.DivineXiuErClg
end

function DivineXiuErClgController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function DivineXiuErClgController:getRaceId(activityId)
	return PetSkinConfig.instance:getPetSkinRaceId(self:getSkinId(activityId))
end

function DivineXiuErClgController:getSkinId(activityId)
	return DivineXiuErClgConfig.instance:getDxecCommonValue(activityId, "skinId")
end

function DivineXiuErClgController:getDxecMo(activityId)
	return DivineXiuErClgModel.instance:getDxecMo(activityId)
end

function DivineXiuErClgController:enterBattleOfNorClg(activityId, groupId, dataBitId)
	local customFmtMo = DivineXiuErClgModel.instance:getDxecCustomFmtMoOfNor(activityId)

	customFmtMo:updateCfg(activityId, groupId, dataBitId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DivineXiuErClgController:enterBattleOfExtClg(activityId, tierId, dataBitId)
	local tierData = DivineXiuErClgConfig.instance:getDxecExtTierData(activityId, tierId)
	local tierType = tierData.tierType
	local customFmtMo

	if tierType == DxecEnum.TierType_NpStage then
		customFmtMo = DivineXiuErClgModel.instance:getDxecCustomFmtMoOfExtNpStage(activityId)
	elseif tierType == DxecEnum.TierType_TfStage then
		customFmtMo = DivineXiuErClgModel.instance:getDxecCustomFmtMoOfExtTfStage(activityId)
	end

	if customFmtMo then
		customFmtMo:updateCfg(activityId, tierId, dataBitId)
		CustomFmtController.instance:showMissionView(customFmtMo)
	end
end

function DivineXiuErClgController:enterDivineXiuErClgNorResultView(activityId, groupId, dataBitId)
	local mo = self:getDxecMo(activityId)
	local msg = mo:getFightResultResOfNor()

	if msg == nil then
		BattleController.instance:endBattle()
	elseif msg.win then
		local data = DivineXiuErClgConfig.instance:getDxecNorStageGroupData(activityId, groupId, dataBitId)
		local stageType = data.stageType
		local typeData = DivineXiuErClgConfig.instance:getDxecNorStageTypeData(activityId, stageType)
		local oldvalue = self:getStageScoreOfNor(activityId, dataBitId)
		local newValue = msg.curFightScore
		local info = {}

		function info.sureCallBack()
			BattleController.instance:endBattle()
		end

		info.isUp = oldvalue < newValue

		if info.isUp then
			info.oldValue = oldvalue
			info.newValue = newValue
			info.desc = typeData.stageClgResultDescOfUp
		else
			info.desc = typeData.stageClgResultDescOfDown
			info.curValue = oldvalue
		end

		ViewMgr.instance:open(ViewName.DivineXiuErClgNorSureView, info)
	else
		BattleController.instance:openSettlementView()
	end
end

function DivineXiuErClgController:enterDivineXiuErClgExtResultView(activityId, tierId, dataBitId)
	local tierData = DivineXiuErClgConfig.instance:getDxecExtTierData(activityId, tierId)
	local tierType = tierData.tierType

	if tierType == DxecEnum.TierType_NpStage then
		self:enterDivineXiuErClgExtNpStageResultView(activityId, tierId, dataBitId)
	elseif tierType == DxecEnum.TierType_TfStage then
		self:enterDivineXiuErClgExtTfStageResultView(activityId, tierId, dataBitId)
	end
end

function DivineXiuErClgController:enterDivineXiuErClgExtNpStageResultView(activityId, tierId, dataBitId)
	local mo = self:getDxecMo(activityId)
	local msg = mo:getFightResultResOfExt()
	local isWin = checkbool(msg.win)
	local stageData = DivineXiuErClgConfig.instance:getDxecExtStageData(activityId, tierId, dataBitId)
	local masterData = DivineXiuErClgConfig.instance:getDxecCreepsMasterData(stageData.creepsMasterId)
	local descInfoList

	if masterData.winId > 0 then
		descInfoList = self:getResultDescInfoListByMsg(isWin)

		for _, descInfo in ipairs(descInfoList) do
			if descInfo.resultType == GameEnum.Evaluate.KillNum then
				local winnerOpParams = descInfo.winnerOpParams
				local singleParam = descInfo.singleParam
				local value
				local typeData = BattleSettlementConfig.instance:getBattleWinnerOpTypeCfgByType(descInfo.resultType)
				local curKillNum = checknumber((typeData.paramNames and typeData.paramNames[1] and singleParam or nil) and singleParam[typeData.paramNames[1]])
				local needKillNum = checknumber(winnerOpParams)
				local isReach = needKillNum <= curKillNum
				local color = self:_getColorStr(isReach)

				descInfo.isReach = isReach
				descInfo.desc = string.format("至少击杀敌阵精灵  <color=#%s>(%d/%d)</color>", color, curKillNum, needKillNum)
			end
		end
	else
		descInfoList = {}

		table.insert(descInfoList, self:_getCommonResultDescInfo(isWin))
	end

	local info = {}

	info.isWin = isWin
	info.descInfoList = descInfoList

	function info.sureCallBack()
		BattleController.instance:endBattle()
	end

	ViewMgr.instance:open(ViewName.DivineXiuErClgExtParallelSureView, info)
end

function DivineXiuErClgController:enterDivineXiuErClgExtTfStageResultView(activityId, tierId, dataBitId)
	local mo = self:getDxecMo(activityId)
	local msg = mo:getFightResultResOfExt()

	if msg == nil then
		BattleController.instance:endBattle()
	elseif msg.win then
		local confirmNum = msg.confirmNum
		local info = {}

		info.activityId = activityId
		info.tierId = tierId
		info.dataBitId = dataBitId

		function info.sureCallBack()
			DivineXiuErClgController.instance:sendPM_DivineXiuErExtremeFightConfirmReq(activityId, confirmNum, true)
			BattleController.instance:endBattle()
		end

		function info.cancelCallBack()
			DivineXiuErClgController.instance:sendPM_DivineXiuErExtremeFightConfirmReq(activityId, confirmNum, false)
			BattleController.instance:endBattle()
		end

		ViewMgr.instance:open(ViewName.DivineXiuErClgExtTruefalseSureView, info)
	else
		BattleController.instance:openSettlementView()
	end
end

function DivineXiuErClgController:getResultDescInfoListByMsg(isWin)
	local descInfoList = {}
	local conditionType = BattleModel.instance:getConditionType()
	local conditionParamsJson = BattleModel.instance:getConditionParams()
	local conditionParams = GameUtil.jsonToTable(conditionParamsJson)

	if not string.nilorempty(conditionType) then
		if conditionType == GameEnum.Evaluate.Combination then
			for winId, singleParamJson in pairs(conditionParams) do
				local singleParam = GameUtil.jsonToTable(singleParamJson)

				winId = checknumber(winId)

				local list = self:getResultDescListByWinId(winId, singleParam)

				table.insertto(descInfoList, list)
			end
		elseif conditionType == GameEnum.Evaluate.BuffNum or conditionType == GameEnum.Evaluate.EnemyBuffNum then
			local descInfo = self:_getCommonResultDescInfo(isWin)

			table.insert(descInfoList, descInfo)
		else
			local conditionTypeParams = BattleModel.instance:getConditionTypeParams()
			local descInfo = self:_getResultDescInfoByParam(conditionType, conditionTypeParams, conditionParams)

			table.insert(descInfoList, descInfo)
		end
	else
		local descInfo = self:_getCommonResultDescInfo(isWin)

		table.insert(descInfoList, descInfo)
	end

	return descInfoList
end

function DivineXiuErClgController:getResultDescListByWinId(winId, singleParam)
	local descInfoList = {}
	local winIdQueue = Array.New()

	winIdQueue:PushBack(winId)

	while winIdQueue:GetSize() > 0 do
		local id = winIdQueue:PopFront()
		local opData = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(id)
		local resultType = opData.type
		local typeData = BattleSettlementConfig.instance:getBattleWinnerOpTypeCfgByType(resultType)

		if resultType == GameEnum.Evaluate.Combination then
			local arr = string.split(opData.params, "&")

			for i, v in ipairs(arr) do
				winIdQueue:PushBack(checknumber(v))
			end
		else
			local descInfo = self:_getResultDescInfoByParam(resultType, opData.params, singleParam)

			if descInfo then
				table.insert(descInfoList, descInfo)
			end
		end
	end

	return descInfoList
end

function DivineXiuErClgController:_getResultDescInfoByParam(resultType, winnerOpParams, singleParam)
	local typeData = BattleSettlementConfig.instance:getBattleWinnerOpTypeCfgByType(resultType)

	if typeData == nil then
		printError(string.format("战斗结算缺失配置显示( z战前处理.xlsx | export_战斗结算类型 | resultType=%s )", resultType))

		return
	end

	local value

	if typeData.paramNames and typeData.paramNames[1] and singleParam then
		value = singleParam[typeData.paramNames[1]]
	end

	local descStr = ""
	local isReach = true
	local descFormat = typeData.desc

	if resultType == GameEnum.Evaluate.DamageTotal then
		descStr = string.format(descFormat, tostring(value))
	elseif resultType == GameEnum.Evaluate.MyActivePetContainsAttrs then
		local paramList = string.split(winnerOpParams, ",")

		if paramList and #paramList == 2 then
			descStr = string.format(descFormat, paramList[2], paramList[1])
		elseif paramList and #paramList > 2 then
			local strJoint = paramList[2]

			for i = 3, #paramList do
				strJoint = strJoint .. paramList[i]
			end

			descStr = string.format(descFormat, strJoint, paramList[1])
		else
			descStr = descFormat
		end
	elseif resultType == GameEnum.Evaluate.MyPosIdMustActive then
		local paramList = string.split(winnerOpParams, ",")
		local str = ""

		if paramList and #paramList > 0 then
			for i, v in ipairs(paramList) do
				str = str .. checknumber(v) + 1

				if i ~= #paramList then
					str = str .. ","
				end
			end
		end

		descStr = string.format(descFormat, str)
	elseif resultType == GameEnum.Evaluate.PosHpRate then
		local paramList = string.split(winnerOpParams, "_")

		descStr = paramList and #paramList == 2 and string.format(descFormat, paramList[1] + 1, checknumber(paramList[2]) * 100) or descFormat
	elseif resultType == GameEnum.Evaluate.DamageTotalRange then
		local paramList = string.split(winnerOpParams, "_")

		descStr = paramList and #paramList == 2 and string.format(descFormat, paramList[1], tostring(value), paramList[2]) or descFormat
	elseif resultType == GameEnum.Evaluate.CircleCount then
		descStr = string.format(descFormat, winnerOpParams)
	elseif resultType == GameEnum.Evaluate.MyRaceIdMustActive then
		local petcfg = CharacterConfig.instance:getPetCo(checknumber(winnerOpParams))

		if petcfg then
			if not petcfg.name then
				local name = ""

				descStr = string.format(descFormat, name)
			end
		end
	elseif resultType == GameEnum.Evaluate.EqualCircleCount then
		descStr = string.format(descFormat, winnerOpParams)
	elseif resultType == GameEnum.Evaluate.CharacterActiveNum then
		descStr = string.format(descFormat, tostring(value))
	elseif resultType == GameEnum.Evaluate.EnemyActiveCount then
		local curActNum = checknumber(value)
		local needActNum = checknumber(winnerOpParams)

		isReach = needActNum <= curActNum

		local color = self:_getColorStr(isReach)

		descStr = string.format(descFormat, needActNum, color, curActNum, needActNum)
	elseif resultType == GameEnum.Evaluate.KillNum then
		local curKillNum = checknumber(value)
		local needKillNum = checknumber(winnerOpParams)

		isReach = needKillNum <= curKillNum
		descStr = string.format(descFormat, curKillNum)
	elseif resultType == GameEnum.Evaluate.ActiveCountLessThan then
		local lessThanActNum = checknumber(winnerOpParams)
		local curActNum = checknumber(value)

		isReach = curActNum <= lessThanActNum
		descStr = string.format(descFormat, lessThanActNum)
	elseif resultType == GameEnum.Evaluate.ActiveCount then
		local needActNum = checknumber(winnerOpParams)
		local curActNum = checknumber(value)

		isReach = needActNum <= curActNum
		descStr = string.format(descFormat, needActNum)
	else
		local color = self:_getColorStr(isReach)

		descStr = string.format(descFormat, checknumber(winnerOpParams)) .. string.format("  <color=#%s>(%s/%s)</color>", color, tostring(value), winnerOpParams)
	end

	local descInfo = {}

	descInfo.resultType = resultType
	descInfo.desc = descStr
	descInfo.isReach = checkbool(isReach)
	descInfo.winnerOpParams = winnerOpParams
	descInfo.singleParam = singleParam

	return descInfo
end

function DivineXiuErClgController:_getCommonResultDescInfo(isWin)
	local curEnemyDieNum = 0
	local curEnemyActNum = 0
	local enemyUnits = BattleModel.instance:getEnemyUnits()

	curEnemyDieNum = 0

	for k, v in pairs(enemyUnits) do
		if v.attrs:getCurHp() <= 0 then
			curEnemyDieNum = curEnemyDieNum + 1
		end
	end

	curEnemyActNum = Mathf.Max(#enemyUnits - curEnemyDieNum, 0)

	local isReach = checkbool(isWin)
	local color = self:_getColorStr(isReach)
	local descInfo = {}

	descInfo.isReach = isReach
	descInfo.desc = isReach and "击败敌阵全部精灵" or "击败敌阵全部精灵"

	return descInfo
end

function DivineXiuErClgController:_getColorStr(isWin)
	return (isWin or nil) and (SettlementTarget.Colors.Sucess or SettlementTarget.Colors.Fail)
end

function DivineXiuErClgController:_getFirstValueOfM(isWin)
	return (isWin or nil) and (SettlementTarget.Colors.Sucess or SettlementTarget.Colors.Fail)
end

function DivineXiuErClgController:getTryEnterNorClgResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:isPassOfNor(activityId) then
		result = GameEnum.ResultCode.IsPass
		tips = "已通关"
	end

	return result, tips
end

function DivineXiuErClgController:getTryFightNorClgResultAndTips(activityId, groupId, dataBitId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:isPassOfNor(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "已通关"
	elseif self:isFullProgress(activityId, groupId, dataBitId) then
		result = GameEnum.ResultCode.Error
		tips = "进度已满"
	end

	return result, tips
end

function DivineXiuErClgController:getTryGetPrizeNorClgResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:isHasGainPrizeOfNor(activityId) then
		result = GameEnum.ResultCode.IsHasGain
		tips = "已领取"
	elseif not self:isPassOfNor(activityId) then
		result = GameEnum.ResultCode.NotPass
		tips = "未通关"
	end

	return result, tips
end

function DivineXiuErClgController:isHasGainPrizeOfNor(activityId)
	return self:getDxecMo(activityId):isHasGainPrizeOfNor()
end

function DivineXiuErClgController:isPassOfNor(activityId)
	return self:getDxecMo(activityId):isPassOfNor()
end

function DivineXiuErClgController:isFullProgress(activityId, groupId, dataBitId)
	local isFull = false
	local data = DivineXiuErClgConfig.instance:getDxecNorStageGroupData(activityId, groupId, dataBitId)

	if data then
		local curProgress = self:getProgressByTypeOfNor(activityId, data.stageType)
		local maxProgress = self:getMaxProgressLimitOfNor(activityId)

		isFull = maxProgress <= curProgress
	end

	return isFull
end

function DivineXiuErClgController:getProgressByTypeOfNor(activityId, stageType)
	local progress = 0

	if stageType == DxecEnum.NorStageType_False then
		progress = self:getDxecMo(activityId):getFalseProgressOfNor()
	elseif stageType == DxecEnum.NorStageType_True then
		progress = self:getDxecMo(activityId):getTrueProgressOfNor()
	end

	return progress
end

function DivineXiuErClgController:getMaxProgressLimitOfNor(activityId)
	local data = DivineXiuErClgConfig.instance:getDxecActData(activityId)

	return (data or nil) and data.normalClgMaxProgress
end

function DivineXiuErClgController:getTodayGroupIdOfNor(activityId)
	return self:getDxecMo(activityId):getTodayGroupIdOfNor()
end

function DivineXiuErClgController:getStageScoreOfNor(activityId, dataBitId)
	return self:getDxecMo(activityId):getStageScoreOfNor(dataBitId)
end

function DivineXiuErClgController:isPassOfStageOfNor(activityId, dataBitId)
	local info = self:getDxecMo(activityId):getStageInfoOfNor(dataBitId)

	return info ~= nil
end

function DivineXiuErClgController:getTryEnterExtClgResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:isPassOfExt(activityId) then
		result = GameEnum.ResultCode.IsPass
		tips = "已通关"
	end

	return result, tips
end

function DivineXiuErClgController:getTryEnterExtTierClgResultAndTips(activityId, tierId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:isPassOfExt(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "已通关"
	elseif self:isPassTierOfExt(activityId, tierId) then
		result = GameEnum.ResultCode.IsPass
		tips = "已通关"
	elseif not self:isPassPreTierOfExt(activityId, tierId) then
		result = GameEnum.ResultCode.NotUnlockCond
		tips = "未解锁"
	elseif not self:isInTimeOfTierOfExt(activityId, tierId) then
		result = GameEnum.ResultCode.ErrorTime
		tips = "未开启"
	end

	return result, tips
end

function DivineXiuErClgController:getTryFightExtClgResultAndTips(activityId, tierId, dataBitId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:isPassOfExt(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "已通关"
	elseif self:isPassTierOfExt(activityId, tierId) then
		result = GameEnum.ResultCode.Error
		tips = "已通关"
	elseif self:isPassTierStageOfExt(activityId, tierId, dataBitId) then
		result = GameEnum.ResultCode.Error
		tips = "已通关"
	elseif not self:isPassPreTierOfExt(activityId, tierId) then
		result = GameEnum.ResultCode.Error
		tips = "未解锁"
	elseif not self:isInTimeOfTierOfExt(activityId, tierId) then
		result = GameEnum.ResultCode.Error
		tips = "未开启"
	end

	return result, tips
end

function DivineXiuErClgController:getTryRefreshExtTierStageClgResultAndTips(activityId, tierId, dataBitId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:isPassOfExt(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "已通关"
	elseif self:isPassTierOfExt(activityId, tierId) then
		result = GameEnum.ResultCode.Error
		tips = "已通关"
	elseif not self:isPassTierStageOfExt(activityId, tierId, dataBitId) then
		result = GameEnum.ResultCode.Error
		tips = "未挑战，无需重置"
	elseif not self:isInTimeOfTierOfExt(activityId, tierId) then
		result = GameEnum.ResultCode.Error
		tips = "未开启"
	end

	return result, tips
end

function DivineXiuErClgController:getTryGetPrizeExtClgResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:isHasGainPrizeOfExt(activityId) then
		result = GameEnum.ResultCode.IsHasGain
		tips = "已领取"
	elseif not self:isPassOfExt(activityId) then
		result = GameEnum.ResultCode.NotPass
		tips = "未通关"
	end

	return result, tips
end

function DivineXiuErClgController:isPassOfExt(activityId)
	local maxTierId = self:getTierCountOfExt(activityId)

	return self:isPassTierOfExt(activityId, maxTierId)
end

function DivineXiuErClgController:isPassPreTierOfExt(activityId, tierId)
	return self:isPassTierOfExt(activityId, tierId - 1)
end

function DivineXiuErClgController:isPassTierOfExt(activityId, tierId)
	local isPass = true

	if tierId > 0 then
		local curTierId = self:getCurTierIdOfExt(activityId)

		isPass = tierId < curTierId
	end

	return isPass
end

function DivineXiuErClgController:isPassTierStageOfExt(activityId, tierId, dataBitId)
	local isPass = false
	local tierData = DivineXiuErClgConfig.instance:getDxecExtTierData(activityId, tierId)

	if tierData then
		local tierType = tierData.tierType

		if tierType == DxecEnum.TierType_NpStage then
			local dataBitIdList = self:getDxecMo(activityId):getDataBitIdListOfPassOfExt()

			isPass = table.indexof(dataBitIdList, dataBitId) ~= false
		elseif tierType == DxecEnum.TierType_TfStage then
			local stageInfo = self:getDxecMo(activityId):getStageInfoOfExt(dataBitId)

			isPass = stageInfo ~= nil
		end
	end

	isPass = isPass or self:isPassTierOfExt(activityId, tierId)

	return isPass
end

function DivineXiuErClgController:getTierCountOfExt(activityId)
	local cfg = DivineXiuErClgConfig.instance:getDxecExtTierCfg(activityId)
	local data = cfg and cfg[#cfg]

	return (data or nil) and (data.tierId or 0)
end

function DivineXiuErClgController:isInTimeOfTierOfExt(activityId, tierId)
	local data = DivineXiuErClgConfig.instance:getDxecExtTierData(activityId, tierId)

	return self:getTimePeriodOfTierOfExt(activityId, tierId) == GameUtil.inTimePeriod
end

function DivineXiuErClgController:getTimePeriodOfTierOfExt(activityId, tierId)
	local data = DivineXiuErClgConfig.instance:getDxecExtTierData(activityId, tierId)

	return GameUtil.getTimePeriod(data.openTime, nil)
end

function DivineXiuErClgController:isHasGainPrizeOfExt(activityId)
	return self:getDxecMo(activityId):isHasGainPrizeOfExt()
end

function DivineXiuErClgController:getCurTierIdOfExt(activityId)
	return self:getDxecMo(activityId):getCurTierIdOfExt()
end

function DivineXiuErClgController:isHasBalanceOfTruefalseOfExt(activityId, tierId)
	local trueScore = DivineXiuErClgController.instance:getTotalScoreOfTruefalseOfExt(activityId, tierId, DxecEnum.ExtStageType_True)
	local falseScore = DivineXiuErClgController.instance:getTotalScoreOfTruefalseOfExt(activityId, tierId, DxecEnum.ExtStageType_False)

	return (trueScore == falseScore and trueScore ~= 0 and self:isPassAllStageOfTruefalseOfExt(activityId, tierId) or nil) and true
end

function DivineXiuErClgController:isPassAllStageOfTruefalseOfExt(activityId, tierId)
	local result = true
	local cfg = DivineXiuErClgConfig.instance:getDxecExtStageCfg(activityId, tierId)

	for _, data in ipairs(cfg) do
		local isPass = self:isPassTierStageOfExt(activityId, tierId, data.dataBitId)

		if isPass == false then
			result = false

			break
		end
	end

	return result
end

function DivineXiuErClgController:getTotalScoreOfTruefalseOfExt(activityId, tierId, stageType)
	local score = 0
	local cfg = DivineXiuErClgConfig.instance:getDxecExtStageCfg(activityId, tierId)

	for _, data in ipairs(cfg) do
		if data.stageType == stageType then
			score = score + self:getStageScoreOfTruefalseOfExt(activityId, data.dataBitId)
		end
	end

	return score
end

function DivineXiuErClgController:getStageScoreOfTruefalseOfExt(activityId, dataBitId)
	return self:getDxecMo(activityId):getStageScoreOfTruefalseOfExt(dataBitId)
end

function DivineXiuErClgController:getAllRaceIdListOfLockedOfTruefalseStageOfExt(activityId, tierId)
	local raceIdList = {}
	local cfg = DivineXiuErClgConfig.instance:getDxecExtStageCfg(activityId, tierId)

	for _, data in ipairs(cfg) do
		local list = self:getRaceIdListOfLockedOfTruefalseStageOfExt(activityId, data.dataBitId)

		for _, raceId in ipairs(list) do
			if table.indexof(raceIdList, raceId) == false then
				table.insert(raceIdList, raceId)
			end
		end
	end

	return raceIdList
end

function DivineXiuErClgController:isRaceLockedOfTruefalseOfExt(activityId, tierId, raceId)
	local list = self:getAllRaceIdListOfLockedOfTruefalseStageOfExt(activityId, tierId)

	return table.indexof(list, raceId)
end

function DivineXiuErClgController:getRaceIdListOfLockedOfTruefalseStageOfExt(activityId, dataBitId)
	return self:getDxecMo(activityId):getRaceIdListOfLockedOfTruefalseStageOfExt(dataBitId)
end

function DivineXiuErClgController:isRaceLockedOfTruefalseStageOfExt(activityId, dataBitId, raceId)
	local list = self:getRaceIdListOfLockedOfTruefalseStageOfExt(activityId, dataBitId)

	return table.indexof(list, raceId)
end

DivineXiuErClgController.instance = DivineXiuErClgController.New()

return DivineXiuErClgController
