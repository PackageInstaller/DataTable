-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godaruishichallenge/model/GodARuiShiChallengeModel.lua

module("logic.extensions.godaruishichallenge.model.GodARuiShiChallengeModel", package.seeall)

local GodARuiShiChallengeModel = class("GodARuiShiChallengeModel", BaseModel)

GodARuiShiChallengeModel.StageState = {
	ChallengeSuccess = 2,
	Unchallenge = 0,
	ChallengeFail = 1
}
GodARuiShiChallengeModel.ReadFlag = "GodARuiShiChallengeModel.ReadFlag"
GodARuiShiChallengeModel.BattleFlag = "GodARuiShiChallengeModel.BattleFlag"

function GodARuiShiChallengeModel:ctor()
	return
end

function GodARuiShiChallengeModel:onInit()
	self:onReset()
end

function GodARuiShiChallengeModel:onReset()
	self.curScore = nil
	self.waveInfo = nil
	self.curWave = nil
	self.stage = nil
	self.hasBoss = nil
	self.bossId = nil
	self.bossTime = nil
	self.bossBattleEnd = false
	self.challengeId = nil
	self.tempPass = nil
	self.tempScore = nil
	self.tempFmt = {
		[0] = {},
		{}
	}
	self.tempStage = nil
	self.tempIsboss = nil
	self.tempChallengeId = nil
	self.tempShowRuleEffect = nil
	self._oneKeyChangeSetId = nil
end

function GodARuiShiChallengeModel:setWaveInfo(msg)
	self.waveInfo = GameUtil.pbToTable(msg)
	self.stage = msg.stage
	self.curWave = msg.curWaveId

	if msg.hasBoss == true then
		self.hasBoss = true
		self.bossId = msg.bossId
	else
		self.hasBoss = false
		self.bossId = nil
	end

	self.bossTime = msg.bossTimes
end

function GodARuiShiChallengeModel:setChallengeInfo(msg)
	local tempMsg = GameUtil.pbToTable(msg)

	self.curScore = tempMsg.score
	self.curWave = tempMsg.curWaveId

	if tempMsg.waveInfo then
		self:setWaveInfo(tempMsg.waveInfo)
	else
		self.waveInfo = nil
		self.stage = nil
		self.hasBoss = nil
		self.bossId = nil
		self.bossTime = nil
	end

	self.tempPass = self:isPass()
end

function GodARuiShiChallengeModel:setTeampData()
	local msg = {}

	msg.waveInfo = {
		bossId = 2,
		hasBoss = true,
		curWaveId = 0,
		bossTimes = 0,
		stage = {}
	}

	for i = 1, 3 do
		table.insert(msg.waveInfo.stage, {
			isFinish = false,
			stageId = i * 4
		})
	end

	msg.curWaveId = 0
	msg.score = 500

	self:setChallengeInfo(msg)
end

function GodARuiShiChallengeModel:getStage()
	if self.stage then
		return self.stage
	else
		return {}
	end
end

function GodARuiShiChallengeModel:haveBoss()
	return self.hasBoss
end

function GodARuiShiChallengeModel:getBossId()
	return self.bossId
end

function GodARuiShiChallengeModel:getBossTime()
	return self.bossTime
end

function GodARuiShiChallengeModel:getCurWave()
	return self.curWave
end

function GodARuiShiChallengeModel:getScore()
	return self.curScore
end

function GodARuiShiChallengeModel:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = GodARuiShiCustomFmtMo.New()
	end

	return self._customFmtMo
end

function GodARuiShiChallengeModel:getBossBattleEnd()
	return self.bossBattleEnd
end

function GodARuiShiChallengeModel:setBossBattleEnd(status)
	self.bossBattleEnd = status
end

function GodARuiShiChallengeModel:saveFmtStatus(fmt, stageId, isBoss, challengeId)
	if isBoss then
		self.tempFmt[0][stageId] = fmt
	else
		self.tempFmt[1][stageId] = fmt
	end

	self.tempStage = stageId
	self.tempIsboss = isBoss
	self.tempChallengeId = challengeId
end

function GodARuiShiChallengeModel:getTempFmt(stageId, isBoss)
	local fmt

	return isBoss and self.tempFmt[0][stageId] or self.tempFmt[1][stageId], self.tempStage, self.tempIsboss
end

function GodARuiShiChallengeModel:resetTempStageInfo()
	self.tempStage = nil
	self.tempIsboss = nil
	self.tempChallengeId = nil
end

function GodARuiShiChallengeModel:resetFmt()
	self.tempFmt = {
		[0] = {},
		{}
	}
end

function GodARuiShiChallengeModel:getChallengeId()
	return self.tempChallengeId
end

function GodARuiShiChallengeModel:isPass()
	local cfg = GodARuiShiChallengeConfig.instance:getGlyData(self.challengeId)

	return self.curScore ~= nil and self.curScore >= cfg.score
end

function GodARuiShiChallengeModel:getTempPass()
	return self.tempPass
end

function GodARuiShiChallengeModel:getTempScore()
	return self.tempScore
end

function GodARuiShiChallengeModel:saveTempScore()
	self.tempScore = self.curScore
end

function GodARuiShiChallengeModel:onGodARuiShiQuickPassRes(msg)
	self.tempPass = true
	self.curScore = 0

	if msg:HasField("changeSetId") then
		self._oneKeyChangeSetId = msg.changeSetId
	end
end

function GodARuiShiChallengeModel:getOneKeyChangeSetId()
	self._oneKeyChangeSetId = nil

	return self._oneKeyChangeSetId
end

function GodARuiShiChallengeModel:saveReadBossRule()
	GameUtil.saveUserDayData(GodARuiShiChallengeModel.ReadFlag .. "#ReadBossRule", true)
end

function GodARuiShiChallengeModel:getReadBossRule()
	return GameUtil.getUserDayData(GodARuiShiChallengeModel.ReadFlag .. "#ReadBossRule")
end

function GodARuiShiChallengeModel:setChallengeId(challengeId)
	if not self.challengeId or self.challengeId ~= challengeId then
		self:resetFmt()
	end

	self.challengeId = challengeId
end

function GodARuiShiChallengeModel:getChallengeId()
	return self.challengeId
end

function GodARuiShiChallengeModel:saveFirstEnter(challengeId)
	GameUtil.saveUserData(GodARuiShiChallengeModel.ReadFlag .. "#FirstEnter#" .. challengeId, true)
end

function GodARuiShiChallengeModel:getFirstEnter(challengeId)
	return GameUtil.getUserData(GodARuiShiChallengeModel.ReadFlag .. "#FirstEnter#" .. challengeId)
end

function GodARuiShiChallengeModel:setTempShowRuleEffect(status)
	self.tempShowRuleEffect = status
end

function GodARuiShiChallengeModel:getTempShowRuleEffect()
	return self.tempShowRuleEffect
end

GodARuiShiChallengeModel.instance = GodARuiShiChallengeModel.New()

return GodARuiShiChallengeModel
