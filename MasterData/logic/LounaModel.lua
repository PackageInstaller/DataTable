-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/model/LounaModel.lua

module("logic.extensions.timelimitedchallenge.model.LounaModel", package.seeall)

local LounaModel = class("LounaModel", BaseModel)

function LounaModel:ctor()
	LounaModel.super.ctor(self)
end

function LounaModel:onInit()
	self:onReset()
end

function LounaModel:onReset()
	self.curTier = 0
	self.passedCreepsMasterIds = {}
	self.petHpInfos = {}
	self.petTimesInfos = {}
	self.curTierHistoryMaxScore = 0
	self.totalScore = 0
	self.gainedPrizeIds = {}
	self.petHpMap = {}
	self.petTimesMap = {}
end

function LounaModel:onGetInfo(msg)
	self.curTier = msg.curTier
	self.passedCreepsMasterIds = msg.passedCreepsMasterIds
	self.petHpInfos = GameUtil.pbToTable(msg.petHpInfos) or {}
	self.petTimesInfos = GameUtil.pbToTable(msg.petTimesInfos) or {}
	self.curTierHistoryMaxScore = msg.curTierHistoryMaxScore
	self.totalScore = msg.totalScore
	self.gainedPrizeIds = msg.gainedPrizeIds

	self:dealwithMsg()
end

function LounaModel:dealwithMsg()
	self.petHpMap = {}
	self.petTimesMap = {}

	for i, v in ipairs(self.petHpInfos) do
		self.petHpMap[v.raceId] = v.curHp
	end

	for i, v in ipairs(self.petTimesInfos) do
		self.petTimesMap[v.raceId] = v.times
	end
end

function LounaModel:getPetHp(petMo)
	if petMo and self.petHpMap[petMo.raceId] ~= nil then
		return checknumber(self.petHpMap[petMo.raceId])
	end

	return 10000
end

function LounaModel:getPetTimes(petMo)
	if petMo then
		return checknumber(self.petTimesMap[petMo.raceId])
	end

	return 0
end

function LounaModel:onGetPrize(msg)
	table.insert(self.gainedPrizeIds, checknumber(msg.prizeId))
end

function LounaModel:getCurSoure(activityId)
	return checknumber(self.totalScore)
end

function LounaModel:isPlayerRewardCanGet(activityId, idx, score)
	if score <= self:getCurSoure(activityId) then
		return table.indexof(self.gainedPrizeIds, idx) == false
	end

	return false
end

function LounaModel:isPlayerRewardGeted(activityId, idx)
	return table.indexof(self.gainedPrizeIds, idx) ~= false
end

function LounaModel:onResetChallenge(msg)
	self.petHpInfos = {}
	self.petTimesInfos = {}
	self.passedCreepsMasterIds = {}

	self:dealwithMsg()
end

function LounaModel:onGetFighMsg(msg)
	self.petHpInfos = GameUtil.pbToTable(msg.petHpInfos) or {}
	self.petTimesInfos = GameUtil.pbToTable(msg.petTimesInfos) or {}

	self:dealwithMsg()
end

LounaModel.instance = LounaModel.New()

return LounaModel
