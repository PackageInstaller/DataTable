-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/controller/PowerPillaController.lua

module("logic.extensions.maintainpowerpilla.controller.PowerPillaController", package.seeall)

local PowerPillaController = class("PowerPillaController", BaseController)

function PowerPillaController:ctor()
	return
end

function PowerPillaController:onInit()
	self.ciList = nil

	GlobalDispatcher:addListener("jumptostageaspowerpilla", self.gotoJumpToStageAsPowerPilla, self)
end

function PowerPillaController:getTotalEventNum(activityId, stage)
	local totalEventNum = 0

	if activityId > 0 and stage > 0 then
		local gridDataList = PowerPillaConfig.instance:getGridDataListByStage(activityId, stage)

		for _, data in ipairs(gridDataList) do
			if data.eventType == PPLMapCell.Battle or data.eventType == PPLMapCell.Box or data.eventType == PPLMapCell.Game then
				totalEventNum = totalEventNum + 1
			end

			if data.eventType == PPLMapCell.Branch then
				local branchData = PowerPillaConfig.instance:getBranchStageData(activityId, stage)

				totalEventNum = totalEventNum + self:getTotalEventNum(activityId, branchData.stage)
			end
		end
	end

	return totalEventNum
end

function PowerPillaController:getCurEventNumOfMainAndBranch(activityId, stage)
	local totalEventNum = 0

	if activityId > 0 and stage > 0 then
		totalEventNum = totalEventNum + PowerPillaModel.instance:getFinishEventNumOfStage(stage)

		local branchData = PowerPillaConfig.instance:getBranchStageData(activityId, stage)

		if branchData then
			totalEventNum = totalEventNum + self:getCurEventNumOfMainAndBranch(activityId, branchData.stage)
		end
	end

	return totalEventNum
end

function PowerPillaController:getMaxMainStage(activityId)
	local maxStage = 0
	local list = PowerPillaConfig.instance:getStageListOfMain(activityId)

	for _, data in ipairs(list) do
		maxStage = Mathf.Max(maxStage, data.stage)
	end

	return maxStage
end

function PowerPillaController:getTryResetBuffResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isHasBuffUpdate(activityId) then
		result = GameEnum.ResultCode.NotEnoughTimes
		tips = "暂无可重置的buff等级"
	end

	return result, tips
end

function PowerPillaController:isHasBuffUpdate(activityId)
	local cfgs = PowerPillaConfig.instance:getBuffCfgs(activityId)

	if cfgs then
		for _, cfg in ipairs(cfgs) do
			local data = cfg[0]

			if self:isHasReachLevelOfBuff(data.type, 1) then
				return true
			end
		end
	end

	return false
end

function PowerPillaController:getTryUpdateBuffResultAndTips(activityId, type, level)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if self:isHasMaxLevelOfBuff(activityId, type, level) then
		result = GameEnum.ResultCode.IsMaxLimit
		tips = "Buff已满级"
	elseif self:isHasReachLevelOfBuff(type, level + 1) then
		result = GameEnum.ResultCode.IsPurchased
		tips = "对应等级已达到,无法重复升级"
	elseif not self:isHasReachLastLevelOfBuff(activityId, type, level) then
		result = GameEnum.ResultCode.IsPurchased
		tips = "需解锁前置Buff"
	elseif not self:isUnlockCondOfBuff(activityId, type, level) then
		result = GameEnum.ResultCode.NotUnlockCond

		local buffData = PowerPillaConfig.instance:getBuffData(activityId, type, level)

		tips = buffData and buffData.condTips or "需解锁前置Buff"
	elseif self:isExBuyTimesOfBuff(type) then
		result = GameEnum.ResultCode.IsMaxLimitOfTimes
		tips = "周限购次数已用尽"
	elseif not self:isEnoughGoldToUpdateLevelOfBuff(activityId, type, level) then
		result = GameEnum.ResultCode.NotEnoughNum

		local matName
		local buffData = PowerPillaConfig.instance:getBuffData(activityId, type, level)

		if buffData and not string.nilorempty(buffData.cost) then
			local matType, matId, matNum = MaterialMgr.getMatParams(buffData.cost)

			matName = MaterialMgr.getMaterialsName(matType, matId)
		end

		tips = string.format("%s不足", matName)
	end

	return result, tips
end

function PowerPillaController:isHasMaxLevelOfBuff(activityId, type, level)
	return level >= PowerPillaConfig.instance:getMaxLevelOfBuff(activityId, type)
end

function PowerPillaController:isHasReachLevelOfBuff(type, level)
	return level <= PowerPillaModel.instance:getBuffLevel(type)
end

function PowerPillaController:isHasReachLastLevelOfBuff(activityId, type, level)
	local lv = Mathf.Max(level - 1, 0)

	if level == 1 then
		return self:isUnlockCondOfBuff(activityId, type, lv)
	else
		return self:isHasReachLevelOfBuff(type, lv)
	end
end

function PowerPillaController:isEnoughGoldToUpdateLevelOfBuff(activityId, type, level)
	local buffData = PowerPillaConfig.instance:getBuffData(activityId, type, level)
	local curGold = 0
	local costGold = 0

	if buffData and not string.nilorempty(buffData.cost) then
		local matType, matId, matNum = MaterialMgr.getMatParams(buffData.cost)

		curGold = MaterialModel.instance:getMaterialsNumber(matType, matId)
		costGold = matNum
	end

	return costGold <= curGold
end

function PowerPillaController:isUnlockCondOfBuff(activityId, type, level)
	local buffData = PowerPillaConfig.instance:getBuffData(activityId, type, level)
	local condition = buffData.condition

	if string.nilorempty(condition) then
		return true
	else
		return GameUtil.expScript(condition, GameUtil.handler(self._onFilter, self, activityId, type, level))
	end
end

function PowerPillaController:_onFilter(activityId, type, level, str)
	local arr = string.split(str, "$")
	local type = arr[1]

	if type == "BuffLevel" then
		local ctList = string.split(arr[2], ",")

		return self:isHasReachLevelOfBuff(checknumber(ctList[1]), checknumber(ctList[2]))
	elseif type == "SumBuffLevel" then
		local ctList = string.split(arr[2], "#")
		local buffIdList = string.split(ctList[1], ",")
		local sumLevel = checknumber(ctList[2])
		local tempSumLevel = 0

		for _, v in ipairs(buffIdList) do
			tempSumLevel = tempSumLevel + PowerPillaModel.instance:getBuffLevel(checknumber(v))
		end

		return sumLevel <= tempSumLevel
	end

	return false
end

function PowerPillaController:isExBuyTimesOfBuff(type)
	local curBuyTimes = PowerPillaModel.instance:getBuffBuyTimes(type)
	local maxBuyTimes = PowerPillaConfig.instance:getBuffBuyTimes(type)

	if maxBuyTimes > 0 then
		return maxBuyTimes <= curBuyTimes
	else
		return false
	end
end

function PowerPillaController:updateBuffRed()
	local activityId = PowerPillaModel.instance:getActivityId()
	local isActivated = false
	local cfgs = PowerPillaConfig.instance:getBuffCfgs(activityId)

	for _, cfg in ipairs(cfgs) do
		for i = 0, #cfg do
			local data = cfg[i]
			local result = self:getTryUpdateBuffResultAndTips(activityId, data.type, data.level)

			if result == GameEnum.ResultCode.Success then
				isActivated = true

				break
			end
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_POWERPILLA_BUFF_CAN_UPDATE, isActivated)
end

function PowerPillaController:getJumpStageResultAndTips(activityId, stage)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local data = PowerPillaConfig.instance:getActivityCfg(activityId)

	if not self:isPassLastStage(activityId, stage) then
		result = GameEnum.ResultCode.NotInTime
		tips = "关卡未开启"
	elseif not PowerPillaModel.instance:isOpenByCurrentStage(false, data.stagePlanId, stage) then
		result = GameEnum.ResultCode.NotPassLast
		tips = "关卡未开启"
	elseif not FuncOpenModel.instance:getFuncIsOpen(889) then
		result = GameEnum.ResultCode.NotInActTime
		tips = "功能未开启"
	end

	return result, tips
end

function PowerPillaController:isPassLastStage(activityId, stage)
	local lastStage = Mathf.Max(stage - 1, 1)

	if lastStage == stage then
		return true
	else
		return PowerPillaModel.instance:isPassOfStage(lastStage)
	end
end

function PowerPillaController:gotoJumpToStageAsPowerPilla(params)
	local activityId = PowerPillaModel.instance:getActivityId()
	local stage = checknumber(params[1])

	self:jumpToStageAsPowerPilla(activityId, stage)
end

function PowerPillaController:jumpToStageAsPowerPilla(activityId, stage)
	local result, tips = self:getJumpStageResultAndTips(activityId, stage)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	GlobalDispatcher:addListener(GlobalNotify.MPPGetGameInfoRes, self._handleJumpToStageAsPowerPilla, self)
	MaintainPowerPillaAgent.instance:sendPM_MPPGetGameInfoReq(activityId, stage)
end

function PowerPillaController:_handleJumpToStageAsPowerPilla()
	GlobalDispatcher:removeListener(GlobalNotify.MPPGetGameInfoRes, self._handleJumpToStageAsPowerPilla, self)
	UIStateManager.instance:push(ViewName.PowerPillaLevelView, PowerPillaModel.instance:getCurStage())
end

function PowerPillaController:checkBoxEvent(msg)
	if msg then
		local info = GameUtil.pbToTable(msg)
		local reqStageId, reqGridId = msg.reqStageId, msg.reqGridId

		if msg.mapInfo then
			local stageData = PowerPillaConfig.instance:getStageCfgById(msg.activityId, reqStageId)

			if stageData and stageData.mainStageId <= 0 then
				local gridData = PowerPillaConfig.instance:getGridDataByStage(msg.activityId, reqStageId, reqGridId)

				if gridData and gridData.eventType == PPLMapCell.Box then
					local boxCfg = PowerPillaConfig.instance:getBoxCfg(gridData.eventId)
					local showTxt = boxCfg and boxCfg.showTxt

					if not GameUtil.isEmptyString(showTxt) then
						self.ciList = msg.changeSetId

						MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
						UIStateManager.instance:push(ViewName.PowerPillaPrizeView, boxCfg)
					end
				end
			end
		end
	end
end

function PowerPillaController:showCI()
	MaterialController.instance:showChangeSetInTemp(self.ciList)

	self.ciList = {}
end

PowerPillaController.instance = PowerPillaController.New()

return PowerPillaController
