-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/controller/FreeScuffleController.lua

module("logic.extensions.freescuffle.controller.FreeScuffleController", package.seeall)

local FreeScuffleController = class("FreeScuffleController", BaseController)

function FreeScuffleController:onInit()
	self:onReset()
end

function FreeScuffleController:onReset()
	self:clearWorSceneMgr()
	self:closeFreeScuffleRuning()
	GlobalDispatcher:addListener(GlobalNotify.FreeScuffleTriggerEvent, self._freeScuffleTriggerEvent, self)
end

function FreeScuffleController:_freeScuffleTriggerEvent(activityId)
	self:_updateRedInWorkEvent(activityId)
end

function FreeScuffleController:sendPM_FreeScuffleGetInfoReq(activityId)
	FreeScuffleAgent.instance:sendPM_FreeScuffleGetInfoReq(activityId)
end

function FreeScuffleController:handlePM_FreeScuffleGetInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_FreeScuffleGetInfoRes(msg)
	self:_updateRedInWorkEvent(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FreeScuffleGetInfoRes)
end

function FreeScuffleController:sendPM_FreeScuffleGainCoinReq(activityId, blockIds)
	FreeScuffleAgent.instance:sendPM_FreeScuffleGainCoinReq(activityId, blockIds)
end

function FreeScuffleController:handlePM_FreeScuffleGainCoinRes(status, msg)
	if status == 0 then
		local mo = self:getSubMo(msg.activityId)

		mo:handlePM_FreeScuffleGainCoinRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FreeScuffleGainCoinRes, status, msg)
end

function FreeScuffleController:sendPM_FreeScuffleUnlockBlockReq(activityId, blockId)
	FreeScuffleAgent.instance:sendPM_FreeScuffleUnlockBlockReq(activityId, blockId)
end

function FreeScuffleController:handlePM_FreeScuffleUnlockBlockRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_FreeScuffleUnlockBlockRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FreeScuffleUnlockBlockRes)
end

function FreeScuffleController:sendPM_FreeScuffleUpgradlePetReq(activityId, raceId, upLevel)
	FreeScuffleAgent.instance:sendPM_FreeScuffleUpgradlePetReq(activityId, raceId, upLevel)
end

function FreeScuffleController:handlePM_FreeScuffleUpgradlePetRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_FreeScuffleUpgradlePetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FreeScuffleUpgradlePetRes, msg)
end

function FreeScuffleController:sendPM_FreeScuffleLotteryReq(activityId, lotteryTimes, type)
	FreeScuffleAgent.instance:sendPM_FreeScuffleLotteryReq(activityId, lotteryTimes, type)
end

function FreeScuffleController:handlePM_FreeScuffleLotteryRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_FreeScuffleLotteryRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FreeScuffleLotteryRes, msg)
end

function FreeScuffleController:sendPM_FreeScuffleTaskInfoReq(activityId)
	FreeScuffleAgent.instance:sendPM_FreeScuffleTaskInfoReq(activityId)
end

function FreeScuffleController:handlePM_FreeScuffleTaskInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_FreeScuffleTaskInfoRes(msg)
	self:_updateRedInTask(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FreeScuffleTaskInfoRes)
end

function FreeScuffleController:sendPM_FreeScuffleGainTaskPrizeReq(activityId, taskId)
	FreeScuffleAgent.instance:sendPM_FreeScuffleGainTaskPrizeReq(activityId, taskId)
end

function FreeScuffleController:handlePM_FreeScuffleGainTaskPrizeRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_FreeScuffleGainTaskPrizeRes(msg)
	self:_updateRedInTask(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FreeScuffleGainTaskPrizeRes)
end

function FreeScuffleController:handlePM_FreeScuffleTaskNotifyRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_FreeScuffleTaskNotifyRes(msg)
	self:_updateRedInTask(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FreeScuffleTaskNotifyRes)
end

function FreeScuffleController:sendPM_FreeScuffleScheduleReq(activityId, petScheduleList)
	FreeScuffleAgent.instance:sendPM_FreeScuffleScheduleReq(activityId, petScheduleList)
end

function FreeScuffleController:handlePM_FreeScuffleScheduleRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_FreeScuffleScheduleRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FreeScuffleScheduleRes)
end

function FreeScuffleController:sendPM_FreeScuffleStartEasterEggGameReq(activityId)
	local clientKey = math.random(1, 100000)
	local mo = self:getSubMo(activityId)

	mo:setClientKeyOfEggGame(clientKey)
	FreeScuffleAgent.instance:sendPM_FreeScuffleStartEasterEggGameReq(activityId, clientKey)
end

function FreeScuffleController:handlePM_FreeScuffleStartEasterEggGameRes(status, msg)
	if status == 0 then
		local mo = self:getSubMo(msg.activityId)

		mo:handlePM_FreeScuffleStartEasterEggGameRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FreeScuffleStartEasterEggGameRes, status)
end

function FreeScuffleController:sendPM_FreeScuffleEndEasterEggGameReq(activityId, clickTimes)
	local mo = self:getSubMo(activityId)
	local clientKey = mo:getClientKeyOfEggGame()
	local serverKey = mo:getServerKeyOfEggGame()
	local encryptedKey = GameUtil.getClientEncryptedKey(clientKey, serverKey, {
		activityId,
		clickTimes
	})

	FreeScuffleAgent.instance:sendPM_FreeScuffleEndEasterEggGameReq(activityId, clickTimes, encryptedKey)
end

function FreeScuffleController:handlePM_FreeScuffleEndEasterEggGameRes(status, msg)
	if status == 0 then
		local mo = self:getSubMo(msg.activityId)

		mo:handlePM_FreeScuffleEndEasterEggGameRes(msg)
		self:_updateRedInWorkEvent(msg.activityId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FreeScuffleEndEasterEggGameRes, status, msg)
end

function FreeScuffleController:sendPM_FreeScuffleDeliverPackageReq(activityId, packageId, blockId)
	FreeScuffleAgent.instance:sendPM_FreeScuffleDeliverPackageReq(activityId, packageId, blockId)
end

function FreeScuffleController:handlePM_FreeScuffleDeliverPackageRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_FreeScuffleDeliverPackageRes(msg)
	self:_updateRedInWorkEvent(msg.activityId)

	if msg:HasField("changeSetId") then
		MaterialController.instance:setChangeSetPopup(msg.changeSetId, MaterialController.CI_SHOW_TYPE_FLY)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FreeScuffleDeliverPackageRes)
end

function FreeScuffleController:sendPM_FreeScuffleRandomEventLotteryReq(activityId)
	FreeScuffleAgent.instance:sendPM_FreeScuffleRandomEventLotteryReq(activityId)
end

function FreeScuffleController:handlePM_FreeScuffleRandomEventLotteryRes(status, msg)
	if status == 0 then
		local mo = self:getSubMo(msg.activityId)

		mo:handlePM_FreeScuffleRandomEventLotteryRes(msg)
		self:_updateRedInWorkEvent(msg.activityId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FreeScuffleRandomEventLotteryRes, status, msg)
end

function FreeScuffleController:sendPM_FreeScuffleExitInterfaceReq(activityId)
	FreeScuffleAgent.instance:sendPM_FreeScuffleExitInterfaceReq(activityId)
end

function FreeScuffleController:handlePM_FreeScuffleExitInterfaceRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_FreeScuffleExitInterfaceRes(msg)
	self:_updateRedInWorkEvent(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FreeScuffleExitInterfaceRes)
end

function FreeScuffleController:sendPM_FreeScuffleGainTaskProgressPrizeReq(activityId, progressId)
	FreeScuffleAgent.instance:sendPM_FreeScuffleGainTaskProgressPrizeReq(activityId, progressId)
end

function FreeScuffleController:handlePM_FreeScuffleGainTaskProgressPrizeRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_FreeScuffleGainTaskProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FreeScuffleGainTaskProgressPrizeRes)
end

function FreeScuffleController:sendPM_FreeScuffleResetNextPackageReq(activityId)
	FreeScuffleAgent.instance:sendPM_FreeScuffleResetNextPackageReq(activityId)
end

function FreeScuffleController:handlePM_FreeScuffleResetNextPackageRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_FreeScuffleResetNextPackageRes(msg)
	self:_updateRedInWorkEvent(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FreeScuffleResetNextPackageRes)
end

function FreeScuffleController:sendPM_FreeScuffleEnterInterfaceReq(activityId)
	FreeScuffleAgent.instance:sendPM_FreeScuffleEnterInterfaceReq(activityId)
end

function FreeScuffleController:handlePM_FreeScuffleEnterInterfaceRes(status, msg)
	if status == 0 then
		local mo = self:getSubMo(msg.activityId)

		mo:handlePM_FreeScuffleEnterInterfaceRes(msg)
		self:_updateRedInWorkEvent(msg.activityId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FreeScuffleEnterInterfaceRes, status, msg)
end

function FreeScuffleController:sendPM_FreeScuffleBattleInfoReq(activityId)
	FreeScuffleAgent.instance:sendPM_FreeScuffleBattleInfoReq(activityId)
end

function FreeScuffleController:handlePM_FreeScuffleBattleInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_FreeScuffleBattleInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FreeScuffleBattleInfoRes)
end

function FreeScuffleController:sendPM_FreeScuffleSetFormReq(activityId, form, petSkillList, heroSkill, heroSkillCreepsId)
	FreeScuffleAgent.instance:sendPM_FreeScuffleSetFormReq(activityId, form, petSkillList, heroSkill, heroSkillCreepsId)
end

function FreeScuffleController:handlePM_FreeScuffleSetFormRes(status, msg)
	if status == 0 then
		local mo = self:getSubMo(msg.activityId)

		mo:handlePM_FreeScuffleSetFormRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FreeScuffleSetFormRes, status)
end

function FreeScuffleController:sendPM_FreeScuffleChangeSkillReq(activityId, petList)
	FreeScuffleAgent.instance:sendPM_FreeScuffleChangeSkillReq(activityId, petList)
end

function FreeScuffleController:handlePM_FreeScuffleChangeSkillRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_FreeScuffleChangeSkillRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FreeScuffleChangeSkillRes)
end

function FreeScuffleController:sendPM_FreeScuffleMatchReq(activityId)
	FreeScuffleAgent.instance:sendPM_FreeScuffleMatchReq(activityId)
end

function FreeScuffleController:handlePM_FreeScuffleMatchRes(status, msg)
	if status == 0 then
		local mo = self:getSubMo(msg.activityId)

		mo:handlePM_FreeScuffleMatchRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FreeScuffleMatchRes, status)
end

function FreeScuffleController:sendPM_FreeScuffleBattleReq(activityId, form, heroSkill, heroSkillCreepsId)
	FreeScuffleAgent.instance:sendPM_FreeScuffleBattleReq(activityId, form, heroSkill, heroSkillCreepsId)
end

function FreeScuffleController:handlePM_FreeScuffleBattleRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FreeScuffleBattleRes)
end

function FreeScuffleController:sendPM_FreeScuffleRankViewReq(activityId, rankId)
	FreeScuffleAgent.instance:sendPM_FreeScuffleRankViewReq(activityId, rankId)
end

function FreeScuffleController:handlePM_FreeScuffleRankViewRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FreeScuffleRankViewRes, msg)
end

function FreeScuffleController:handlePM_FreeScuffleBattleNotifyRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_FreeScuffleBattleNotifyRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_FreeScuffleBattleNotifyRes)
end

function FreeScuffleController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.FreeScuffle)
end

function FreeScuffleController:getSubMo(activityId)
	return FreeScuffleModel.instance:getSubMo(activityId)
end

function FreeScuffleController:getCurBuffId(activityId)
	local activityType = ActivityDefineController.instance:getActTypeByActId(activityId)
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, activityId)
	local day = GameUtil.getDaysByTimestamp(startTime, ServerTime.now()) - 1
	local cfg = FreeScuffleConfig.instance:getGlobalBuffCfg(activityId) or {}
	local length = #cfg

	if length > 0 then
		return (day - 1) % length + 1
	else
		return 0
	end
end

function FreeScuffleController:_updateRedInTask(activityId)
	local redId = RedPointModel.ID_FreeScuffle_Task
	local isActivated = false
	local groupDic = {}

	if ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		local subMo = self:getSubMo(activityId)
		local cfg = FreeScuffleConfig.instance:getTaskCfg(activityId) or {}

		for _, data in ipairs(cfg) do
			groupDic[data.group] = groupDic[data.group] or false

			if not isActivated or not groupDic[data.group] then
				local isCan = subMo:isCanGainOfTask(data.taskId)

				if isCan then
					isActivated = true
					groupDic[data.group] = true
				end
			end
		end
	end

	for group, bool in pairs(groupDic) do
		local redId = self:getTaskGroupRedId(activityId, group)

		RedPointController.instance:setRedPointInfo(redId, bool)
	end

	RedPointController.instance:setRedPointInfo(redId, isActivated)
end

function FreeScuffleController:getTaskGroupRedId(activityId, group)
	return string.format("FreeScuffle_Task_%s_%s", activityId, group)
end

function FreeScuffleController:_updateRedInWorkEvent(activityId)
	local redId = RedPointModel.ID_FreeScuffle_WorkEvent
	local isActivated = false

	if ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		local subMo = self:getSubMo(activityId)

		if subMo:isOverLastEggGame() or subMo:isOverLastRandomEventLottery() or subMo:isOverPackage() then
			isActivated = true
		end
	end

	RedPointController.instance:setRedPointInfo(redId, isActivated)
end

function FreeScuffleController:enterFreeScuffleRunning(activityId, isEnter)
	if isEnter then
		self._opStateDelta[activityId] = self._opStateDelta[activityId] or 0

		if self._opStateDelta[activityId] == 0 then
			if TableUtil.isTableEmpty(self._runningActivityIds) then
				settimer(0, self._onTicking, self, true)
				self:_onTicking()
				FreeScuffleController.instance:sendPM_FreeScuffleBattleInfoReq(activityId)
			end

			self._runningActivityIds[activityId] = activityId
		end

		self._opStateDelta[activityId] = self._opStateDelta[activityId] + 1
	elseif self._opStateDelta[activityId] then
		self._opStateDelta[activityId] = Mathf.Max(self._opStateDelta[activityId] - 1, 0)

		if self._opStateDelta[activityId] <= 0 then
			self._opStateDelta[activityId] = 0
			self._runningActivityIds[activityId] = nil

			if TableUtil.isTableEmpty(self._runningActivityIds) then
				removetimer(self._onTicking, self)
			end
		end
	end
end

function FreeScuffleController:closeFreeScuffleRuning()
	self._opStateDelta = {}
	self._runningActivityIds = {}

	removetimer(self._onTicking, self)
end

function FreeScuffleController:_onTicking()
	for activityId, _ in pairs(self._runningActivityIds) do
		self:getSubMo(activityId):onTicking()
	end
end

function FreeScuffleController:enterWorkScene(activityId, isEnter, isRoot)
	if isEnter then
		self._enterDeltaWorks[activityId] = self._enterDeltaWorks[activityId] or 0

		if self._enterDeltaWorks[activityId] == 0 and isRoot then
			self._openWorkSceneTags[activityId] = activityId

			self:sendPM_FreeScuffleEnterInterfaceReq(activityId)
		end

		self._enterDeltaWorks[activityId] = self._enterDeltaWorks[activityId] + 1
	elseif self._enterDeltaWorks[activityId] then
		self._enterDeltaWorks[activityId] = Mathf.Max(self._enterDeltaWorks[activityId] - 1, 0)

		if self._enterDeltaWorks[activityId] <= 0 and self._openWorkSceneTags[activityId] then
			self._openWorkSceneTags[activityId] = nil

			self:sendPM_FreeScuffleExitInterfaceReq(activityId)
		end
	end
end

function FreeScuffleController:clearWorSceneMgr()
	self._enterDeltaWorks = {}
	self._openWorkSceneTags = {}
end

function FreeScuffleController:enterPkBattle(activityId, opponent)
	local fmtMo = FreeScuffleModel.instance:getPkFmtMo()

	fmtMo:updateCfg(activityId, opponent)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function FreeScuffleController:enterFormation(activityId)
	local customFmtMo = FreeScuffleModel.instance:getFormationCustomFmtMo()

	customFmtMo:updateCfg(activityId)
	CustomFmtController.instance:showMissionFormationView(customFmtMo)
end

function FreeScuffleController:openCommonTabRankView(activityId)
	local params = CommonTabRankParams.New()

	params:addTabData(ViewName.FreeScufflleWealthChildRankView, ViewName.FreeScufflleWealthChildRankView, "收益榜", {
		activityId
	})
	params:addTabData(ViewName.FreeScuffllePkChildRankView, ViewName.FreeScuffllePkChildRankView, "胜者榜", {
		activityId
	})
	params:setOnEnterCallBackInFather(function()
		FreeScuffleController.instance:enterFreeScuffleRunning(activityId, true)
		FreeScuffleController.instance:enterWorkScene(activityId, true)
	end)
	params:setOnExitCallBackInFather(function()
		FreeScuffleController.instance:enterFreeScuffleRunning(activityId, false)
		FreeScuffleController.instance:enterWorkScene(activityId, false)
	end)
	UIStateManager.instance:push(ViewName.CommonTabRankFatherView, params)
end

function FreeScuffleController:getCreepsSkillId(activityId, creepsId, skillType)
	local petData = FreeScuffleConfig.instance:getScuffleBattlePetData(activityId, creepsId)
	local skinId = checknumber(petData and petData.faceId)

	if skinId <= 0 then
		skinId = checknumber(petData and petData.raceId)
	end

	local skillId = 0
	local data = PetSkinConfig.instance:getPetSkinCfg(skinId)

	if data == nil then
		-- block empty
	elseif skillType == FreeScuffleEnum.SkillTypes_Normal then
		skillId = data.normalSkillId
	elseif skillType == FreeScuffleEnum.SkillTypes_Ult then
		skillId = data.ultSkillId
	elseif skillType == FreeScuffleEnum.SkillTypes_Hero then
		skillId = data.heroSkillId
	end

	return skillId
end

function FreeScuffleController:isHeroPetInBattle(activityId, creepsId)
	local skillId = self:getCreepsSkillId(activityId, creepsId, FreeScuffleEnum.SkillTypes_Hero)

	return skillId > 0
end

function FreeScuffleController:getCompleteSkillList(skillLists)
	local result = {}

	if skillLists then
		local skillNum = table.nums(FreeScuffleEnum.SkillIndexs)

		for creepsId, skillList in pairs(skillLists) do
			local info = {}

			info.creepsId = creepsId
			info.skillIds = {}

			for idx = 1, skillNum do
				info.skillIds[idx] = checknumber(skillList[idx])
			end

			table.insert(result, info)
		end
	end

	return result
end

function FreeScuffleController:isNewItem(activityId, poolType, itemId)
	local key = self:_getKeyInNewItem(activityId, poolType, itemId)
	local isHasGain = GameUtil.getUserData(key)

	return not isHasGain
end

function FreeScuffleController:setNotNewItem(activityId, poolType, itemId)
	local key = self:_getKeyInNewItem(activityId, poolType, itemId)

	GameUtil.saveUserData(key, true)
end

function FreeScuffleController:_getKeyInNewItem(activityId, poolType, itemId)
	return string.format("freeScuffle_new_%s_%s_%s", activityId, poolType, itemId)
end

FreeScuffleController.instance = FreeScuffleController.New()

return FreeScuffleController
