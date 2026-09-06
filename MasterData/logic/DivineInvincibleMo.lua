-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinvincible/data/DivineInvincibleMo.lua

module("logic.extensions.divineinvincible.data.DivineInvincibleMo", package.seeall)

local DivineInvincibleMo = class("DivineInvincibleMo")

function DivineInvincibleMo:ctor(activityId)
	self._activityId = activityId
	self._changeSetIdList = {}
	self._extStageInfos = {}
	self._extPassInfos = {}
	self._norStageInfos = {}
	self._totalKillNum = 0
	self._gainedPrizeidsInNor = {}
	self._extFightMsg = nil
end

function DivineInvincibleMo:dispose()
	self._extStageInfos = nil
	self._extPassInfos = nil
	self._extFightMsg = nil
end

function DivineInvincibleMo:handlePM_DivineInvincibleClgExtremeInfoRes(msg)
	table.clear(self._extStageInfos)

	for i, v in ipairs(msg.stages) do
		self._extStageInfos[v.stageId] = v
	end

	table.clear(self._extPassInfos)

	for i, v in ipairs(msg.pass) do
		self._extPassInfos[v.posId] = v
	end
end

function DivineInvincibleMo:handlePM_DivineInvincibleClgExtremeFightRes(msg)
	return
end

function DivineInvincibleMo:handlePM_DivineInvincibleClgExtremeConfirmRes(msg)
	return
end

function DivineInvincibleMo:handlePM_DivineInvincibleClgExtremeResetRes(msg)
	table.clear(self._extStageInfos)
	table.clear(self._extPassInfos)
end

function DivineInvincibleMo:handlePM_DivineInvincibleClgNormalInfoRes(msg)
	table.clear(self._norStageInfos)

	for _, v in ipairs(msg.stages) do
		self._norStageInfos[v.indexId] = v
	end

	self._totalKillNum = msg.totalKillNum

	table.clear(self._gainedPrizeidsInNor)

	for _, v in ipairs(msg.gainedPrizeids) do
		self._gainedPrizeidsInNor[v] = true
	end
end

function DivineInvincibleMo:handlePM_DivineInvincibleClgNormalFightRes(msg)
	return
end

function DivineInvincibleMo:handlePM_DivineInvincibleClgNormalGainPrizeRes(msg)
	self._gainedPrizeidsInNor[msg.prizeId] = true
end

function DivineInvincibleMo:handlePM_NotifyDivineInvincibleClgExtremeFightResultRes(msg)
	self._extFightMsg = msg
end

function DivineInvincibleMo:handlePM_NotifyDivineInvincibleClgNormalFightResultRes(msg)
	return
end

function DivineInvincibleMo:saveChangeSetId(changeSetId)
	table.insert(self._changeSetIdList, changeSetId)
end

function DivineInvincibleMo:popChangeSetId()
	if #self._changeSetIdList > 0 then
		return (table.remove(self._changeSetIdList, #self._changeSetIdList))
	end
end

function DivineInvincibleMo:getTryResultAndTipsStartExtremeStageClg(isShowTips, stageId)
	local result = GameEnum.ResultCode.Success
	local tips

	if result == GameEnum.ResultCode.Success and not DivineInvincibleController.instance:isInActivityTime(self._activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	if result == GameEnum.ResultCode.Success and self:isPassStageInExt(stageId) then
		result = GameEnum.ResultCode.Error
		tips = "已通关"
	end

	if result == GameEnum.ResultCode.Success and self:isPassExtremeClg() then
		result = GameEnum.ResultCode.Error
		tips = "挑战已完成"
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function DivineInvincibleMo:getTryResultAndTipsResetExtremeStageClg(isShowTips)
	local result = GameEnum.ResultCode.Success
	local tips

	if result == GameEnum.ResultCode.Success and not DivineInvincibleController.instance:isInActivityTime(self._activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	if result == GameEnum.ResultCode.Success then
		local isHavePass = false
		local cfg = DivineInvincibleConfig.instance:getExtStageCfg(self._activityId) or {}

		for _, data in ipairs(cfg) do
			if self:isPassStageInExt(data.stageId) then
				isHavePass = true

				break
			end
		end

		if not isHavePass then
			result = GameEnum.ResultCode.Error
			tips = "无需重置"
		end
	end

	if result == GameEnum.ResultCode.Success then
		local isUltTrialClg = UltimateTrialController.instance:isUltTrialClg(self._activityId)

		if not isUltTrialClg and self:isPassExtremeClg() then
			result = GameEnum.ResultCode.Error
			tips = "挑战已完成"
		end
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function DivineInvincibleMo:getTryResultAndTipsStartNormalStageClg(isShowTips, stageId)
	local result = GameEnum.ResultCode.Success
	local tips

	if result == GameEnum.ResultCode.Success and not DivineInvincibleController.instance:isInActivityTime(self._activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	if isShowTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function DivineInvincibleMo:isPassExtremeClg()
	local isPass = true

	if isPass then
		local cfg = DivineInvincibleConfig.instance:getExtStageCfg(self._activityId) or {}

		for _, data in ipairs(cfg) do
			if not self:isPassStageInExt(data.stageId) then
				isPass = false

				break
			end
		end
	end

	if isPass then
		local cfg = DivineInvincibleConfig.instance:getExtPassCfg(self._activityId) or {}

		for _, data in ipairs(cfg) do
			if not self:isFinishInExtPass(data.posId) then
				isPass = false

				break
			end
		end
	end

	return isPass
end

function DivineInvincibleMo:isPassStageInExt(stageId)
	local list = self:getLockRaceIdsInExt(stageId)

	return #list > 0
end

function DivineInvincibleMo:getAllLockRaceIdsInExt()
	local result = {}

	for stageId, info in pairs(self._extStageInfos) do
		local list = self:getLockRaceIdsInExt(stageId)

		table.insertto(result, list)
	end

	return result
end

function DivineInvincibleMo:getLockRaceIdsInExt(stageId)
	local info = self:getExtStageInfo(stageId)

	return (info or nil) and (info.lockRaceIds or {})
end

function DivineInvincibleMo:getExtStageInfo(stageId)
	return self._extStageInfos[stageId]
end

function DivineInvincibleMo:getFinishNumInExtPass()
	local num = 0

	for posId, v in pairs(self._extPassInfos) do
		if self:isFinishInExtPass(posId) then
			num = num + 1
		end
	end

	return num
end

function DivineInvincibleMo:isFinishInExtPass(posId)
	local cur = self:getTimesInExtPass(posId)
	local need = self:getNeedTimesInExtPass(posId)

	return need <= cur
end

function DivineInvincibleMo:getNeedTimesInExtPass(posId)
	local data = DivineInvincibleConfig.instance:getExtPassData(self._activityId, posId)

	return (data or nil) and (data.groupAttackTimes or 0)
end

function DivineInvincibleMo:getTimesInExtPass(posId)
	local info = self:getExtPassInfo(posId)

	return (info or nil) and (info.times or 0)
end

function DivineInvincibleMo:getExtPassInfo(posId)
	return self._extPassInfos[posId]
end

function DivineInvincibleMo:getExtFightMsg()
	return self._extFightMsg
end

function DivineInvincibleMo:getTotalKillNumInNor()
	return self._totalKillNum
end

function DivineInvincibleMo:getMaxKillNumProgressInNor()
	local cfg = DivineInvincibleConfig.instance:getNorPrizeCfg(self._activityId)
	local data = cfg and cfg[#cfg]

	return (data or nil) and (data.num or 0)
end

function DivineInvincibleMo:getkillNumInNor(stageId)
	local info = self:getStageInfoInNor(stageId)

	return (info or nil) and (info.killNum or 0)
end

function DivineInvincibleMo:getStageInfoInNor(stageId)
	return self._norStageInfos[stageId]
end

function DivineInvincibleMo:isCanPrizeInNor(prizeId)
	return not self:isHasGainPrizeInNor(prizeId) and self:isEnoughPrizeInNor(prizeId)
end

function DivineInvincibleMo:isHasGainPrizeInNor(prizeId)
	return checkbool(self._gainedPrizeidsInNor[prizeId])
end

function DivineInvincibleMo:isEnoughPrizeInNor(prizeId)
	local data = DivineInvincibleConfig.instance:getNorPrizeData(self._activityId, prizeId)

	if data then
		if not data.num then
			local need = 0
			local cur = self:getTotalKillNumInNor()

			return need <= cur
		end
	end
end

function DivineInvincibleMo:getCurDayInNor()
	local activityType = DivineInvincibleController.instance:getActivityType()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, self._activityId)
	local day = GameUtil.getDaysByTimestamp(startTime, ServerTime.now())
	local cfg = DivineInvincibleConfig.instance:getNorStageCfg(self._activityId) or {}
	local length = #cfg

	if length > 0 then
		return (day - 1) % length + 1
	else
		return 0
	end
end

return DivineInvincibleMo
