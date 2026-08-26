-- chunkname: @modules/logic/fight/mgr/FightGameMgr.lua

module("modules.logic.fight.mgr.FightGameMgr", package.seeall)

local FightGameMgr = class("FightGameMgr", FightBaseClass)

function FightGameMgr:onConstructor()
	FightObject.Counter = 0
	self.mgrList = {}

	self:com_registEvent(ConnectAliveMgr.instance, ConnectEvent.OnLostConnect, self.onLostConnect)
	self:com_registEvent(FightController.instance, FightEvent.BeforeSwitchPlane, self.onSwitchPlane)
	self:com_registEvent(ConnectAliveMgr.instance, ConnectEvent.OnMsgTimeout, self.onMsgTimeout)
	self:com_registEvent(LoginController.instance, LoginEvent.OnBeginLogout, self.onBeginLogout)
	self:com_registEvent(ConnectAliveMgr.instance, ConnectEvent.OnReconnectSucc, self.onReconnectSucc)
	self:com_registEvent(ConnectAliveMgr.instance, ConnectEvent.OnReconnectSucc_def, self.onReconnectSucc_def)
	self:com_registMsg(FightMsgId.RestartGame, self.onRestartGame)

	FightGameMgr.loaderMgr = self:newClass(FightLoaderMgr)
	FightGameMgr.necessaryAssetLoaderMgr = self:newClass(FightNecessaryAssetLoaderMgr)
	FightGameMgr.sceneLevelMgr = self:newClass(FightSceneLevelMgr)
	FightGameMgr.restartMgr = self:newClass(FightRestartMgr)
	FightGameMgr.switchPlaneMgr = self:newClass(FightSwitchPlaneMgr)
end

function FightGameMgr:onLogicEnter()
	self:registMgr()
	self:defineMgrRef()
end

function FightGameMgr:registMgr()
	self.timelinePreLoaderMgr = self:addMgr(FightTimelinePreLoaderMgr)
	self.entityMgr = self:addMgr(FightEntityMgr)
	self.playMgr = self:addMgr(FightPlayMgr)
	self.operateMgr = self:addMgr(FightOperateMgr)
	self.checkCrashMgr = self:addMgr(FightCheckCrashMgr)
	self.cameraMgr = self:addMgr(FightCameraMgr)
	self.lightMgr = self:addMgr(FightLightMgr)
	self.entrustEntityMgr = self:addMgr(FightEntrustEntityMgr)
	self.entrustDeadEntityMgr = self:addMgr(FightEntrustDeadEntityMgr)

	if GameSceneMgr.instance:useDefaultScene() == false then
		self.sceneTriggerSceneAnimatorMgr = self:addMgr(FightSceneTriggerSceneAnimatorMgr)
	end

	self.userDataClassMgr = self:addMgr(FightUserDataClassMgr)
	self.magicCirCleMgr = self:addMgr(FightMagicCircleMgr)
	self.magicCirCleBySKillFlowMgr = self:addMgr(FightMagicCircleBySkillFlowMgr)
	self.entrustedWorkMgr = self:addMgr(FightEntrustedWorkMgr)
	self.buffTypeId2EffectMgr = self:addMgr(FightBuffTypeId2EffectMgr)
	self.entityEvolutionMgr = self:addMgr(FightEntityEvolutionMgr)
	self.specialSceneEffectMgr = self:addMgr(FightSpecialSceneEffectMgr)
	self.specialSceneIdleMgr = self:addMgr(FightSpecialSceneIdleMgr)
	self.dynamicShadowMgr = self:addMgr(FightDynamicShadowMgr)
	self.thunderMatMgr = self:addMgr(FightThunderMatMgr)
	self.entityFootRingMgr = self:addMgr(FightEntityFootRingMgr)
	self.spineColorBySceneMgr = self:addMgr(FightSpineColorBySceneMgr)
	self.bgmMgr = self:addMgr(FightBgmMgr)
	self.bloomMgr = self:addMgr(FightBloomMgr)
	self.asfdMgr = self:addMgr(FightASFDMgr)
	self.transitionMgr = self:addMgr(FightTransitionMgr)
	self.triggerBuffMgr = self:addMgr(FightTriggerBuffMgr)
	self.tokenReleaseEntityMgr = self:addMgr(FightTokenReleaseEntityMgr)
end

function FightGameMgr:addMgr(class)
	local mgr = self:newClass(class)

	table.insert(self.mgrList, mgr)

	return mgr
end

function FightGameMgr:defineMgrRef()
	for i, mgr in ipairs(self.mgrList) do
		for k, v in pairs(self) do
			if v == mgr then
				FightGameMgr[k] = mgr

				break
			end
		end
	end
end

function FightGameMgr:onRestartGame()
	self:clearAndReRegis()
end

function FightGameMgr:onSwitchPlane()
	self:clearAndReRegis()
end

function FightGameMgr:clearAndReRegis()
	for i = #self.mgrList, 1, -1 do
		self.mgrList[i]:disposeSelf()
		table.remove(self.mgrList, i)
	end

	self:registMgr()
	self:defineMgrRef()
end

function FightGameMgr:onLostConnect()
	local playerInfo = PlayerModel.instance:getPlayinfo()
	local str = "战斗超时断线,玩家uid:%d, 战斗id: %d"

	str = string.format(str, playerInfo.userId, FightDataHelper.fieldMgr.battleId or 0)

	local entityDataDic = FightDataHelper.entityMgr.entityDataDic

	for entityId, entityData in pairs(entityDataDic) do
		local needPrint = not not entityData:isMySide()

		if (entityId == "0" or nil) and false then
			str = str .. ", heroId:" .. entityData.modelId
		end
	end

	logError(str)
end

function FightGameMgr:onMsgTimeout()
	NetworkConst.UnresponsiveMsgMaxTime = NetworkConst.UnresponsiveMsgMaxTime + 10
end

function FightGameMgr:onBeginLogout()
	NetworkConst.UnresponsiveMsgMaxTime = 10
end

function FightGameMgr:onReconnectSucc()
	NetworkConst.UnresponsiveMsgMaxTime = 10
end

function FightGameMgr:onReconnectSucc_def()
	NetworkConst.UnresponsiveMsgMaxTime = 10
end

function FightGameMgr:onDestructor()
	return
end

return FightGameMgr
