-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/controller/LailisiController.lua

module("logic.extensions.lailisi.controller.LailisiController", package.seeall)

local LailisiController = class("LailisiController", BaseController)

function LailisiController:ctor()
	return
end

function LailisiController:onInit()
	LailisiController.super.onInit(self)
	self:onReset()
end

function LailisiController:onReset()
	self._effList = {}
end

function LailisiController:sendPM_ActorGainGetInfoReq()
	ActorGainAgent.instance:sendPM_ActorGainGetInfoReq()
end

function LailisiController:sendPM_ActorGainChallengeReq(activityId, stageId, curForm)
	local simpleForm = curForm:createFormPb()

	if LailisiModel.instance:isFinalAct(activityId) then
		if not self._handlerBattleEnd then
			local handler = self.__handlerBattleEndFiveKing

			BattleFacade.instance:registerResultHandler(handler, self)
			ActorGainAgent.instance:sendPM_ActorGainChallengeReq(activityId, stageId, simpleForm)
		end
	end
end

function LailisiController:sendPM_ActorGainGetTaskAwardReq(activityId, taskNum)
	ActorGainAgent.instance:sendPM_ActorGainGetTaskAwardReq(activityId, taskNum)
end

function LailisiController:sendPM_ActorGainGetProgressAwardReq(activityId, id)
	ActorGainAgent.instance:sendPM_ActorGainGetProgressAwardReq(activityId, id)
end

function LailisiController:sendPM_ActorGainDamageRankReq(activityId)
	ActorGainAgent.instance:sendPM_ActorGainDamageRankReq(activityId)
end

function LailisiController:setType(actId, taskshow)
	if LailisiModel.instance:isFinalAct(actId) then
		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.LailisiChanllenge, taskshow)
	end
end

function LailisiController:__handlerBattleEndFiveKing()
	BattleFacade.instance:registerResultHandler(nil, nil)

	local function succHandler()
		local viewInfos = LailisiModel.instance:getLastView()

		for _, info in ipairs(viewInfos) do
			UIJumper.instance:pushOneStack(info.viewName, true, unpack(info.params))
			print("lbc==============================", viewInfos.viewName, unpack(info.params))
		end

		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
	end

	local function failHandler()
		local viewInfos = LailisiModel.instance:getLastView()

		for _, info in ipairs(viewInfos) do
			UIJumper.instance:pushOneStack(info.viewName, true, unpack(info.params))
			print("lbc==============================", viewInfos.viewName, unpack(info.params))
		end

		ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
	end

	if BattleModel.instance.battleResult == GameEnum.BattleResult.ExpSuccess then
		succHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Success then
		succHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.DogFall then
		failHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
		failHandler()
	end

	return true
end

function LailisiController:_handlerBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)

	local viewInfos = LailisiModel.instance:getLastView()

	for _, info in ipairs(viewInfos) do
		UIJumper.instance:pushOneStack(info.viewName, true, unpack(info.params))
		print("lbc==============================", viewInfos.viewName, unpack(info.params))
	end

	ViewMgr.instance:open(ViewName.BattleSettlementSuccess)

	return true
end

function LailisiController:setChanllengeRedPointState()
	local finalAct = LailisiModel.instance:getFinalActivity()

	if GameUtil.getUserDayData("LailisiMainView" .. finalAct.activityId) == nil then
		GameUtil.saveUserDayData("LailisiMainView" .. finalAct.activityId, 1)
	end
end

function LailisiController:getChanllengeRedPointState()
	local finalAct = LailisiModel.instance:getFinalActivity() or {}

	if GameUtil.getUserDayData("LailisiMainView" .. checknumber(finalAct.activityId)) == nil then
		return true
	end

	return self:getTaskRedPointState()
end

function LailisiController:setTaskRedPointState()
	if GameUtil.getUserDayData("LailisiMainViewTask") == nil then
		GameUtil.saveUserDayData("LailisiMainViewTask", 1)
		GlobalDispatcher:dispatch(GlobalNotify.LailisiChallengeTask)
	end
end

function LailisiController:getTaskRedPointState()
	local finalAct = LailisiModel.instance:getFinalActivity()

	if GameUtil.getUserDayData("LailisiMainViewTask") == nil then
		return true
	end

	local taskInfo = LailisiModel.instance:getTaskInfo(finalAct.activityId)
	local taskCfg = LailisiConfig.instance:getTaskInfo(taskInfo.taskId)
	local taskDetail = LailisiModel.instance:getTaskDetailInfo(finalAct.activityId)

	for k, v in pairs(taskDetail) do
		if not v.taskNum then
			return false
		end

		local cfg = taskCfg[v.taskNum]

		if not v.received and tonumber(v.progress) >= cfg.detectorParam then
			return true
		end
	end

	return false
end

function LailisiController:showUIEff(go, effName, view)
	local effPath = "20220701/xinjuesehuode/" .. effName
	local effect = UIEffectManager.instance:playEffect(view, effPath, go, 0, 0, true, false)

	effect:setParent(go.transform)
	effect:setLocalPos(0, 0, 0)
	effect:setScale(1)
	table.insert(self._effList, effect)
end

function LailisiController:stopEffect()
	for k, v in pairs(self._effList) do
		if v then
			UIEffectManager.instance:stopEffect(v)
		end
	end

	self._effList = {}
end

LailisiController.instance = LailisiController.New()

return LailisiController
