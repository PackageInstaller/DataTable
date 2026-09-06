-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/halloweenguest/controller/HalloweenGuestController.lua

module("logic.extensions.halloweenguest.controller.HalloweenGuestController", package.seeall)

local HalloweenGuestController = class("HalloweenGuestController", BaseController)

function HalloweenGuestController:ctor()
	return
end

function HalloweenGuestController:onInit()
	HalloweenGuestConfig.instance:getOpenMonsterActivityId()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.tickDailyRefreshData, self)

	self._funcId = 400

	self:onReset()
end

function HalloweenGuestController:onReset()
	GlobalDispatcher:removeListener(GlobalNotify.OnNewFunctionOpen, self._onNewFunctionOpen, self)
	GlobalDispatcher:addListener(GlobalNotify.OnNewFunctionOpen, self._onNewFunctionOpen, self)

	self._cacheActId = nil
end

function HalloweenGuestController:tickDailyRefreshData()
	self:csGetHalloweenSceneMonsterGetInfoReq()
	self:csGetHalloweenBossChallengeGetInfoReq()
end

function HalloweenGuestController:_onNewFunctionOpen(funcIds)
	if funcIds == nil or #funcIds == 0 then
		return
	end

	for _, id in pairs(funcIds) do
		if id and checknumber(id) == self._funcId then
			self:csGetHalloweenSceneMonsterGetInfoReq()
		end
	end
end

function HalloweenGuestController:csGetHalloweenSceneMonsterGetInfoReq()
	if not FuncOpenModel.instance:getFuncIsOpen(self._funcId) then
		return
	end

	self._cacheActId = HalloweenGuestModel.instance.monsterActId

	local actId = HalloweenGuestConfig.instance:getOpenMonsterActivityId()

	if checknumber(actId) <= 0 then
		if ViewMgr.instance:isOpen(ViewName.HalloweenMonster) then
			UIStateManager.instance:clear(true)
		end

		HalloweenGuestModel.instance:initAllSceneNpcShow(self._cacheActId, actId)
	else
		HalloweenSceneMonsterAgent.instance:sendPM_HalloweenSceneMonsterGetInfoReq(actId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.TimedItemChange)
end

function HalloweenGuestController:scSendHalloweenSceneMonsterGetInfo(msg)
	HalloweenGuestModel.instance:scSendHalloweenSceneMonsterGetInfo(msg)
	HalloweenGuestModel.instance:initAllSceneNpcShow(self._cacheActId, msg.activityId)

	self._cacheActId = nil
end

function HalloweenGuestController:csGetHalloweenSceneMonsterChallengeReq(actId, sBaseId, posId)
	HalloweenSceneMonsterAgent.instance:sendPM_HalloweenSceneMonsterChallengeReq(actId, sBaseId, posId)
end

function HalloweenGuestController:scSendHalloweenSceneMonsterChallenge(msg)
	return
end

function HalloweenGuestController:scSendMonsterNotifyChallengeEnd(msg)
	HalloweenGuestModel.instance:scSendMonsterNotifyChallengeEnd(msg)
end

function HalloweenGuestController:csGetHalloweenSceneMonsterGainPrizeReq(prizeId)
	local actId = HalloweenGuestModel.instance.monsterActId

	HalloweenSceneMonsterAgent.instance:sendPM_HalloweenSceneMonsterGainPrizeReq(actId, prizeId)
end

function HalloweenGuestController:scSendHalloweenSceneMonsterGainPrize(msg)
	HalloweenGuestModel.instance:scSendHalloweenSceneMonsterGainPrize(msg)
end

function HalloweenGuestController:csGetHalloweenBossChallengeGetInfoReq()
	if not HalloweenGuestConfig.instance:isSetBossOpenInfo() then
		if ViewMgr.instance:isOpen(ViewName.HalloweenBoss) then
			UIStateManager.instance:clear(true)
		end

		return
	end

	local openInfo = HalloweenGuestModel.instance:getBossOpenInfo()

	if openInfo == nil or openInfo.actId == nil then
		return
	end

	HalloweenBossChallengeAgent.instance:sendPM_HalloweenBossChallengeGetInfoReq(openInfo.actId)
end

function HalloweenGuestController:scSendHalloweenBossChallengeGetInfo(msg)
	HalloweenGuestModel.instance:scSendHalloweenBossChallengeGetInfo(msg)
end

function HalloweenGuestController:csGetHalloweenBossChallengeReq(actId, bossId)
	HalloweenBossChallengeAgent.instance:sendPM_HalloweenBossChallengeReq(actId, bossId)
end

function HalloweenGuestController:scSendHalloweenBossChallenge(msg)
	return
end

function HalloweenGuestController:scSendBossNotifyChallengeEnd(msg)
	HalloweenGuestModel.instance:scSendBossNotifyChallengeEnd(msg)
end

function HalloweenGuestController:csGetHalloweenBossChallengeGainDailyPrizeReq()
	local openInfo = HalloweenGuestModel.instance:getBossOpenInfo()

	if openInfo == nil or openInfo.actId == nil then
		return
	end

	HalloweenBossChallengeAgent.instance:sendPM_HalloweenBossChallengeGainDailyPrizeReq(openInfo.actId)
end

function HalloweenGuestController:scSendHalloweenBossChallengeGainDailyPrize(msg)
	HalloweenGuestModel.instance:scSendHalloweenBossChallengeGainDailyPrize(msg)
end

function HalloweenGuestController:csGetHalloweenBossChallengeGainDamagePrizeReq(damgId)
	local openInfo = HalloweenGuestModel.instance:getBossOpenInfo()

	if openInfo == nil or openInfo.actId == nil then
		return
	end

	HalloweenBossChallengeAgent.instance:sendPM_HalloweenBossChallengeGainDamagePrizeReq(openInfo.actId, damgId)
end

function HalloweenGuestController:scSendHalloweenBossChallengeGainDamagePrize(msg)
	HalloweenGuestModel.instance:scSendHalloweenBossChallengeGainDamagePrize(msg)
end

function HalloweenGuestController:csGetHalloweenBossChallengeRankReq()
	local openInfo = HalloweenGuestModel.instance:getBossOpenInfo()

	if openInfo == nil or openInfo.actId == nil then
		return
	end

	HalloweenBossChallengeAgent.instance:sendPM_HalloweenBossChallengeRankReq(openInfo.actId)
end

function HalloweenGuestController:scSendHalloweenBossChallengeRank(msg)
	HalloweenGuestModel.instance:scSendHalloweenBossChallengeRank(msg)
end

HalloweenGuestController.instance = HalloweenGuestController.New()

return HalloweenGuestController
