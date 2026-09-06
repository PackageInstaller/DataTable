-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crazypartner/controller/CrazyPartnerController.lua

module("logic.extensions.crazypartner.controller.CrazyPartnerController", package.seeall)

local CrazyPartnerController = class("CrazyPartnerController", BaseController)

CrazyPartnerController.AfterGetInfoResponse = "CrazyPartnerController.AfterGetInfoResponse"
CrazyPartnerController.AfterGainPrizeResponse = "CrazyPartnerController.AfterGainPrizeResponse"
CrazyPartnerController.AfterRankInfoResponse = "CrazyPartnerController.AfterRankInfoResponse"

function CrazyPartnerController:ctor()
	return
end

function CrazyPartnerController:onInit()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._TickDailyRefreshData, self)
	GlobalDispatcher:addListener(GlobalNotify.RoleLogined, self._resetRedPoint, self)
	self:_resetRedPoint()
end

function CrazyPartnerController:_TickDailyRefreshData()
	self:onReset()

	if ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.CRAZY_PARTNER) then
		CrazyPartnerAgent.instance:sendPM_CrazyPartnerInfoReq()
		self:_resetRedPoint()
	end
end

function CrazyPartnerController:_resetRedPoint()
	local activityId = CrazyPartnerModel.instance:getActivityId()
	local activityConf = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.CRAZY_PARTNER, activityId)

	if activityConf and GameUtil.checkIsInTimePeriod(activityConf.startTime, activityConf.endTime) then
		RedPointController.instance:regUserDayRedPoint(RedPointModel.ID_CRAZY_PARTNER_TASK)
		RedPointController.instance:regUserDayRedPoint(RedPointModel.ID_CRAZY_PARTNER)
	end
end

function CrazyPartnerController:onReset()
	CrazyPartnerModel.instance:onReset()
end

function CrazyPartnerController:handleGetInfo(status, msg)
	if status == 0 then
		CrazyPartnerModel.instance:handleGetInfo(msg)
		self:localNotify(CrazyPartnerController.AfterGetInfoResponse)
	end
end

function CrazyPartnerController:sendGainPrize(index)
	CrazyPartnerModel.instance:beforeGainPrize(index)
	CrazyPartnerAgent.instance:sendPM_CrazyPartnerGainPrizeReq(index)
end

function CrazyPartnerController:handleGainPrize(status, msg)
	CrazyPartnerModel.instance:handleGainPrize(status, msg)

	if status == 0 then
		self:localNotify(CrazyPartnerController.AfterGainPrizeResponse)
	end
end

function CrazyPartnerController:reqRankInfo(rankType)
	if rankType == CrazyPartnerConfig.RankTypeDefine.Daily then
		CrazyPartnerAgent.instance:sendPM_CrazyPartnerDailyRankReq()
	elseif rankType == CrazyPartnerConfig.RankTypeDefine.Total then
		CrazyPartnerAgent.instance:sendPM_CrazyPartnerTotalRankReq()
	end
end

function CrazyPartnerController:handleRankInfo(rankType, status, msg)
	if status == 0 then
		CrazyPartnerModel.instance:handleRankInfo(rankType, msg)
		self:localNotify(CrazyPartnerController.AfterRankInfoResponse, rankType)
	end
end

function CrazyPartnerController:handleNotifyChallengeEnd(status, msg)
	if status == 0 then
		CrazyPartnerModel.instance:handleNotifyChallengeEnd(msg)
	end
end

function CrazyPartnerController:handleChallegenResp(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
end

function CrazyPartnerController:enterFightPrepare(difficulty)
	CrazyPartnerModel.instance:beforeFight(difficulty)

	local customFmtMo = CrazyPartnerModel.instance:getCustomFmtMo()

	CustomFmtController.instance:showMissionView(customFmtMo)
end

function CrazyPartnerController:reqStartFight()
	BattleFacade.instance:registerResultHandler(self._handlerBattleEnd, self)

	local info = CrazyPartnerModel.instance.fightInfo
	local form = CrazyPartnerModel.instance:getCustomFmtMo():getCurSimpleForm()
	local difficulty = info.difficulty
	local taskConfMap = CrazyPartnerConfig.instance:getTaskConfMap()
	local curConf = taskConfMap[info.difficulty].conf

	BattleFacade.instance:startFightWithTask(curConf.battleTaskId)
	CrazyPartnerAgent.instance:sendPM_CrazyPartnerChallengeReq(form, difficulty)
end

function CrazyPartnerController:_handlerBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)

	local function doneHandler()
		local viewInfos = CrazyPartnerModel.instance:getViewInfos()

		for _, info in ipairs(viewInfos) do
			UIJumper.instance:pushOneStack(info.viewName, true, unpack(info.params))
		end

		ViewMgr.instance:open(ViewName.CrazyPartnerResultView)
	end

	if BattleModel.instance.battleResult == GameEnum.BattleResult.ExpSuccess then
		doneHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Success then
		doneHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.DogFall then
		doneHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
		doneHandler()
	end

	return true
end

CrazyPartnerController.instance = CrazyPartnerController.New()

return CrazyPartnerController
