-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicedtower/model/PsychicedTowerModel.lua

module("logic.extensions.psychicedtower.model.PsychicedTowerModel", package.seeall)

local PsychicedTowerModel = class("PsychicedTowerModel", BaseModel)

PsychicedTowerModel.TOTLE_RANK_TABID = "PsychicedTowerModel.TOTLE_RANK_TABID"

function PsychicedTowerModel:onInit()
	self:onReset()
end

function PsychicedTowerModel:onReset()
	self._infos = {}
	self._rankInfo = {}
	self._fmtMo = nil
end

function PsychicedTowerModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.PsychicedTower)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.WuWenChallenge)

		return false
	end

	for i, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.PsychicedTower, v.activityId) then
			local cfg = PsychicedTowerConfig.instance:getActivityCfg(v.activityId)

			if cfg then
				actId = cfg.activityId

				break
			end

			printError("====t_wu_wen_clg no cfg, id = " .. v, activityId)

			break
		end
	end

	return actId
end

function PsychicedTowerModel:saveInfo(msg)
	self._passStage = {}

	local info = GameUtil.pbToTable(msg)

	info.towersInfoMap = {}
	info.passStage = {}

	for i, towerInfo in ipairs(info.towers) do
		info.towersInfoMap[towerInfo.towerId] = towerInfo

		local stageInfoMap = {}

		if towerInfo.stages then
			for j, stageInfo in ipairs(towerInfo.stages) do
				stageInfoMap[stageInfo.stageId] = checknumber(stageInfo.starNum)

				if not info.passStage[towerInfo.towerId] or stageInfo.stageId > info.passStage[towerInfo.towerId] then
					info.passStage[towerInfo.towerId] = stageInfo.stageId
				end
			end
		end

		info.towersInfoMap[towerInfo.towerId].stageInfoMap = stageInfoMap
	end

	self._infos[msg.activityId] = info
end

function PsychicedTowerModel:getStageInfo(activityId, towerId, stageId)
	local info = self._infos[activityId]

	if info.towersInfoMap[towerId] and info.towersInfoMap[towerId].stageInfoMap then
		return info.towersInfoMap[towerId].stageInfoMap[stageId]
	end

	return nil
end

function PsychicedTowerModel:getPassStage(activityId, towerId)
	local info = self._infos[activityId]

	if not info then
		return 0
	end

	return info.passStage[towerId] or 0
end

function PsychicedTowerModel:getFmtMo()
	self._fmtMo = self._fmtMo or PsychicedTowerFmtMo.New()

	return self._fmtMo
end

function PsychicedTowerModel:getStageBuffs(planId)
	planId = checknumber(planId)

	local diffCfgs = PsychicedTowerConfig.instance:getStageBuff(planId)

	if diffCfgs == nil then
		return
	end

	local nowTime = ServerTime.now()
	local targetList = {}
	local groupCfg

	for j, groupCfgs in ipairs(diffCfgs) do
		if groupCfgs and #groupCfgs >= 1 then
			local buffType = groupCfgs[1].buffType
			local index = self:_getBuffTypeIsChoise(buffType)

			table.insert(targetList, {
				groupId = buffType,
				groupList = groupCfgs,
				curIndex = index,
				curTime = nowTime
			})
		end
	end

	return targetList
end

function PsychicedTowerModel:_getBuffTypeIsChoise(buffType)
	return (self._selectMap or nil) and (self._selectMap[buffType] or 0)
end

function PsychicedTowerModel:setChooseBuff(list)
	self._cacheBuffList = list or {}
	self._selectMap = {}

	for i, v in ipairs(self._cacheBuffList) do
		self._selectMap[v.buffType] = v.buffLevel
	end
end

function PsychicedTowerModel:getChooseBuff()
	return self._cacheBuffList or {}
end

function PsychicedTowerModel:getBuffLevel(activityId, towerId)
	local info = self._infos[activityId]

	if info and info.towersInfoMap[towerId] then
		return info.towersInfoMap[towerId].buffLevel or 0
	end

	return 0
end

function PsychicedTowerModel:getIsTodayGainedBuff(activityId, towerId)
	local info = self._infos[activityId]

	if info and info.towersInfoMap[towerId] then
		return info.towersInfoMap[towerId].todayGainedBuff or false
	end

	return false
end

function PsychicedTowerModel:saveStageInfo(msg)
	local info = self._infos[msg.activityId]

	info.towersInfoMap[msg.towerId] = info.towersInfoMap[msg.towerId] or {}
	info.towersInfoMap[msg.towerId].stageInfoMap = info.towersInfoMap[msg.towerId].stageInfoMap or {}

	if not info.towersInfoMap[msg.towerId].stageInfoMap[msg.stageId] then
		local stageCfg = PsychicedTowerConfig.instance:getStageCfg(msg.activityId, msg.towerId, msg.stageId)
		local buffCfgs = PsychicedTowerConfig.instance:getStageBuff(stageCfg.buffPlanId)
		local newStar = 0

		for i, v in ipairs(msg.buffs or {}) do
			local buffCfg = buffCfgs[v.buffType][v.level]

			newStar = newStar + buffCfg.starNum
		end

		if info.towersInfoMap[msg.towerId].stageInfoMap[msg.stageId] < newStar then
			info.towersInfoMap[msg.towerId].stageInfoMap[msg.stageId] = newStar
		end
	end
end

function PsychicedTowerModel:saveGainDailyBuff(msg)
	local info = self._infos[msg.activityId]
	local towerInfo = info.towersInfoMap[msg.towerId]

	if towerInfo then
		towerInfo.buffLevel = towerInfo.buffLevel + 1
		towerInfo.todayGainedBuff = true
	end
end

function PsychicedTowerModel:saveRankInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._rankInfo[msg.activityId] = self._rankInfo[msg.activityId] or {}
	self._rankInfo[msg.activityId][msg.towerId] = {}

	local rankInfo = self._rankInfo[msg.activityId][msg.towerId]

	rankInfo.rankInfos = data.rankInfos or {}
	rankInfo.myRank = data.myRank

	local myStar = 0
	local stageInfo = self._infos[msg.activityId]

	if stageInfo then
		if not stageInfo.towersInfoMap[msg.towerId] then
			for i, v in pairs(stageInfo.towersInfoMap[msg.towerId].stageInfoMap) do
				myStar = myStar + v
			end
		end
	end

	rankInfo.myStar = myStar
end

function PsychicedTowerModel:saveTotalRankInfo(msg)
	local tabId = PsychicedTowerModel.TOTLE_RANK_TABID
	local data = GameUtil.pbToTable(msg)

	self._rankInfo[msg.activityId] = self._rankInfo[msg.activityId] or {}
	self._rankInfo[msg.activityId][tabId] = {}

	local rankInfo = self._rankInfo[msg.activityId][tabId]

	rankInfo.rankInfos = data.rankInfos or {}
	rankInfo.myRank = checknumber(data.myRank)

	local myStar = 0
	local stageInfo = self._infos[msg.activityId]

	if stageInfo then
		for i, towerInfo in pairs(stageInfo.towersInfoMap) do
			for j, v in pairs(towerInfo.stageInfoMap) do
				myStar = myStar + v
			end
		end
	end

	rankInfo.myStar = myStar
end

function PsychicedTowerModel:getRankInfo(activityId, tabId)
	return self._rankInfo[activityId][tabId]
end

PsychicedTowerModel.instance = PsychicedTowerModel.New()

return PsychicedTowerModel
