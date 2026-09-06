-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rolerelationship/controller/RoleRelationshipController.lua

module("logic.extensions.rolerelationship.controller.RoleRelationshipController", package.seeall)

local RoleRelationshipController = class("RoleRelationshipController", BaseController)

RoleRelationshipController.PETAWAKENVERDAYFIRSTCLICKREDPOINT = "PetAwakenVerDayFirstClickRedpoint"
RoleRelationshipController.PETAWAKENVERACTFIRSTCLICKREDPOINT = "PetAwakenVerActFirstClickRedpoint"

function RoleRelationshipController:ctor()
	return
end

function RoleRelationshipController:onInit()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.dailyRefresh, self)
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self.startEnterGame, self)
	self:onReset()
end

function RoleRelationshipController:onReset()
	return
end

function RoleRelationshipController:onSendRRMGetMapInfoReq(activityId)
	RoleRelationshipAgent.instance:sendPM_RRMGetMapInfoReq(activityId)
end

function RoleRelationshipController:onHandleRRMGetMapInfoRes(msg)
	RoleRelationshipModel.instance:onHandleRRMGetMapInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.RoleShipUpdateMapInfo)
end

function RoleRelationshipController:onSendRRMGetTaskInfoReq(activityId)
	RoleRelationshipAgent.instance:sendPM_RRMGetTaskInfoReq(activityId)
end

function RoleRelationshipController:onHandleRRMGetTaskInfoRes(msg)
	RoleRelationshipModel.instance:onHandleRRMGetTaskInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.RoleShipUpdateTaskInfo)
end

function RoleRelationshipController:onSendRRMUnlockLineReq(activityId, lineId)
	RoleRelationshipAgent.instance:sendPM_RRMUnlockLineReq(activityId, lineId)
end

function RoleRelationshipController:onHandleRRMUnlockLineRes(msg)
	RoleRelationshipModel.instance:onHandleRRMUnlockLineRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.RoleShipUpdateMapInfo)
end

function RoleRelationshipController:onSendRRMGainProgressPrizeReq(activityId, prizeId)
	RoleRelationshipAgent.instance:sendPM_RRMGainProgressPrizeReq(activityId, prizeId)
end

function RoleRelationshipController:onHandleRRMGainProgressPrizeRes(msg)
	RoleRelationshipModel.instance:onHandleRRMGainProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.RoleShipUpdateProgress)
end

function RoleRelationshipController:onSendRRMGainImpressPrizeReq(activityId, roleId, archiveId, impressId)
	RoleRelationshipAgent.instance:sendPM_RRMGainImpressPrizeReq(activityId, roleId, archiveId, impressId)
end

function RoleRelationshipController:onHandleRRMGainImpressPrizeRes(msg)
	RoleRelationshipModel.instance:onHandleRRMGainImpressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.RoleShipUpdateMapInfo)
end

function RoleRelationshipController:startEnterGame()
	return
end

function RoleRelationshipController:dailyRefresh()
	return
end

function RoleRelationshipController:getRoleState(roleId)
	local activityId = RoleRelationshipModel.instance:getCurActivityId()
	local rsShipCfg = RoleRelationshipConfig.instance:getRsShipCfg(activityId)
	local unlockedLines = RoleRelationshipModel.instance:getUnlockedLines()
	local isRoleUnlocked = false
	local isAllRoleUnlocked = #unlockedLines > 0

	for _, shipId in ipairs(unlockedLines) do
		local isUnLocked = table.indexof(rsShipCfg[shipId].shipLine, roleId) ~= false

		isRoleUnlocked = isRoleUnlocked or isUnLocked
		isAllRoleUnlocked = isAllRoleUnlocked and isUnLocked
	end

	local roleState = 1

	if isAllRoleUnlocked then
		roleState = 3
	elseif isRoleUnlocked then
		roleState = 2
	end

	return roleState
end

function RoleRelationshipController:isRoleUnlockedById(roleId)
	local roleState = self:getRoleState(roleId)

	return roleState == 2 or roleState == 3
end

function RoleRelationshipController:isShipLineHasConnect(shipId)
	local activityId = RoleRelationshipModel.instance:getCurActivityId()
	local rsShipCfg = RoleRelationshipConfig.instance:getRsShipCfg(activityId)
	local unlockedLines = RoleRelationshipModel.instance:getUnlockedLines()
	local isShipLineHasConnect = false

	for _, uShipId in ipairs(unlockedLines) do
		local line = rsShipCfg[shipId].shipLine
		local uLine = rsShipCfg[uShipId].shipLine

		if line[1] == uLine[1] and line[2] == uLine[2] or line[1] == uLine[2] and line[2] == uLine[1] then
			isShipLineHasConnect = true

			break
		end
	end

	return isShipLineHasConnect
end

function RoleRelationshipController:getNearRoleIdByShipLine(roleId, shipLine)
	local nearId = roleId

	for _, rId in ipairs(shipLine) do
		if rId ~= roleId then
			nearId = rId

			break
		end
	end

	return nearId
end

function RoleRelationshipController:getShipLineTotalNum()
	local activityId = RoleRelationshipModel.instance:getCurActivityId()
	local rsShipCfg = RoleRelationshipConfig.instance:getRsShipCfg(activityId)

	return #rsShipCfg
end

function RoleRelationshipController:getRemainingTimes()
	local unlockTimes = RoleRelationshipModel.instance:getUnlockTimes()
	local totalNum = self:getShipLineTotalNum()

	return totalNum - unlockTimes
end

function RoleRelationshipController:isHasImpressPrizeCanGet(roleId)
	local activityId = RoleRelationshipModel.instance:getCurActivityId()
	local rsRoleData = RoleRelationshipConfig.instance:getRsRoleData(activityId, roleId)
	local arcPlanId = rsRoleData.arcPlanId
	local rsRoleArcCfg = RoleRelationshipConfig.instance:getRsRoleArcCfg(arcPlanId)
	local isHas = false

	for _, data in ipairs(rsRoleArcCfg) do
		isHas = isHas or self:isHasImpressPrizeCanGetByArc(roleId, arcPlanId, data.arcId)
	end

	return isHas
end

function RoleRelationshipController:isHasImpressPrizeCanGetByArc(arcRoleId, arcPlanId, arcId)
	local arcData = RoleRelationshipConfig.instance:getRsRoleArcData(arcPlanId, arcId)
	local rsRoleArcImpCfg = RoleRelationshipConfig.instance:getRsRoleArcImpCfg(arcData.impPlanId)
	local isHas = false

	for _, impData in ipairs(rsRoleArcImpCfg) do
		isHas = isHas or self:getImpressState(arcRoleId, arcPlanId, arcId, impData.impId) == 2
	end

	return isHas
end

function RoleRelationshipController:getImpressState(arcRoleId, arcPlanId, arcId, impId)
	local arcData = RoleRelationshipConfig.instance:getRsRoleArcData(arcPlanId, arcId)
	local impData = RoleRelationshipConfig.instance:getRsRoleArcImpData(arcData.impPlanId, impId)
	local gainedImpressIds = RoleRelationshipModel.instance:getGainedImpressIds(arcRoleId, arcId)

	if table.indexof(gainedImpressIds, impData.impId) ~= false then
		return 3
	end

	return self:isRoleUnlockedById(impData.roleId) and 2 or 1
end

function RoleRelationshipController:getTaskState(taskId)
	local isTaskHasCompleted = self:isTaskHasCompleted(taskId)

	return isTaskHasCompleted and 2 or 1
end

function RoleRelationshipController:isTaskHasCompleted(taskId)
	local activityId = RoleRelationshipModel.instance:getCurActivityId()
	local taskData = RoleRelationshipConfig.instance:getRsTaskData(activityId, taskId)
	local maxProgress = taskData.maxProgress
	local curProgress = RoleRelationshipModel.instance:getTaskCurProgress(taskId)

	return maxProgress <= curProgress
end

function RoleRelationshipController:isHasGainPrize(proPrizeId)
	local gainedProgressPrizeIds = RoleRelationshipModel.instance:getGainedProgressPrizeIds()

	return table.indexof(gainedProgressPrizeIds, proPrizeId) ~= false
end

function RoleRelationshipController:isCanGainPrize(proPrizeId)
	local activityId = RoleRelationshipModel.instance:getCurActivityId()
	local rsProPrizeCfg = RoleRelationshipConfig.instance:getRsProPrizeCfg(activityId)
	local data = rsProPrizeCfg[proPrizeId]
	local needTimes = data.needTimes
	local unlockTimes = RoleRelationshipModel.instance:getUnlockTimes()
	local isHasGain = self:isHasGainPrize(proPrizeId)

	return not isHasGain and needTimes <= unlockTimes
end

function RoleRelationshipController:isShipNeedRed(activityId)
	activityId = checknumber(activityId)

	local isInTime = self:isRoleRelationshipInTime(activityId)

	if not isInTime then
		return false
	end

	local isNeedRed = false
	local redIdList = self:getShipRedPointIdList(activityId)

	for _, redId in ipairs(redIdList) do
		if RedPointModel.instance:isActive(redId) then
			isNeedRed = true

			break
		end
	end

	return isNeedRed
end

function RoleRelationshipController:isRoleRelationshipInTime(activityId)
	activityId = checknumber(activityId)

	return ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.RoleShip, activityId)
end

function RoleRelationshipController:getShipRedPointIdList(activityId)
	activityId = checknumber(activityId)

	local redIdList = {}
	local rsCfg = RoleRelationshipConfig.instance:getRsCfg(activityId)

	table.insert(redIdList, checknumber(rsCfg.redPointId))

	return redIdList
end

function RoleRelationshipController:regRedAboutRoleShip(go, activityId)
	local isInTime = self:isRoleRelationshipInTime(activityId)

	if not isInTime then
		return
	end

	local redIdList = self:getShipRedPointIdList(activityId)

	RedPointController.instance:unregRedPoint(go)
	RedPointController.instance:regRedPoint(go, unpack(redIdList))
end

function RoleRelationshipController:unRegRedAboutRoleShip(go)
	if go == nil then
		return
	end

	RedPointController.instance:unregRedPoint(go)
end

function RoleRelationshipController:openRoleRelationshipView(activityId)
	UIStateManager.instance:push(ViewName.RoleRelationshipView, activityId)
end

RoleRelationshipController.instance = RoleRelationshipController.New()

return RoleRelationshipController
