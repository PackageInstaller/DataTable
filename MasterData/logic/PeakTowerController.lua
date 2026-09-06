-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktower/controller/PeakTowerController.lua

module("logic.extensions.peaktower.controller.PeakTowerController", package.seeall)

local PeakTowerController = class("PeakTowerController", BaseController)

function PeakTowerController:ctor()
	return
end

function PeakTowerController:onInit()
	self:onReset()
end

function PeakTowerController:onReset()
	self._tempLockPet = {}
	self._popView = {}
end

function PeakTowerController:openBasicMissionView(activityId, floorId, stageId)
	local weekId = self:getCurWeekId(activityId)
	local fmtMo = PeakTowerModel.instance:getBasicFmtMo()

	fmtMo:initParams(activityId, weekId, floorId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function PeakTowerController:openLegendMissionView(activityId, floorId, stageId)
	local weekId = self:getCurWeekId(activityId)
	local fmtMo = PeakTowerModel.instance:getLegendFmtMo()

	fmtMo:initParams(activityId, weekId, floorId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function PeakTowerController:handlePM_PeakTowerInfoRes(msg)
	PeakTowerModel.instance:saveInfo(msg)
	self:_setMaxFloor(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PeakTowerInfoRes)
end

function PeakTowerController:handlePM_PeakTowerResetFloorRes(msg)
	if msg.type == 1 then
		PeakTowerModel.instance:saveResetBasicFloorInfo(msg)
	elseif msg.type == 2 then
		PeakTowerModel.instance:saveResetLegendFloorInfo(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_PeakTowerInfoRes)
end

function PeakTowerController:sendPM_PeakTowerBasicClgReq(activityId, form, floorId, stageId)
	if self:checkCanEnterBattle(activityId) == false then
		-- block empty
	else
		PeakTowerAgent.instance:sendPM_PeakTowerBasicClgReq(activityId, form, floorId, stageId)
	end
end

function PeakTowerController:handlePM_PeakTowerNotifyBasicClgRes(msg)
	if msg.isWin then
		PeakTowerModel.instance:saveBasicBattleInfo(msg)
		self:_setMaxFloor(msg.activityId)
	end

	self._enterBattle = true

	GlobalDispatcher:dispatch(GlobalNotify.PM_PeakTowerNotifyClgRes)
end

function PeakTowerController:sendPM_PeakTowerLegendClgReq(activityId, form, floorId, stageId)
	if self:checkCanEnterBattle(activityId) == false then
		-- block empty
	else
		PeakTowerAgent.instance:sendPM_PeakTowerLegendClgReq(activityId, form, floorId, stageId)
	end
end

function PeakTowerController:savePopViewName(activityId, viewName)
	self._popView[activityId] = self._popView[activityId] or {}
	self._popView[activityId][viewName] = true
end

function PeakTowerController:checkCanEnterBattle(activityId)
	if self:isCanEnterBattle() == false then
		UIJumper.instance:clear()
		UIStateManager.instance:popByName(ViewName.CustomMissionView)
		UIStateManager.instance:popByName(ViewName.CustomFormationView)

		if self._popView[activityId] then
			for viewName, v in pairs(self._popView[activityId]) do
				if v == true then
					UIStateManager.instance:popByName(viewName)
				end
			end
		end

		FloatWordMgr.instance:show(lang("4:50-5:10期间活动结算，暂无法挑战"))

		return false
	end

	return true
end

function PeakTowerController:handlePM_PeakTowerNotifyLegendClgRes(msg)
	if msg.isWin then
		PeakTowerModel.instance:saveLegendBattleInfo(msg)
		self:_setMaxFloor(msg.activityId)
	end

	self._enterBattle = true

	GlobalDispatcher:dispatch(GlobalNotify.PM_PeakTowerNotifyClgRes)
end

function PeakTowerController:isEnterBattle()
	return self._enterBattle
end

function PeakTowerController:resetEnterBattle()
	self._enterBattle = nil
end

function PeakTowerController:handlePM_PeakTowerGainProgressPrizeRes(msg)
	PeakTowerModel.instance:saveGainPrizeInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PeakTowerInfoRes)
end

function PeakTowerController:handlePM_PeakTowerVerifyRaceRes(msg)
	local petMo = BagPetsController.instance:getPet(msg.petId)

	PeakTowerModel.instance:saveVerifyZdl(msg.activityId, petMo.raceId, msg.power)
	FloatWordMgr.instance:show(lang("验证精灵成功"))
	GlobalDispatcher:dispatch(GlobalNotify.PM_PeakTowerInfoRes)
end

function PeakTowerController:handlePM_PeakTowerLegendRankViewRes(msg)
	PeakTowerModel.instance:saveLegendRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PeakTowerInfoRes)
end

function PeakTowerController:handlePM_PeakTowerBasicRankViewRes(msg)
	PeakTowerModel.instance:saveBasicRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_PeakTowerInfoRes)
end

function PeakTowerController:_setMaxFloor(activityId)
	local weekId = self:getCurWeekId(activityId)
	local basicFloorCfgs = PeakTowerConfig.instance:getBasicFloorCfgs(activityId, weekId)
	local maxBasicFloor = 0

	for i, v in ipairs(basicFloorCfgs) do
		local allPass = true
		local checkFloorId
		local stageCfgs = PeakTowerConfig.instance:getStageCfgs(v.stagePlan)

		for j, stageCfg in ipairs(stageCfgs) do
			if maxBasicFloor > v.floorId then
				break
			end

			checkFloorId = v.floorId

			if not PeakTowerModel.instance:isBasicStagePass(activityId, v.floorId, stageCfg.stageId) then
				allPass = false

				break
			end
		end

		if allPass == true and checkFloorId then
			PeakTowerModel.instance:setBasicGainPass(activityId, checkFloorId, true)
			PeakTowerModel.instance:setBasicMaxScore(activityId, checkFloorId)

			maxBasicFloor = checkFloorId
		end
	end

	if maxBasicFloor > PeakTowerModel.instance:getBasicMaxPassFloor(activityId) then
		PeakTowerModel.instance:setBasicMaxPassFloor(activityId, maxBasicFloor)
	end

	local legendFloorCfgs = PeakTowerConfig.instance:getLegendFloorCfgs(activityId, weekId)
	local maxLegendFloor = 0

	for i, v in ipairs(legendFloorCfgs) do
		local allPass = true
		local checkFloorId
		local stageCfgs = PeakTowerConfig.instance:getStageCfgs(v.stagePlan)

		for j, stageCfg in ipairs(stageCfgs) do
			if maxLegendFloor > v.floorId then
				break
			end

			checkFloorId = v.floorId

			if not PeakTowerModel.instance:isLegendStagePass(activityId, v.floorId, stageCfg.stageId) then
				allPass = false

				break
			end
		end

		if allPass == true and checkFloorId then
			PeakTowerModel.instance:setLegendGainPass(activityId, checkFloorId, true)
			PeakTowerModel.instance:setLegendMaxScore(activityId, checkFloorId)

			maxLegendFloor = checkFloorId
		end
	end

	if maxLegendFloor > PeakTowerModel.instance:getLegendMaxPassFloor(activityId) then
		PeakTowerModel.instance:setLegendMaxPassFloor(activityId, maxLegendFloor)
	end
end

function PeakTowerController:getAllBasicScore(activityId)
	local curWeekId = self:getCurWeekId(activityId)
	local floorCfgs = PeakTowerConfig.instance:getBasicFloorCfgs(activityId, curWeekId)
	local score = 0

	for i, v in ipairs(floorCfgs) do
		local floorId = v.floorId
		local floorInfo = PeakTowerModel.instance:getBasicFloorInfo(activityId, floorId)

		if floorInfo then
			score = score + floorInfo.maxScore
		end
	end

	return score
end

function PeakTowerController:getAllLegendScore(activityId)
	local curWeekId = self:getCurWeekId(activityId)
	local floorCfgs = PeakTowerConfig.instance:getLegendFloorCfgs(activityId, curWeekId)
	local score = 0

	for i, v in ipairs(floorCfgs) do
		local floorId = v.floorId
		local floorInfo = PeakTowerModel.instance:getLegendFloorInfo(activityId, floorId)

		if floorInfo then
			score = score + floorInfo.maxScore
		end
	end

	return score
end

function PeakTowerController:getCurWeekId(activityId)
	local weekId = 1
	local activityType = ActivityDefineController.instance:getActTypeByActId(activityId)
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, activityId)
	local thisWeekStartTime, thisWeekEndTime = GameUtil.getStartAndEndInWeek(ServerTime.now())

	if startTime < thisWeekStartTime then
		local days = GameUtil.getDaysByTimestamp(startTime, thisWeekStartTime)

		weekId = math.ceil(days / 7)
	else
		weekId = 1
	end

	return weekId
end

function PeakTowerController:isCanEnterBattle()
	local now = ServerTime.now()
	local thisWeekStartTime, thisWeekEndTime = GameUtil.getStartAndEndInWeek(now)

	if now - thisWeekStartTime < 600 or thisWeekEndTime - now < 600 then
		return false
	end

	return true
end

PeakTowerController.instance = PeakTowerController.New()

return PeakTowerController
