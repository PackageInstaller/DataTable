-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/model/LongnvModel.lua

module("logic.extensions.timelimitedchallenge.model.LongnvModel", package.seeall)

local LongnvModel = class("LongnvModel", BaseModel)

LongnvModel.TYPE_1 = 1
LongnvModel.TYPE_2 = 2
LongnvModel.TYPE_3 = 3

function LongnvModel:ctor()
	LongnvModel.super.ctor(self)
end

function LongnvModel:onInit()
	self:onReset()
end

function LongnvModel:onReset()
	self.rankSize = 0
	self.spaceGained = 0
	self.isPassPreChallenge = false
	self.isPassChallenge = false
	self.isCanSweep = false
	self.todayChallengeTimes = 0
	self.todayChallengeBuyTimes = 0
	self.isCanChallengeBoss = false
	self.alivePetMap = {}
	self.challengePlan = 1
	self.type = 1
	self.typeAlivePetCount = {}
	self.lastDamage = 0
	self.bossHP = 0
	self.passCount = 0
end

function LongnvModel:getPlanId()
	return self.challengePlan
end

function LongnvModel:setCurrMonsterCfg(cfg)
	self.currMonsterCfg = cfg
end

function LongnvModel:getCurrMonsterCfg()
	return self.currMonsterCfg
end

function LongnvModel:getTotalAliveByType(type)
	if not self.typeAlivePetCount[type] then
		local total = 0

		for i, v in ipairs(self.typeAlivePetCount[type]) do
			total = total + v
		end

		return total
	end
end

function LongnvModel:getNumAliveByType(type, idx)
	if not self.typeAlivePetCount[type] then
		return checknumber(self.typeAlivePetCount[type][idx])
	end
end

function LongnvModel:getHasNumAliveByType(type, idx)
	if not self.typeAlivePetCount[type] then
		local arr = {}

		return arr[idx] ~= nil
	end
end

function LongnvModel:getAlivePetCount(type)
	local info = self.alivePetMap[type]

	if info then
		return checknumber(info.alivePetCount)
	end

	return 0
end

function LongnvModel:sendGetInfo()
	LongNvChallengeAgent.instance:sendPM_LNCGetMainBoardInfoReq()
end

function LongnvModel:onGetInfo(msg)
	self.rankSize = msg.rankSize
	self.spaceGained = msg.spaceGained
	self.isPassPreChallenge = msg.isPassPreChallenge
	self.isPassChallenge = msg.isPassChallenge
	self.isCanSweep = msg.isCanSweep

	GlobalDispatcher:dispatch(GlobalNotify.PM_LongnvInfoRes)
end

function LongnvModel:sendGetFightInfo()
	LongNvChallengeAgent.instance:sendPM_LNCGetChallengeBoardInfoReq()
end

function LongnvModel:onGetFightInfo(msg)
	self.todayChallengeTimes = msg.todayChallengeTimes
	self.todayChallengeBuyTimes = msg.todayChallengeBuyTimes
	self.isCanChallengeBoss = msg.isCanChallengeBoss

	for i, v in ipairs(msg.alivePetCounts) do
		local obj = {}

		obj.type = v.type
		obj.alivePetCount = v.alivePetCount
		self.alivePetMap[v.type] = obj
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_LongnvInfoRes)
end

function LongnvModel:sendBuyTimes()
	LongNvChallengeAgent.instance:sendPM_LNCBuyChallengeTimesReq()
end

function LongnvModel:onBuyTimes(msg)
	self.todayChallengeBuyTimes = checknumber(self.todayChallengeBuyTimes) + 1

	GlobalDispatcher:dispatch(GlobalNotify.PM_LongnvInfoRes)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LongnvBuyTimesEnd)
end

function LongnvModel:sendGetChallengeInfoByType(type)
	LongNvChallengeAgent.instance:sendPM_LNCGetChallengeInfoReq(type)
end

function LongnvModel:onGetChallengeInfoByType(msg)
	self.challengePlan = msg.challengePlan
	self.type = msg.type
	self.typeAlivePetCount[msg.type] = GameUtil.pbToTable(msg.alivePetCounts)
	self.lastDamage = checknumber(msg.lastDamage)

	local planId = LongnvModel.instance:getPlanId()
	local cfg = LongnvConfig.instance:getPlanCfg(planId) or {}

	self.bossHP = math.max(0, checknumber(cfg.bossHP) - math.max(0, self.lastDamage))

	GlobalDispatcher:dispatch(GlobalNotify.PM_LongnvInfoRes)
end

function LongnvModel:sendSweep()
	LongNvChallengeAgent.instance:sendPM_LNCSweepReq()
end

function LongnvModel:onSweep(msg)
	self.isCanSweep = false

	GlobalDispatcher:dispatch(GlobalNotify.PM_LongnvInfoRes)
end

function LongnvModel:sendFight(type, stage)
	LongNvChallengeAgent.instance:sendPM_LNCChallengeStageReq(type, stage)
end

function LongnvModel:onFight(msg)
	return
end

function LongnvModel:onChallengeError(status, msg)
	UIJumper.instance:clear()
	BattleFacade.instance:registerResultHandler(nil, nil)

	local str = MsgFlowMgr.instance:getResultCodeStr(status)

	if string.nilorempty(str) then
		str = lang("龙女挑战-战斗暂时不能进入")
	end

	TipsFacade.instance:openTipWindowNoX(lang("tip"), str, function()
		UIStateManager.instance:clear()
		FuncOpenController.instance:openFuncByViewName(ViewName.LongnvmainView)
	end)
end

function LongnvModel:onChallengeEndRes(msg)
	self.challengePlan = msg.challengePlan
	self.type = msg.type
	self.stage = msg.stage
	self.todayChallengeTimes = msg.todayChallengeTimes
	self.isCanChallengeBoss = msg.isCanChallengeBoss
	self.typeAlivePetCount[msg.type] = self.typeAlivePetCount[msg.type] or {}
	self.typeAlivePetCount[msg.type][msg.stage] = checknumber(msg.alivePetCount)
	self.isWin = msg.isWin
	self.gainedChallengePrizeCount = msg.gainedChallengePrizeCount
	self.damage = msg.damage
	self.bossHP = msg.bossHP
	self.passCount = msg.passCount
	self.changeSetId = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(self.changeSetId)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LongnvInfoRes)
end

LongnvModel.instance = LongnvModel.New()

return LongnvModel
