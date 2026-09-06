-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/model/ShenJiChallengeModel.lua

module("logic.extensions.shenjichallenge.model.ShenJiChallengeModel", package.seeall)

local ShenJiChallengeModel = class("ShenJiChallengeModel", BaseModel)

ShenJiChallengeModel.SelectStage = "selectstage"
ShenJiChallengeModel.BossStage = "bossstage"

function ShenJiChallengeModel:onInit()
	self:onReset()
end

function ShenJiChallengeModel:onReset()
	self._activityId = 312002

	local bossInfo = {}

	bossInfo.bossId = 0
	bossInfo.lockPetIds = {}
	bossInfo.bossCurHp = 0
	bossInfo.bossTotalHp = 0
	bossInfo.challengeTimes = 0
	bossInfo.todayPassBoss = false
	bossInfo.gainPrizeIds = {}
	self._bossInfo = bossInfo

	local selectStageInfo = {}

	selectStageInfo.optionalStageIds = {}
	selectStageInfo.buffValue = 0
	selectStageInfo.todayChallengeTimes = 0
	self._selectStageInfo = selectStageInfo
	self._selectStageId = 0
	self._selectIsWin = false
	self._changeBuffValue = 0
	self._bossId = 0
	self._isEmulate = false
	self._bossIsWin = false
	self._outputDamage = 0
	self._petIds = {}
	self._selectCustomFmtMo = nil
	self._bossCustomFmtMo = nil
end

function ShenJiChallengeModel:getSelectCustomFmtMo()
	if self._selectCustomFmtMo == nil then
		self._selectCustomFmtMo = ShenJiSelectCustomFmtMo.New()
	end

	return self._selectCustomFmtMo
end

function ShenJiChallengeModel:getBossCustomFmtMo()
	if self._bossCustomFmtMo == nil then
		self._bossCustomFmtMo = ShenJiBossCustomFmtMo.New()
	end

	return self._bossCustomFmtMo
end

function ShenJiChallengeModel:onGetInfoRes(msg)
	self._bossInfo = GameUtil.pbToTable(msg.bossInfo)
	self._bossInfo.lockPetIds = self._bossInfo.lockPetIds or {}
	self._bossInfo.gainPrizeIds = self._bossInfo.gainPrizeIds or {}
	self._selectStageInfo = GameUtil.pbToTable(msg.selectStageInfo)
	self._selectStageInfo.optionalStageIds = self._selectStageInfo.optionalStageIds or {}
end

function ShenJiChallengeModel:onSelectClgRes(msg)
	return
end

function ShenJiChallengeModel:onBossClgRes(msg)
	return
end

function ShenJiChallengeModel:onResetBossStageRes(msg)
	self._bossInfo = GameUtil.pbToTable(msg.bossInfo)
	self._bossInfo.lockPetIds = self._bossInfo.lockPetIds or {}
	self._bossInfo.gainPrizeIds = self._bossInfo.gainPrizeIds or {}
end

function ShenJiChallengeModel:onGainPrizeRes(msg)
	self._bossInfo.gainPrizeIds = self._bossInfo.gainPrizeIds or {}

	if not TableUtil.isHad(self._bossInfo.gainPrizeIds, msg.bossId) then
		table.insert(self._bossInfo.gainPrizeIds, msg.bossId)
	end
end

function ShenJiChallengeModel:onKingJiChallengeNotifySelectClgRes(msg)
	self._selectIsWin = msg.isWin
	self._selectStageId = msg.stageId
	self._selectStageInfo = GameUtil.pbToTable(msg.stageInfo)
	self._selectStageInfo.optionalStageIds = self._selectStageInfo.optionalStageIds or {}
	self._changeBuffValue = msg:HasField("changeBuffValue") and checknumber(msg.changeBuffValue) or 0
end

function ShenJiChallengeModel:onKingJiChallengeNotifyBossClgRes(msg)
	self._bossId = msg.bossId
	self._bossIsWin = msg.isWin
	self._outputDamage = checknumber(msg.outputDamage)
	self._petIds = msg.petIds
	self._isEmulate = msg:HasField("isEmulate") and msg.isEmulate or false

	if not self._isEmulate then
		self._bossInfo = GameUtil.pbToTable(msg.bossInfo)
		self._bossInfo.lockPetIds = self._bossInfo.lockPetIds or {}
		self._bossInfo.gainPrizeIds = self._bossInfo.gainPrizeIds or {}
	end
end

function ShenJiChallengeModel:getCurActivityId()
	return self._activityId
end

function ShenJiChallengeModel:setCurActivityId(activityId)
	self._activityId = activityId
end

function ShenJiChallengeModel:getActivityId()
	return 312001
end

function ShenJiChallengeModel:getActivityType()
	return GameEnum.ActivityType.ShenJiChallenge
end

function ShenJiChallengeModel:getTodayChallengeTimes()
	return (self._selectStageInfo or nil) and (self._selectStageInfo.todayChallengeTimes or 0)
end

function ShenJiChallengeModel:getBossChallengeTimes()
	if self:getTodayPassBoss() then
		return 0
	else
		return (self._bossInfo or nil) and (self._bossInfo.challengeTimes or 0)
	end
end

function ShenJiChallengeModel:getBuffValue()
	return (self._selectStageInfo or nil) and (self._selectStageInfo.buffValue or 0)
end

function ShenJiChallengeModel:getOptionalStageIds()
	return self._selectStageInfo and self._selectStageInfo.optionalStageIds
end

function ShenJiChallengeModel:getBossId()
	return self._bossInfo.bossId
end

function ShenJiChallengeModel:getBossCurHp()
	return checknumber(self._bossInfo.bossCurHp)
end

function ShenJiChallengeModel:getBossTotalHp()
	return checknumber(self._bossInfo.bossTotalHp)
end

function ShenJiChallengeModel:getBossChallengeTimes()
	return self._bossInfo.challengeTimes
end

function ShenJiChallengeModel:getTodayPassBoss()
	return self._bossInfo.todayPassBoss
end

function ShenJiChallengeModel:isPassBoss(activityId, bossId)
	local isLastBoss = ShenJiChallengeModel.instance:isLastBoss(activityId, bossId)

	if isLastBoss then
		return checknumber(self._bossInfo.bossCurHp) <= 0.001
	else
		local todayBossId = self._bossInfo.todayPassBoss and self._bossInfo.bossId - 1 or self._bossInfo.bossId

		if bossId < todayBossId then
			return true
		elseif todayBossId == bossId then
			return self._bossInfo.todayPassBoss
		else
			return false
		end
	end
end

function ShenJiChallengeModel:isLastBoss(activityId, bossId)
	local bossCfgList = ShenJiChallengeConfig.instance:getBossList(activityId)
	local count = #bossCfgList

	return bossCfgList[count] and bossCfgList[count].bossId == bossId
end

function ShenJiChallengeModel:getPassBossNum(activityId)
	local isPass = self:isPassBoss(activityId, self._bossInfo.bossId)

	if isPass then
		if not self._bossInfo.bossId then
			local passNum = self._bossInfo.bossId - 1

			passNum = Mathf.Max(passNum, 0)

			return passNum
		end
	end
end

function ShenJiChallengeModel:isPassAllBossStage(activityId)
	local cfgs = ShenJiChallengeConfig.instance:getBossList(activityId)
	local maxNum = #cfgs
	local curNum = self:getPassBossNum(activityId)

	return maxNum <= curNum
end

function ShenJiChallengeModel:isGetedPrizeId(bossId)
	return TableUtil.isHad(self._bossInfo.gainPrizeIds, bossId)
end

function ShenJiChallengeModel:isPetLock(petId)
	return TableUtil.isHad(self._bossInfo.lockPetIds, petId)
end

function ShenJiChallengeModel:getChangeBuffValue()
	return self._changeBuffValue
end

function ShenJiChallengeModel:getOutputDamage()
	return self._outputDamage
end

function ShenJiChallengeModel:getBossIsWin()
	return self._bossIsWin
end

ShenJiChallengeModel.instance = ShenJiChallengeModel.New()

return ShenJiChallengeModel
