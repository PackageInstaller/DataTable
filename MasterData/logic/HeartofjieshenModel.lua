-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofjieshen/model/HeartofjieshenModel.lua

module("logic.extensions.heartofjieshen.view.HeartofjieshenModel", package.seeall)

local HeartofjieshenModel = class("HeartofjieshenModel", BaseModel)

HeartofjieshenModel.TAB_HISTORY = 2
HeartofjieshenModel.TAB_TODAY = 1

function HeartofjieshenModel:ctor()
	return
end

function HeartofjieshenModel:onInit()
	self:onReset()
end

function HeartofjieshenModel:onReset()
	self._msgInfos = {}
	self._dailyRankMsg = nil
	self._raceMustOnChiForm = nil
	self._raceBanOnChiForm = nil
	self._clgFinishDic = {}
	self._fightYiResMsg = nil
	self._historyRankMsg = nil
	self._fmtMo = nil
	self._historyRankMsgPool = {}
	self._dailyRankMsgPool = {}
end

function HeartofjieshenModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
end

function HeartofjieshenModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function HeartofjieshenModel:isClgFinish(fmtType)
	return self._clgFinishDic[fmtType]
end

function HeartofjieshenModel:setClgFinish(fmtType)
	self._clgFinishDic[fmtType] = true
end

function HeartofjieshenModel:resetClgFinishDic()
	self._clgFinishDic = {}
end

function HeartofjieshenModel:getFmtMo()
	self._fmtMo = self._fmtMo or HeartOfjieshenFmtMo.New()

	return self._fmtMo
end

function HeartofjieshenModel:getHistoryMaxDamage(activityId)
	return checknumber(self:getInfo(activityId).historyMaxDamage)
end

function HeartofjieshenModel:hasGainDailyBalancePrize(activityId)
	return self:getInfo(activityId).hasGainDailyBalancePrize
end

function HeartofjieshenModel:setDailyRankMsg(msg)
	self._dailyRankMsg = msg
	self._dailyRankMsgPool[msg.activityId] = msg
end

function HeartofjieshenModel:getDailyRankMsg(activityId)
	return self._dailyRankMsgPool[activityId]
end

function HeartofjieshenModel:setHistoryRankMsg(msg)
	self._historyRankMsg = msg
	self._historyRankMsgPool[msg.activityId] = msg
end

function HeartofjieshenModel:getHistoryRankMsg(activityId)
	return self._historyRankMsgPool[activityId]
end

function HeartofjieshenModel:onFightYiRes(msg)
	self._fightYiResMsg = msg
	self._raceMustOnChiForm = GameUtil.pbToTable(msg.raceMustOnChiForm)
	self._raceBanOnChiForm = GameUtil.pbToTable(msg.raceBanOnChiForm) or {}
end

function HeartofjieshenModel:getFightYiResMsg()
	return self._fightYiResMsg
end

function HeartofjieshenModel:getMustOnChiRaceIds()
	return self._raceMustOnChiForm or {}
end

function HeartofjieshenModel:getBanOnChiRaceIds()
	return self._raceBanOnChiForm or {}
end

function HeartofjieshenModel:updateMaxDamage(activityId, damage)
	damage = checknumber(damage)

	if damage > self:getHistoryMaxDamage(activityId) then
		self:getInfo(activityId).historyMaxDamage = damage
	end
end

HeartofjieshenModel.instance = HeartofjieshenModel.New()

return HeartofjieshenModel
