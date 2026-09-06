-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/mgr/EliminatorMgr.lua

module("logic.extensions.peaktournament.view.mgr.EliminatorMgr", package.seeall)

local EliminatorMgr = class("EliminatorMgr")

EliminatorMgr.PeriodId = {
	Settlement = 3,
	WaitOpen = 1,
	Ended = 5,
	Preparation = 2,
	Performance = 4
}
EliminatorMgr.PeriodName = {
	lang("开启"),
	lang("准备阶段结束"),
	lang("锁定阶段结束"),
	lang("战斗阶段结束"),
	(lang("结束"))
}

function EliminatorMgr:ctor()
	return
end

function EliminatorMgr:onEnter(activityId)
	self._activityId = checknumber(activityId)

	if self._activityId == 0 then
		printError("缺少活动id( d巅峰赛.xlsx )")
		self:onExit()

		return
	end

	self._roundCfg = PeakTournamentConfig.instance:getPtEliRoundCfgById(self._activityId)

	if self._roundCfg == nil then
		printError(string.format("缺少淘汰赛轮次配置( d巅峰赛.xlsx | export_淘汰赛轮次配置 | activityId = %s )", self._activityId))
		self:onExit()

		return
	end

	self._curTimeStamp = ServerTime.now()
	self._newestEliRoundId = self._roundCfg[#self._roundCfg].eliRoundId
	self._lastPeriodId = EliminatorMgr.PeriodId.Ended
	self._isNeedUpdateNotify = false
	self._roundInfoList = {}
	self._totalRoundCount = #self._roundCfg

	local delay = 2

	for eliRoundId = 1, self._totalRoundCount do
		local info = {}
		local periodData = self._roundCfg[eliRoundId]
		local nextPeriodData = self._roundCfg[Mathf.Min(eliRoundId + 1, #self._roundCfg)]

		info.data = periodData
		info.periodOpenTimeStampList = {}
		info.periodOpenTimeStampList[EliminatorMgr.PeriodId.WaitOpen] = 0
		info.periodOpenTimeStampList[EliminatorMgr.PeriodId.Preparation] = GameUtil.string2time(periodData.preparationPeriodOpenTime) + delay
		info.periodOpenTimeStampList[EliminatorMgr.PeriodId.Settlement] = GameUtil.string2time(periodData.settlementPeriodOpenTime) + delay
		info.periodOpenTimeStampList[EliminatorMgr.PeriodId.Performance] = GameUtil.string2time(periodData.performancePeriodOpenTime) + delay
		info.periodOpenTimeStampList[EliminatorMgr.PeriodId.Ended] = GameUtil.string2time(nextPeriodData.preparationPeriodOpenTime) + delay

		if eliRoundId == #self._roundCfg then
			local timeStamp = info.periodOpenTimeStampList[EliminatorMgr.PeriodId.Performance]

			info.periodOpenTimeStampList[EliminatorMgr.PeriodId.Ended] = timeStamp + 60
		end

		self._roundInfoList[eliRoundId] = info
	end

	self._roundRecordList = {}

	for eliRoundId, roundInfo in ipairs(self._roundInfoList) do
		self._roundRecordList[eliRoundId] = {}
		self._roundRecordList[eliRoundId].curPeriodId = EliminatorMgr.PeriodId.WaitOpen
	end

	self:_onTicking()

	self._isNeedUpdateNotify = true

	settimer(0.1, self._onTicking, self)
end

function EliminatorMgr:onExit()
	removetimer(self._onTicking, self)
end

function EliminatorMgr:onDestroy()
	self._activityId = 0
	self._curTimeStamp = 0
	self._roundInfoList = nil
	self._roundRecordList = nil
end

function EliminatorMgr:_onTicking()
	self._curTimeStamp = ServerTime.now()

	for eliRoundId, roundInfo in ipairs(self._roundInfoList) do
		if self._roundRecordList[eliRoundId].curPeriodId ~= self._lastPeriodId then
			for nextPeriodId = Mathf.Min(self._roundRecordList[eliRoundId].curPeriodId + 1, self._lastPeriodId), self._lastPeriodId do
				if self._curTimeStamp >= self:getPeriodOpenTimeStamp(eliRoundId, nextPeriodId) then
					self._roundRecordList[eliRoundId].curPeriodId = nextPeriodId
					self._isNeedNotifyChangeNewPeriod = true
				else
					break
				end
			end
		end
	end

	for eliRoundId, roundRecord in ipairs(self._roundRecordList) do
		if roundRecord.curPeriodId ~= self._lastPeriodId then
			if self._newestEliRoundId ~= eliRoundId then
				self._newestEliRoundId = eliRoundId
				self._isNeedNotifyChangeNewEliRound = true
			end

			break
		end
	end

	if self._isNeedNotifyChangeNewPeriod == true then
		self._isNeedNotifyChangeNewPeriod = false

		if self._isNeedUpdateNotify then
			GlobalDispatcher:dispatch(GlobalNotify.EliminatorMgrNotifyChangeNewPeriod)
		end
	end

	if self._isNeedNotifyChangeNewEliRound == true then
		self._isNeedNotifyChangeNewEliRound = false

		if self._isNeedUpdateNotify then
			GlobalDispatcher:dispatch(GlobalNotify.EliminatorMgrNotifyChangeNewEliRound)
		end
	end
end

function EliminatorMgr:getCurPeriodId(eliRoundId)
	return self._roundRecordList[eliRoundId].curPeriodId
end

function EliminatorMgr:getNewestEliRoundId()
	return self._newestEliRoundId
end

function EliminatorMgr:getCurTimeStamp()
	return self._curTimeStamp
end

function EliminatorMgr:getCurPeriodOpenTimeStamp(eliRoundId)
	return self:getPeriodOpenTimeStamp(eliRoundId, self:getCurPeriodId(eliRoundId))
end

function EliminatorMgr:getPeriodOpenTimeStamp(eliRoundId, periodId)
	return self._roundInfoList[eliRoundId].periodOpenTimeStampList[periodId]
end

function EliminatorMgr:getCurPeriodEndTimeStamp(eliRoundId)
	return self:getPeriodEndTimeStamp(eliRoundId, self:getCurPeriodId(eliRoundId))
end

function EliminatorMgr:getPeriodEndTimeStamp(eliRoundId, periodId)
	return self._roundInfoList[eliRoundId].periodOpenTimeStampList[Mathf.Min(periodId + 1, self._lastPeriodId)]
end

function EliminatorMgr:getRemainTimeStampToNextPeriod(eliRoundId)
	return Mathf.Max(self:getCurPeriodEndTimeStamp(eliRoundId) - self._curTimeStamp, 0)
end

function EliminatorMgr:getRemainTimeTipsStr(eliRoundId)
	self._processDesc = self._roundCfg[eliRoundId].processDesc
	self._remainTimeTipsStr = ""

	local periodId = self:getCurPeriodId(eliRoundId)

	if periodId == self._lastPeriodId then
		self._remainTimeTipsStr = string.format("%s已结束", self._processDesc)
	else
		self._remainTimeStamp = self:getRemainTimeStampToNextPeriod(eliRoundId)
		self._timeStr = GameUtil.FormatTimeSymbol(self._remainTimeStamp)
		self._remainTimeTipsStr = string.format("距离%s%s：%s", self._processDesc, EliminatorMgr.PeriodName[periodId], self._timeStr)
	end

	return self._remainTimeTipsStr
end

return EliminatorMgr
