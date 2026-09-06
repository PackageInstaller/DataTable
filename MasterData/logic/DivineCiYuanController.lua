-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineciyuan/controller/DivineCiYuanController.lua

module("logic.extensions.divineciyuan.controller.DivineCiYuanController", package.seeall)

local DivineCiYuanController = class("DivineCiYuanController", BaseController)

function DivineCiYuanController:ctor()
	return
end

function DivineCiYuanController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("enterdivineciyuan", self._enterDivineCiYuan, self)
end

function DivineCiYuanController:onReset()
	return
end

function DivineCiYuanController:_enterDivineCiYuan(params)
	self:enterDivineCiYuan(checknumber(params[1]))
end

function DivineCiYuanController:enterDivineCiYuan(activityId)
	if checknumber(activityId) <= 0 then
		activityId = DivineCiYuanController.instance:getActivityId()
	end

	if not self:isInActivityTime(activityId) then
		FloatWordMgr.instance:show("不在活动开始时间内")

		return
	end

	UIStateManager.instance:push(ViewName.DivineCiYuanChallengeView, activityId)
end

function DivineCiYuanController:sendPM_DivineCiYuanGetInfoReq(activityId)
	DivineCiYuanChallengeAgent.instance:sendPM_DivineCiYuanGetInfoReq(activityId)
end

function DivineCiYuanController:handlePM_DivineCiYuanGetInfoRes(status, msg)
	DivineCiYuanModel.instance:setCiYuanInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineCiYuanGetInfoRes, msg)
end

function DivineCiYuanController:sendPM_DivineCiYuanGainPrizeReq(activityId, type)
	DivineCiYuanChallengeAgent.instance:sendPM_DivineCiYuanGainPrizeReq(activityId, type)
end

function DivineCiYuanController:handlePM_DivineCiYuanGainPrizeRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineCiYuanGainPrizeRes, msg)
end

function DivineCiYuanController:sendPM_DivineCiYuanGainSelectBuffReq(activityId, tabId, buffId)
	DivineCiYuanChallengeAgent.instance:sendPM_DivineCiYuanGainSelectBuffReq(activityId, tabId, buffId)
end

function DivineCiYuanController:handlePM_DivineCiYuanGainSelectBuffRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineCiYuanGainSelectBuffRes, msg)
end

function DivineCiYuanController:sendPM_DivineCiYuanExtremeChallengeReq(activityId, tabId, stageId, teamIndex, form)
	if ActivityDefineController.instance:isAoqiGodProcessType(activityId) then
		BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onAoqiGodExtremeBattleEnd, self, activityId), self)
	end

	DivineCiYuanChallengeAgent.instance:sendPM_DivineCiYuanExtremeChallengeReq(activityId, tabId, stageId, teamIndex, form)
end

function DivineCiYuanController:handlePM_DivineCiYuanExtremeChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	else
		BattleFacade.instance:registerResultHandler(nil, nil)
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DivineCiYuanController:_onAoqiGodExtremeBattleEnd(activityId)
	BattleFacade.instance:registerResultHandler(nil, nil)

	if ActivityDefineController.instance:isAoqiGodProcessType(activityId) then
		AoqiGodController.instance:doHandleChallengeFinishReady(GameEnum.ActivityType.DivineCiYuan, activityId)
	end

	return false
end

function DivineCiYuanController:sendPM_DivineCiYuanExtremeResetReq(activityId, tabId, stageId, teamIndex)
	DivineCiYuanChallengeAgent.instance:sendPM_DivineCiYuanExtremeResetReq(activityId, tabId, stageId, teamIndex)
end

function DivineCiYuanController:handlePM_DivineCiYuanExtremeResetRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineCiYuanExtremeResetRes, msg)
end

function DivineCiYuanController:sendPM_DivineCiYuanUniversalChallengeReq(activityId, tabId, bossId, form)
	DivineCiYuanChallengeAgent.instance:sendPM_DivineCiYuanUniversalChallengeReq(activityId, tabId, bossId, form)
end

function DivineCiYuanController:handlePM_DivineCiYuanUniversalChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DivineCiYuanController:sendPM_DivineCiYuanUniversalOneKeyPassReq(activityId, priceCount)
	DivineCiYuanChallengeAgent.instance:sendPM_DivineCiYuanUniversalOneKeyPassReq(activityId, priceCount)
end

function DivineCiYuanController:handlePM_DivineCiYuanUniversalOneKeyPassRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineCiYuanUniversalOneKeyPassRes, msg)
end

function DivineCiYuanController:sendPM_DivineCiYuanUniversalSignInReq(activityId, tabId)
	DivineCiYuanChallengeAgent.instance:sendPM_DivineCiYuanUniversalSignInReq(activityId, tabId)
end

function DivineCiYuanController:handlePM_DivineCiYuanUniversalSignInRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineCiYuanUniversalSignInRes, msg)
end

function DivineCiYuanController:sendPM_DivineCiYuanUniversalOneKeySignInReq(activityId)
	DivineCiYuanChallengeAgent.instance:sendPM_DivineCiYuanUniversalOneKeySignInReq(activityId)
end

function DivineCiYuanController:handlePM_DivineCiYuanUniversalOneKeySignInRes(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.DivineCiYuanUniversalSignInRes, msg)
end

function DivineCiYuanController:handlePM_Notify_DivineCiYuanUniversalChallengeRes(status, msg)
	local lefthp = msg.leftHp

	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.DivineCiYuanNationChallenge, lefthp)
end

function DivineCiYuanController:handlePM_Notify_DivineCiYuanExtremeChallengeRes(status, msg)
	if status ~= 0 then
		return
	end

	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
end

function DivineCiYuanController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.DivineCiYuan)
end

function DivineCiYuanController:isInActivityTime(activityId)
	local activityType = ActivityDefineController.instance:getActTypeByActId(activityId)

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function DivineCiYuanController:getExtremetTabId(activityId)
	local infos = DivineCiYuanModel.instance:getExtremeInfo()

	if TableUtil.isTableEmpty(infos) then
		return 1
	end

	local tabCfg = DivineCiYuanConfig.instance:getTabCfg(activityId)

	for tabId, tabInfo in ipairs(tabCfg) do
		local isPass = self:isPassExtremeTab(activityId, tabInfo.tabId)

		if not isPass then
			return tabInfo.tabId
		end

		if not self:isUnLockExtremeTab(activityId, tabInfo.tabId + 1) then
			return tabInfo.tabId
		end
	end

	return 1
end

function DivineCiYuanController:isUnLockExtremeTab(activityId, tabId)
	local cfg = DivineCiYuanConfig.instance:getTabCfgById(activityId, tabId)

	if cfg == nil then
		return false
	end

	local isPass = self:isPassExtremeTab(activityId, tabId - 1)

	if ActivityDefineController.instance:isAoqiGodProcessType(activityId) then
		return isPass
	end

	local nowTime = ServerTime.now()
	local isOpenTime = nowTime >= GameUtil.string2time(cfg.openTime)

	return isPass and isOpenTime
end

function DivineCiYuanController:extremeLockDesc(activityId, tabId)
	local upStageCfg = DivineCiYuanConfig.instance:getTabCfgById(activityId, tabId - 1)
	local cfg = DivineCiYuanConfig.instance:getTabCfgById(activityId, tabId)

	if ActivityDefineController.instance:isAoqiGodProcessType(activityId) and upStageCfg then
		return string.format("通关%s后开启", upStageCfg.name)
	end

	local timeDate = GameUtil.string2date(cfg.openTime)

	if upStageCfg then
		return string.format("通关%s\n%02d.%02d %02d点后开启", upStageCfg.name, timeDate.month, timeDate.day, timeDate.hour)
	end

	return string.format("%02d.%02d %02d点后开启", timeDate.month, timeDate.day, timeDate.hour)
end

function DivineCiYuanController:isPassExtremeTab(activityId, tabId)
	if tabId < 1 then
		return true
	end

	local infos = DivineCiYuanModel.instance:getExtremeInfo()

	if TableUtil.isTableEmpty(infos) then
		return false
	end

	for _, tabInfo in ipairs(infos.tabInfos) do
		if tabInfo.tabId == tabId then
			local cfg = DivineCiYuanConfig.instance:getExtremeStageCfg(activityId, tabId)

			if tabInfo.passedStageId >= #cfg then
				return true
			end
		end
	end

	return false
end

function DivineCiYuanController:isPassNextLock(activityId, tabId)
	local isPass = self:isPassExtremeTab(activityId, tabId)
	local isLock = not self:isUnLockExtremeTab(activityId, tabId + 1)

	return isPass and isLock
end

function DivineCiYuanController:isPassExtremeStage(tabId, stageId)
	local infos = DivineCiYuanModel.instance:getExtremeInfo()

	if TableUtil.isTableEmpty(infos) then
		return false
	end

	for _, tabInfo in ipairs(infos.tabInfos) do
		if tabInfo.tabId == tabId then
			return stageId <= tabInfo.passedStageId
		end
	end

	return false
end

function DivineCiYuanController:isPassExtremeTeam(activityId, tabId, stageId, teamIndex)
	local infos = DivineCiYuanModel.instance:getExtremeInfo()

	if TableUtil.isTableEmpty(infos) then
		return false
	end

	local teamCount = #DivineCiYuanConfig.instance:getExtremeStageCfgById(activityId, tabId, stageId).teamIds
	local stageCount = #DivineCiYuanConfig.instance:getExtremeStageCfg(activityId, tabId)

	for _, tabInfo in ipairs(infos.tabInfos) do
		if tabInfo.tabId == tabId then
			if stageId <= tabInfo.passedStageId then
				return true
			end

			if TableUtil.isTableEmpty(tabInfo.teamInfos) then
				return false
			end

			for _, teamInfo in ipairs(tabInfo.teamInfos) do
				if teamInfo.teamIndex == teamIndex then
					return true
				end
			end
		end
	end

	return false
end

function DivineCiYuanController:isPassExtremeChallenge(activityId)
	local infos = DivineCiYuanModel.instance:getExtremeInfo()

	if TableUtil.isTableEmpty(infos) then
		return false
	end

	local tabCfg = DivineCiYuanConfig.instance:getTabCfg(activityId)

	for tabId, tabInfo in ipairs(tabCfg) do
		if not self:isPassExtremeTab(activityId, tabInfo.tabId) then
			return false
		end
	end

	return true
end

function DivineCiYuanController:isSelectBuff(tabId)
	return DivineCiYuanModel.instance:getSelectBuffId(tabId) > 0
end

function DivineCiYuanController:sortUniversalStage(activityId, tabId)
	local stageCfg = DivineCiYuanConfig.instance:getUniversalStageCfg(activityId, tabId)
	local data = {}

	for _, v in ipairs(stageCfg) do
		local info = {}

		info.cfg = v
		info.bossInfo = DivineCiYuanModel.instance:getBossInfoById(tabId, v.bossId)

		table.insert(data, info)
	end

	table.sort(data, function(a, b)
		local leftHpA, bossHpA = checknumber(a.bossInfo.leftHp), checknumber(a.bossInfo.bossHp)
		local leftHpB, bossHpB = checknumber(b.bossInfo.leftHp), checknumber(b.bossInfo.bossHp)
		local isPassA = leftHpA <= 0
		local isPassB = leftHpB <= 0

		if isPassA and isPassB then
			return a.cfg.bossId < b.cfg.bossId
		elseif leftHpA > 0 and leftHpB > 0 then
			return leftHpA < leftHpB
		else
			return not isPassA
		end

		return a.cfg.bossId < b.cfg.bossId
	end)

	return data
end

function DivineCiYuanController:isUnLockUniversalTab(tabId)
	return self:isPassUniversalTab(tabId - 1)
end

function DivineCiYuanController:isPassUniversalTab(tabId)
	if tabId < 1 then
		return true
	end

	local isOneKey = DivineCiYuanModel.instance:getIsOneKeyPass()

	if isOneKey then
		return true
	end

	local infos = DivineCiYuanModel.instance:getUniversalInfo()

	for _, tabInfo in ipairs(infos.tabInfos) do
		if tabInfo.tabId == tabId then
			for _, boss in ipairs(tabInfo.bossInfos) do
				if checknumber(boss.leftHp) > 0 then
					return false
				end
			end
		end
	end

	return true
end

function DivineCiYuanController:getUniversalChallengeProgress(activityId, tabId)
	local isOneKey = DivineCiYuanModel.instance:getIsOneKeyPass()
	local tabCfg = DivineCiYuanConfig.instance:getUniversalStageCfg(activityId, tabId)

	if isOneKey then
		return #tabCfg
	end

	local progress = 0
	local infos = DivineCiYuanModel.instance:getUniversalInfo()

	for _, tabInfo in ipairs(infos.tabInfos) do
		if tabInfo.tabId == tabId then
			for _, boss in ipairs(tabInfo.bossInfos) do
				if checknumber(boss.leftHp) <= 0 then
					progress = progress + 1
				end
			end
		end
	end

	return progress
end

function DivineCiYuanController:isUnLockSign(activityId, tabId)
	local isOneKeySign = DivineCiYuanModel.instance:getHasOneKeySignIn()
	local isAllSign = self:isAllSign(activityId, tabId - 1)
	local isPass = self:isPassUniversalTab(tabId - 1)

	return isAllSign and isPass
end

function DivineCiYuanController:isUnLockSignDay(activityId, tabId, dayId)
	local signDays = self:getSignInfo(activityId, tabId)

	return dayId <= signDays
end

function DivineCiYuanController:getSignInfo(activityId, tabId)
	local actCfg = DivineCiYuanConfig.instance:getActCfgById(activityId)
	local isOneKeySign = DivineCiYuanModel.instance:getHasOneKeySignIn()
	local allDayCount = #DivineCiYuanConfig.instance:getUniversalSignCfg(activityId, tabId)

	if isOneKeySign then
		return allDayCount, true
	end

	local infos = DivineCiYuanModel.instance:getUniversalInfo()
	local days = 0
	local hasSignToday = infos.todaySignTimes >= actCfg.universalSignInTimes

	for _, tabInfo in ipairs(infos.tabInfos) do
		if tabInfo.tabId == tabId then
			days = tabInfo.days
		end
	end

	return days, hasSignToday
end

function DivineCiYuanController:getSignProgress(activityId)
	local isOneKeySign = DivineCiYuanModel.instance:getHasOneKeySignIn()
	local tabId = 1
	local days = 0

	if isOneKeySign then
		tabId = #DivineCiYuanConfig.instance:getUniversalAllSignCfg(activityId)
		days = #DivineCiYuanConfig.instance:getUniversalSignCfg(activityId, tabId)
	elseif self:isAllSign(activityId, tabId) then
		local tabSignDay = self:getSignInfo(activityId, tabId + 1)

		if tabSignDay > 0 then
			tabId = tabId + 1
			days = tabSignDay
		else
			days = #DivineCiYuanConfig.instance:getUniversalSignCfg(activityId, tabId)
		end
	else
		days = self:getSignInfo(activityId, tabId)
	end

	return tabId, days
end

function DivineCiYuanController:getRemainSignPrice(activityId)
	local signDay = 0
	local infos = DivineCiYuanModel.instance:getUniversalInfo()
	local cfg = DivineCiYuanConfig.instance:getUniversalSignPriceCfg(activityId)
	local totalDay = cfg[#cfg].days

	for _, tabInfo in ipairs(infos.tabInfos) do
		signDay = signDay + tabInfo.days
	end

	local remainDay = totalDay - signDay
	local data = cfg[remainDay]

	return data and data.price
end

function DivineCiYuanController:isAllSign(activityId, tabId)
	if tabId < 1 then
		return true
	end

	local signCfg = DivineCiYuanConfig.instance:getUniversalSignCfg(activityId, tabId)
	local signDays, _ = self:getSignInfo(activityId, tabId)

	return signDays >= #signCfg
end

function DivineCiYuanController:isLightSignRd()
	local isOneKeySign = DivineCiYuanModel.instance:getHasOneKeySignIn()

	if isOneKeySign then
		return false
	end

	local infos = DivineCiYuanModel.instance:getUniversalInfo()
	local hasSignToday = false

	for _, tabInfo in ipairs(infos.tabInfos) do
		if tabInfo.hasSignToday then
			hasSignToday = true
		end
	end

	return not hasSignToday
end

function DivineCiYuanController:openDivineCiYuanNationalForm(activityId, tabId, bossId)
	CustomFmtController.instance:showMissionView(DivineCiYuanModel.instance:getNationalChallengeFmtMo(activityId, tabId, bossId))
end

function DivineCiYuanController:openDivineCiYuanExtremeForm(activityId, tabId, stageId, teamIndex)
	CustomFmtController.instance:showMissionView(DivineCiYuanModel.instance:getExtremeChallengeFmtMo(activityId, tabId, stageId, teamIndex))
end

DivineCiYuanController.instance = DivineCiYuanController.New()

return DivineCiYuanController
