-- chunkname: @modules/logic/fight/mgr/FightPlayMgr.lua

module("modules.logic.fight.mgr.FightPlayMgr", package.seeall)

local FightPlayMgr = class("FightPlayMgr", FightBaseClass)

function FightPlayMgr:onConstructor()
	self.workComp = self:addComponent(FightWorkComponent)

	self:com_registMsg(FightMsgId.ForceReleasePlayFlow, self.onForceReleasePlayFlow)
	self:com_registFightEvent(FightEvent.StageChanged, self.onStageChanged)
end

function FightPlayMgr:onForceReleasePlayFlow()
	self.workComp:disposeAllWork()
end

function FightPlayMgr:onStageChanged(curStage, preStage)
	if curStage == FightStageMgr.StageType.Play then
		self.workComp:disposeAllWork()
	end
end

function FightPlayMgr:playStart()
	if FightDataHelper.stateMgr.isFinish then
		DungeonModel.instance.curSendEpisodeId = nil

		MainController.instance:enterMainScene(true)

		return
	end

	FightDataHelper.stageMgr:setStage(FightStageMgr.StageType.Play)

	local flow = self.workComp:registWork(FightWorkFlowSequence)

	flow:registWork(FightWorkPlayStart)
	flow:registWork(FightWorkPlay2Operate, true)
	flow:start()
end

function FightPlayMgr:playShow()
	if FightGameMgr.skipPerformance then
		self:skipFightPerformance()

		return
	end

	FightDataHelper.stageMgr:setStage(FightStageMgr.StageType.Play)

	local flow = self.workComp:registWork(FightWorkFlowSequence)

	flow:registWork(FightWorkPlayShow)
	flow:registWork(FightWorkPlay2Operate)
	flow:start()
end

function FightPlayMgr:playCloth()
	if FightDataHelper.tempMgr.is3_7BossQtePre then
		FightDataHelper.tempMgr.is3_7BossQtePre = nil

		return
	end

	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.ClothSkill)
	FightDataHelper.stageMgr:setStage(FightStageMgr.StageType.Play)

	local flow = self.workComp:registWork(FightWorkFlowSequence)

	flow:registWork(FightWorkPlayCloth)
	flow:registWork(FightWorkPlay2Operate, false, true)
	flow:start()
end

function FightPlayMgr:playEnd()
	self.workComp:disposeAllWork()

	FightDataHelper.stateMgr.isFinish = true

	if FightDataHelper.tempMgr.isSkipBattle then
		return
	end

	if self:checkTowerComposeHasNextPlane() then
		FightGameMgr.switchPlaneMgr:switchPlane()

		return
	end

	if FightSystem.instance.restarting then
		return
	end

	if FightRestartHelper.tryRestart() then
		return
	end

	ViewMgr.instance:closeView(ViewName.FightQuitTipView)
	ViewMgr.instance:closeView(ViewName.MessageBoxView)
	FightGameMgr.restartMgr:killComponent(FightFlowComponent)
	FightDataMgr.instance.stateMgr:setPlayingEnd(true)
	self:_PlayEnd()
end

function FightPlayMgr:checkTowerComposeHasNextPlane()
	local fightRecordMO = FightModel.instance:getRecordMO()

	if not fightRecordMO then
		return
	end

	if fightRecordMO.fightResult ~= FightEnum.FightResult.Succ then
		return
	end

	local customData = FightDataHelper.getCustomData(FightCustomData.CustomDataType.TowerCompose)
	local planeId = customData and customData.planeId
	local maxPlane = customData and customData.maxPlaneId

	if not planeId then
		return
	end

	if not maxPlane then
		return
	end

	local themeId = customData and customData.themeId

	if planeId < maxPlane and themeId then
		local bossSettleMo = TowerComposeModel.instance:getBossSettleInfo()

		if bossSettleMo and bossSettleMo:getPlaneSettleData(maxPlane) then
			return false
		end
	end

	return planeId < maxPlane
end

function FightPlayMgr:_PlayEnd()
	local flow = self.workComp:registWork(FightWorkFlowSequence)

	flow:registWork(FightWorkPlayEnd)
	flow:registFinishCallback(self.onEndFinish, self)
	flow:start()
end

function FightPlayMgr:onEndFinish()
	FightController.instance:dispatchEvent(FightEvent.OnEndSequenceFinish)
end

function FightPlayMgr:playReconnect()
	FightController.instance:dispatchEvent(FightEvent.OnFightReconnect)

	if FightModel.instance:isFinish() then
		FightRpc.instance:sendEndFightRequest(false)
	else
		local flow = self.workComp:registWork(FightWorkFlowSequence)

		flow:registWork(FightWorkPlayReconnect)
		flow:registWork(FightWorkPlay2Operate, true)
		flow:start()
	end
end

function FightPlayMgr:skipFightPerformance()
	if FightModel.instance:isFinish() then
		FightRpc.instance:sendEndFightRequest(false)

		return
	end

	local flow = self:com_registFlowSequence()

	flow:registWork(FightWorkRefreshFightAfterCrash)
	flow:registWork(FightWorkPlay2Operate)
	flow:start()
end

function FightPlayMgr:onDestructor()
	return
end

return FightPlayMgr
