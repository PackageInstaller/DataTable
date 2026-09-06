-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liudao/model/LiuDaoModel.lua

module("logic.extensions.liudao.model.LiuDaoModel", package.seeall)

local LiuDaoModel = class("LiuDaoModel", BaseModel)

LiuDaoModel.RefreshType = {
	"daily",
	"weekly"
}

function LiuDaoModel:ctor()
	return
end

function LiuDaoModel:onInit()
	self:onReset()
end

function LiuDaoModel:onReset()
	self._activityId = nil
	self._dailyStages = {}
	self._weekStages = {}
	self._weekIndex = nil
	self._buffs = {}
	self._weekRefreshTimes = nil
	self._dailyGroupIds = {}
	self._weekGroupIds = {}
	self._stages = {}
	self._gainPrizeIds = {}
	self._gainTaskPrizeIds = {}
	self._taskInfo = {}
	self._saveFmt = nil
	self._getBuff = nil

	self:_regRedPoint()
end

function LiuDaoModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.LIUDAOLUNHUA)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.LIUDAOLUNHUA)

		return false
	end

	for i, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.LIUDAOLUNHUA, v.activityId) then
			local cfg = LiuDaoConfig.instance:getActivityCfg(v.activityId)

			if cfg then
				actId = cfg.activityId

				break
			end

			printError("====t_liu_dao_activity no cfg, id = " .. v, activityId)

			break
		end
	end

	return actId
end

function LiuDaoModel:_regRedPoint()
	RedPointController.instance:regUserDayRedPoint(RedPointModel.ID_LIUDAOMAIN_RED)
end

function LiuDaoModel:setActivityId(activityId)
	self._activityId = activityId
end

function LiuDaoModel:SetStageData(msg)
	if self._activityId then
		self._activityCfg = LiuDaoConfig.instance:getActivityCfg(self._activityId)

		local data = GameUtil.pbToTable(msg)

		self._weekIndex = data.weekIndex
		self._weekRefreshTimes = data.weekRefreshTimes
		self._buffs = data.gainBuffIds
		self._dailyGroupIds = LiuDaoConfig.instance:getRefreshTypeList(self._activityId, self._weekIndex, "daily")
		self._weekGroupIds = LiuDaoConfig.instance:getRefreshTypeList(self._activityId, self._weekIndex, "weekly")
		self._stages = {}

		local stageCfg = LiuDaoConfig.instance:getRefreshType(self._activityId, self._weekIndex)

		for i = 1, #stageCfg do
			table.insert(self._stages, {})
		end

		self._dailyStages = {}

		for i, v in ipairs(data.dailyStages) do
			table.insert(self._dailyStages, v)

			if v > 0 then
				local cfg = LiuDaoConfig.instance:getStageCfg(self._activityId, v)

				table.insert(self._stages[cfg.groupId], {
					isDaily = true,
					index = i,
					stage = v
				})
			end
		end

		self._weekStages = {}

		for i, v in ipairs(data.weekStages) do
			table.insert(self._weekStages, v)

			if v > 0 then
				local cfg = LiuDaoConfig.instance:getStageCfg(self._activityId, v)

				table.insert(self._stages[cfg.groupId], {
					isDaily = false,
					index = #self._dailyStages + i,
					stage = v
				})
			end
		end
	else
		self:onReset()
	end
end

function LiuDaoModel:SetTaskData(msg)
	local taskData = GameUtil.pbToTable(msg)

	self._gainPrizeIds = {}
	self._gainTaskPrizeIds = {}

	for i, v in ipairs(taskData.infoList) do
		if v.hasGain == true then
			self._gainTaskPrizeIds[v.taskId] = true
		end
	end

	self._taskInfo = taskData.infoList

	if taskData.gainPrizeIds then
		for i, v in ipairs(taskData.gainPrizeIds) do
			self._gainPrizeIds[v] = true
		end
	end
end

function LiuDaoModel:getActivityId()
	return self._activityId
end

function LiuDaoModel:getDailyStage()
	return self._dailyStages
end

function LiuDaoModel:getWeeklyStage()
	return self._weekStages
end

function LiuDaoModel:getWeekRefreshTimes()
	return self._weekRefreshTimes
end

function LiuDaoModel:getStages()
	return self._stages
end

function LiuDaoModel:getDailyGroupIds()
	return self._dailyGroupIds
end

function LiuDaoModel:getWeekGroupIds()
	return self._weekGroupIds
end

function LiuDaoModel:gainTaskPrizeIds()
	return self._gainTaskPrizeIds
end

function LiuDaoModel:getTaskInfo()
	return self._taskInfo
end

function LiuDaoModel:getWeekIndex()
	return self._weekIndex
end

function LiuDaoModel:getBuffs()
	return self._buffs
end

function LiuDaoModel:saveFmt(fmt)
	self._saveFmt = fmt
end

function LiuDaoModel:getFmt()
	return self._saveFmt
end

function LiuDaoModel:getTaskScore()
	return MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ITEM, self._activityCfg.activityItemId)
end

function LiuDaoModel:readyRefresh(index)
	self._readyRefreshIndex = index

	local cfg = LiuDaoConfig.instance:getStageCfg(self._activityId, index < #self._dailyStages and self._dailyStages[index] or self._weekStages[index - #self._dailyStages])

	self._readyRefreshType = cfg.groupId
end

function LiuDaoModel:refreshMonster(stageIndex, stageId, curTimes)
	local deleteIndex = 0

	for i, v in ipairs(self._stages[self._readyRefreshType]) do
		if v.index == self._readyRefreshIndex then
			deleteIndex = i

			break
		end
	end

	if self._stages[self._readyRefreshType][deleteIndex].isDaily == true then
		table.remove(self._dailyStages, self._readyRefreshIndex)
	else
		table.remove(self._weekStages, self._readyRefreshIndex - #self._dailyStages)
	end

	table.remove(self._stages[self._readyRefreshType], deleteIndex)

	if stageIndex <= #self._dailyStages + 1 then
		table.insert(self._dailyStages, stageIndex, stageId)

		local cfg = LiuDaoConfig.instance:getStageCfg(self._activityId, stageId)

		table.insert(self._stages[cfg.groupId], {
			isDaily = true,
			index = stageIndex,
			stage = stageId
		})
	else
		local insertIdx = stageIndex - #self._dailyStages

		table.insert(self._weekStages, insertIdx, stageId)

		local cfg = LiuDaoConfig.instance:getStageCfg(self._activityId, stageId)

		table.insert(self._stages[cfg.groupId], {
			isDaily = false,
			index = stageIndex,
			stage = stageId
		})
	end

	self._weekRefreshTimes = curTimes
end

function LiuDaoModel:isCanGetProgressReward(activityId, id)
	if activityId ~= self._activityId then
		return false
	end

	local cfg = LiuDaoConfig.instance:getRewardProgressCfg(activityId, id)
	local score = MaterialModel.instance:getMaterialsNumber(MatType.ACTIVITY_ITEM, self._activityCfg.activityItemId)

	return score >= cfg.needScore and not self:isGetedProgressReward(activityId, id)
end

function LiuDaoModel:isGetedProgressReward(activityId, id)
	if activityId ~= self._activityId then
		return false
	end

	if self._gainPrizeIds[id] and self._gainPrizeIds[id] == true then
		return true
	end

	return false
end

function LiuDaoModel:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = LiuDaoCustomFmtMo.New()
	end

	return self._customFmtMo
end

function LiuDaoModel:saveTempIdx(idx)
	self._tempIdx = idx
end

function LiuDaoModel:getTempIdx()
	return self._tempIdx
end

function LiuDaoModel:resetTempIdx()
	self._tempIdx = nil
end

function LiuDaoModel:saveGetBuff()
	self._getBuff = true
end

function LiuDaoModel:getGetBuff()
	return self._getBuff
end

function LiuDaoModel:resetGetBuff()
	self._getBuff = nil
end

LiuDaoModel.instance = LiuDaoModel.New()

return LiuDaoModel
