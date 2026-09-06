-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/view/DivineXiuErClgMo.lua

module("logic.extensions.divinexiuerclg.view.DivineXiuErClgMo", package.seeall)

local DivineXiuErClgMo = class("DivineXiuErClgMo")

function DivineXiuErClgMo:ctor(activityId)
	self._activityId = activityId
	self._isHasGainPrizeOfNor = false
	self._isPassOfNor = false
	self._trueProgressOfNor = 0
	self._falseProgressOfNor = 0
	self._todayGroupIdOfNor = 0
	self._stageInfosOfNor = {}
	self._fightResultResOfNor = nil
	self._fightResultResOfExt = nil
	self._isHasGainPrizeOfExt = false
	self._curTierIdOfExt = 0
	self._dataBitIdListOfPassOfExt = {}
	self._stageInfosOfExt = {}
end

function DivineXiuErClgMo:getActivityId()
	return self._activityId
end

function DivineXiuErClgMo:deepcopy()
	return TableUtil.deepcopy(self)
end

function DivineXiuErClgMo:handlePM_DivineXiuErClgGetInfoRes(msg)
	self:setIsHasGainPrizeOfNor(msg.normalClgInfo.hasGainPrize)
	self:setIsPassOfNor(msg.normalClgInfo.hasPass)
	self:setTrueProgressOfNor(msg.normalClgInfo.trueProgress)
	self:setFalseProgressOfNor(msg.normalClgInfo.falseProgress)
	self:setTodayGroupIdOfNor(msg.normalClgInfo.todayGroupId)
	self:clearAllStageInfoOfNor()

	for i, v in ipairs(msg.normalClgInfo.stageInfo) do
		self:setStageInfoOfNor(v.dataBitId, v)
	end

	self:setIsHasGainPrizeOfExt(msg.extremeClgInfo.hasGainPrize)
	self:setCurTierIdOfExt(msg.extremeClgInfo.curTierId)
	self:clearDataBitIdListOfPassOfExt()
	self:addDataBitIdListOfPassOfExt(msg.extremeClgInfo.dataBitIdPassed)
	self:clearAllStageInfoOfExt()

	for i, v in ipairs(msg.extremeClgInfo.stageInfo) do
		self:setStageInfoOfExt(v.dataBitId, v)
	end
end

function DivineXiuErClgMo:handlePM_DivineXiuErClgNormalFightRes(msg)
	return
end

function DivineXiuErClgMo:handlePM_DivineXiuErClgNotifyNormalFightResultRes(msg)
	self._fightResultResOfNor = msg
end

function DivineXiuErClgMo:handlePM_DivineXiuErClgExtremeFightRes(msg)
	return
end

function DivineXiuErClgMo:handlePM_DivineXiuErClgNotifyExtremeFightResultRes(msg)
	self._fightResultResOfExt = msg
end

function DivineXiuErClgMo:handlePM_DivineXiuErExtremeFightConfirmRes(msg)
	if msg.stageInfo then
		self:setStageInfoOfExt(msg.stageInfo.dataBitId, msg.stageInfo.stageInfo)
	end

	self:setCurTierIdOfExt(msg.newTierId)
end

function DivineXiuErClgMo:handlePM_DivineXiuErResetExtremeClgStageRes(msg)
	self:setStageInfoOfExt(msg.dataBitId, nil)
end

function DivineXiuErClgMo:handlePM_DivineXiuErGainNormalClgPrizeRes(msg)
	self:setIsHasGainPrizeOfNor(true)
end

function DivineXiuErClgMo:handlePM_DivineXiuErGainExtremeClgPrizeRes(msg)
	self:setIsHasGainPrizeOfExt(true)
end

function DivineXiuErClgMo:isHasGainPrizeOfNor()
	return self._isHasGainPrizeOfNor
end

function DivineXiuErClgMo:setIsHasGainPrizeOfNor(value)
	self._isHasGainPrizeOfNor = checkbool(value)
end

function DivineXiuErClgMo:isPassOfNor()
	return self._isPassOfNor
end

function DivineXiuErClgMo:setIsPassOfNor(value)
	self._isPassOfNor = checkbool(value)
end

function DivineXiuErClgMo:getTrueProgressOfNor()
	return self._trueProgressOfNor
end

function DivineXiuErClgMo:setTrueProgressOfNor(value)
	self._trueProgressOfNor = checknumber(value)
end

function DivineXiuErClgMo:getFalseProgressOfNor()
	return self._falseProgressOfNor
end

function DivineXiuErClgMo:setFalseProgressOfNor(value)
	self._falseProgressOfNor = checknumber(value)
end

function DivineXiuErClgMo:getTodayGroupIdOfNor()
	return self._todayGroupIdOfNor
end

function DivineXiuErClgMo:setTodayGroupIdOfNor(value)
	self._todayGroupIdOfNor = checknumber(value)
end

function DivineXiuErClgMo:getStageScoreOfNor(dataBitId)
	local info = self:getStageInfoOfNor(dataBitId)

	return (info or nil) and (info.bestScore or 0)
end

function DivineXiuErClgMo:getStageInfoOfNor(dataBitId)
	return self._stageInfosOfNor[dataBitId]
end

function DivineXiuErClgMo:setStageInfoOfNor(dataBitId, value)
	self._stageInfosOfNor[dataBitId] = value and GameUtil.pbToTable(value, self._stageInfosOfNor[dataBitId]) or nil
end

function DivineXiuErClgMo:clearAllStageInfoOfNor()
	if self._stageInfosOfNor then
		table.clear(self._stageInfosOfNor)
	end
end

function DivineXiuErClgMo:getFightResultResOfNor()
	return self._fightResultResOfNor
end

function DivineXiuErClgMo:isHasGainPrizeOfExt()
	return self._isHasGainPrizeOfExt
end

function DivineXiuErClgMo:setIsHasGainPrizeOfExt(value)
	self._isHasGainPrizeOfExt = checkbool(value)
end

function DivineXiuErClgMo:getCurTierIdOfExt()
	return self._curTierIdOfExt
end

function DivineXiuErClgMo:setCurTierIdOfExt(value)
	self._curTierIdOfExt = checknumber(value)
end

function DivineXiuErClgMo:getDataBitIdListOfPassOfExt()
	return self._dataBitIdListOfPassOfExt
end

function DivineXiuErClgMo:addDataBitIdListOfPassOfExt(dataBitIdList)
	for i, v in ipairs(dataBitIdList) do
		if table.indexof(self._dataBitIdListOfPassOfExt, v) == false then
			table.insert(self._dataBitIdListOfPassOfExt, v)
		end
	end
end

function DivineXiuErClgMo:clearDataBitIdListOfPassOfExt()
	if self._dataBitIdListOfPassOfExt then
		table.clear(self._dataBitIdListOfPassOfExt)
	end
end

function DivineXiuErClgMo:getStageScoreOfTruefalseOfExt(dataBitId)
	local info = self:getStageInfoOfExt(dataBitId)

	return (info or nil) and (info.score or 0)
end

function DivineXiuErClgMo:getRaceIdListOfLockedOfTruefalseStageOfExt(dataBitId)
	local info = self:getStageInfoOfExt(dataBitId)

	return (info or nil) and (info.raceIdLocked or {})
end

function DivineXiuErClgMo:getStageInfoOfExt(dataBitId)
	return self._stageInfosOfExt[dataBitId]
end

function DivineXiuErClgMo:setStageInfoOfExt(dataBitId, value)
	self._stageInfosOfExt[dataBitId] = value and GameUtil.pbToTable(value, self._stageInfosOfExt[dataBitId]) or nil
end

function DivineXiuErClgMo:clearAllStageInfoOfExt()
	if self._stageInfosOfExt then
		table.clear(self._stageInfosOfExt)
	end
end

function DivineXiuErClgMo:getFightResultResOfExt()
	return self._fightResultResOfExt
end

return DivineXiuErClgMo
