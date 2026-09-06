-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/model/MoyanModel.lua

module("logic.extensions.timelimitedchallenge.model.MoyanModel", package.seeall)

local MoyanModel = class("MoyanModel", BaseModel)

MoyanModel.TYPE_1 = 1
MoyanModel.TYPE_2 = 2
MoyanModel.TYPE_3 = 3

function MoyanModel:ctor()
	MoyanModel.super.ctor(self)
end

function MoyanModel:onInit()
	self:onReset()
end

function MoyanModel:onReset()
	self.modelMap = {}
	self.battleInfoMap = {}
	self.singleInfoMap = {}
end

function MoyanModel:getMoByChallengeId(challengeId)
	return self.modelMap[challengeId] or {}
end

function MoyanModel:getBattleInfo(challengeId)
	return self.battleInfoMap[challengeId] or {}
end

function MoyanModel:getSingleInfo(challengeId, type)
	self.singleInfoMap[challengeId] = self.singleInfoMap[challengeId] or {}

	return self.singleInfoMap[challengeId][type] or {}
end

function MoyanModel:setSingleInfo(challengeId, type, mo)
	self.singleInfoMap[challengeId] = self.singleInfoMap[challengeId] or {}
	self.singleInfoMap[challengeId][type] = mo
end

function MoyanModel:sendGetInfo(challengeId)
	MoYanChallengeAgent.instance:sendPM_MYCGetProgressInfoReq(challengeId)
end

function MoyanModel:onGetInfo(msg)
	local mo = {}

	mo.rankSize = msg.rankSize
	mo.score = msg.score
	mo.gainedPrizeIds = msg.gainedPrizeIds
	mo.challengeId = msg.challengeId
	self.modelMap[msg.challengeId] = mo

	GlobalDispatcher:dispatch(GlobalNotify.PM_MOYAN_GETINFORES, msg.challengeId)
end

function MoyanModel:sendGetProgressPrize(challengeId, prizeId)
	MoYanChallengeAgent.instance:sendPM_MYCGainProgressPrizeReq(challengeId, prizeId)
end

function MoyanModel:onGetProgressPrize(msg)
	local mo = self:getMoByChallengeId(msg.challengeId)

	mo.gainedPrizeIds = mo.gainedPrizeIds or {}

	table.insert(mo.gainedPrizeIds, msg.prizeId)

	self.modelMap[msg.challengeId] = mo

	GlobalDispatcher:dispatch(GlobalNotify.PM_MOYAN_GETINFORES, msg.challengeId)
end

function MoyanModel:getGetBattleEnterInfo(challengeId)
	MoYanChallengeAgent.instance:sendPM_MYCGetChallengeInfoReq(challengeId)
end

function MoyanModel:onGetBattleEnterInfo(msg)
	local mo = self:getBattleInfo(msg.challengeId)

	mo.baseInfos = GameUtil.pbToTable(msg.baseInfos)
	self.battleInfoMap[msg.challengeId] = mo

	GlobalDispatcher:dispatch(GlobalNotify.PM_MOYAN_GETINFORES, msg.challengeId)
end

function MoyanModel:getSingleChanllengeInfo(challengeId, type)
	MoYanChallengeAgent.instance:sendPM_MYCGetSingleChallengeInfoReq(challengeId, type)
end

function MoyanModel:onSingleChanllengeInfo(msg)
	local mo = self:getSingleInfo(msg.challengeId, msg.challengeType)

	mo.challengeId = msg.challengeId
	mo.challengeType = msg.challengeType
	mo.worldZdl = msg.worldZdl
	mo.linearSysPetTypeInfo = GameUtil.pbToTable(msg.linearSysPetTypeInfo)
	mo.randomSelfPetTypeInfo = GameUtil.pbToTable(msg.randomSelfPetTypeInfo)
	mo.bossDamageTypeInfo = GameUtil.pbToTable(msg.bossDamageTypeInfo)

	self:setSingleInfo(msg.challengeId, msg.challengeType, mo)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MOYAN_GETINFORES, msg.challengeId)
end

function MoyanModel:sendFight(challengeId, type, stage, fmo)
	local simpleForm

	MoYanChallengeAgent.instance:sendPM_MYCChallengeStageReq(challengeId, type, stage, (fmo or nil) and fmo:createFormPb())
end

function MoyanModel:sendResetChallenge(challengeId, type)
	MoYanChallengeAgent.instance:sendPM_MYCResetChallengeReq(challengeId, type)
end

function MoyanModel:onResetChallenge(msg)
	TipsFacade.instance:openCommonTips(lang("重置成功！"))

	local mo = self:getSingleInfo(msg.challengeId, msg.challengeType)

	mo.challengeId = msg.challengeId
	mo.challengeType = msg.challengeType
	mo.randomSelfPetTypeInfo = {}

	self:setSingleInfo(msg.challengeId, msg.challengeType, mo)
	GlobalDispatcher:dispatch(GlobalNotify.PM_MOYAN_GETINFORES, msg.challengeId)
end

function MoyanModel:sendSweep(challengeId, type)
	MoYanChallengeAgent.instance:sendPM_MYCSweepReq(challengeId, type)
end

function MoyanModel:onGetSweepStage(msg)
	local mo = self:getMoByChallengeId(msg.challengeId) or {}

	mo.score = checknumber(mo.score) + msg.gainedScore
	self.modelMap[msg.challengeId] = mo

	local info = self:getBattleInfo(msg.challengeId)

	for i, v in ipairs(info.baseInfos or {}) do
		if v.challengeType == msg.challengeType then
			v.tdGainedScore = checknumber(v.tdGainedScore) + msg.gainedScore
		end
	end

	TipsFacade.instance:openCommonTips(lang("扫荡成功！"))
	GlobalDispatcher:dispatch(GlobalNotify.PM_MOYAN_GETINFORES, msg.challengeId)
end

function MoyanModel:sendBuyTimes(challengeId, type)
	MoYanChallengeAgent.instance:sendPM_MYCBuyChallengeTimesReq(challengeId, type)
end

function MoyanModel:onRecBuyTimes(msg)
	local mo = self:getSingleInfo(msg.challengeId, msg.challengeType)

	mo.challengeId = msg.challengeId
	mo.challengeType = msg.challengeType
	mo.bossDamageTypeInfo = mo.bossDamageTypeInfo or {}
	mo.bossDamageTypeInfo.tdChallengeBuyTimes = checknumber(mo.bossDamageTypeInfo.tdChallengeBuyTimes) + 1

	GlobalDispatcher:dispatch(GlobalNotify.PM_MOYAN_GETINFORES, msg.challengeId)
end

function MoyanModel:onChallengeEndRes(msg)
	self.isWin = msg.isWin
	self.gainedScore = msg.gainedScore
	self.bossDamageInfo = GameUtil.pbToTable(msg.bossDamageInfo)

	GlobalDispatcher:dispatch(GlobalNotify.PM_MOYAN_GETINFORES)
end

MoyanModel.instance = MoyanModel.New()

return MoyanModel
