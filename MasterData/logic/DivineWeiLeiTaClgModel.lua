-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineweileitaclg/model/DivineWeiLeiTaClgModel.lua

module("logic.extensions.divineweileitaclg.model.DivineWeiLeiTaClgModel", package.seeall)

local DivineWeiLeiTaClgModel = class("DivineWeiLeiTaClgModel", BaseModel)

function DivineWeiLeiTaClgModel:onInit()
	self:onReset()
end

function DivineWeiLeiTaClgModel:onReset()
	self._infos = {}
	self._extTempData = {}
	self._extFmtMo = nil
	self._normalFmtMo = nil
end

function DivineWeiLeiTaClgModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.DivineWeiLeiTaClg)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.DivineWeiLeiTaClg)

		return false
	end

	for i, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.DivineWeiLeiTaClg, v.activityId) then
			local cfg = DivineWeiLeiTaClgConfig.instance:getActivityCfg(v.activityId)

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

function DivineWeiLeiTaClgModel:saveExtremeInfo(msg)
	local info = self._infos[msg.activityId]

	if not info then
		self._infos[msg.activityId] = {}
		info = self._infos[msg.activityId]
	end

	local extremeInfo = GameUtil.pbToTable(msg)

	extremeInfo.lockRaceIdMap = {}
	extremeInfo.stageInfoMap = {}

	if extremeInfo.stages then
		for i, stageInfo in ipairs(extremeInfo.stages) do
			for j, v in ipairs(stageInfo.lockRaceIds or {}) do
				extremeInfo.lockRaceIdMap[v] = true
			end

			extremeInfo.stageInfoMap[stageInfo.stageId] = stageInfo
		end
	end

	info.extremeInfo = extremeInfo
end

function DivineWeiLeiTaClgModel:getExtCurStageId(activityId)
	local info = self._infos[activityId]

	if info and info.extremeInfo then
		return info.extremeInfo.curStageId
	end

	return 0
end

function DivineWeiLeiTaClgModel:getExtMaxStageId(activityId)
	local info = self._infos[activityId]

	if info and info.extremeInfo then
		return info.extremeInfo.maxStageId
	end

	return 0
end

function DivineWeiLeiTaClgModel:isExtRaceLock(activityId, raceId)
	local info = self._infos[activityId]

	if info and info.extremeInfo then
		return info.extremeInfo.lockRaceIdMap[raceId]
	end

	return false
end

function DivineWeiLeiTaClgModel:getExtStageInfo(activityId, stageId)
	local info = self._infos[activityId]

	if info and info.extremeInfo then
		return info.extremeInfo.stageInfoMap[stageId]
	end

	return nil
end

function DivineWeiLeiTaClgModel:getExtFmtMo()
	self._extFmtMo = self._extFmtMo or DivineWeiLeiTaClgExtFmtMo.New()

	return self._extFmtMo
end

function DivineWeiLeiTaClgModel:saveExtBattle(msg)
	self._extTempData[msg.activityId] = GameUtil.pbToTable(msg)
end

function DivineWeiLeiTaClgModel:resetExtBattleTempData(activityId)
	self._extTempData[activityId] = nil
end

function DivineWeiLeiTaClgModel:getExtBattleTempData(activityId)
	return self._extTempData[activityId]
end

function DivineWeiLeiTaClgModel:saveExtremeReset(msg)
	local info = self._infos[msg.activityId]

	if info and info.extremeInfo then
		info.extremeInfo.curStageId = 0
		info.extremeInfo.lockRaceIdMap = {}
		info.extremeInfo.stageInfoMap = {}
		info.extremeInfo.stages = nil
	end
end

function DivineWeiLeiTaClgModel:saveExtremeConfirm(msg)
	local tempData = self._extTempData[msg.activityId]
	local info = self._infos[tempData.activityId]

	if info and info.extremeInfo then
		info.extremeInfo.curStageId = tempData.stageId

		for i, v in ipairs(tempData.lockRaceIds or {}) do
			info.extremeInfo.lockRaceIdMap[v] = true
		end

		info.extremeInfo.stageInfoMap[tempData.stageId] = {
			stageId = tempData.stageId,
			lockRaceIds = tempData.lockRaceIds
		}

		if info.extremeInfo.maxStageId < tempData.stageId then
			info.extremeInfo.maxStageId = tempData.stageId
		end
	end
end

function DivineWeiLeiTaClgModel:saveNormalInfo(msg)
	local info = self._infos[msg.activityId]

	if not info then
		self._infos[msg.activityId] = {}
		info = self._infos[msg.activityId]
	end

	local normalInfo = GameUtil.pbToTable(msg)

	normalInfo.prizeGainMap = {}

	if normalInfo.gainedPrizeIds then
		for i, v in ipairs(normalInfo.gainedPrizeIds) do
			normalInfo.prizeGainMap[v] = true
		end
	else
		normalInfo.gainedPrizeIds = {}
	end

	normalInfo.todayMaxDamage = checknumber(normalInfo.todayMaxDamage)
	info.normalInfo = normalInfo
end

function DivineWeiLeiTaClgModel:saveNormalGainPrize(msg)
	local info = self._infos[msg.activityId]

	if info and info.normalInfo then
		table.insert(info.normalInfo.gainedPrizeIds, msg.prizeId)

		info.normalInfo.prizeGainMap[msg.prizeId] = true
	end
end

function DivineWeiLeiTaClgModel:saveNormalBattle(msg)
	local info = self._infos[msg.activityId]

	if info and info.normalInfo then
		local preMaxDamage = info.normalInfo.todayMaxDamage
		local curDamage = checknumber(msg.damage)

		if preMaxDamage < curDamage then
			local damageCfgs = DivineWeiLeiTaClgConfig.instance:getNormalDnamgeCfg(msg.activityId)
			local maxCurScore = 0
			local maxPreScore = 0

			for i, v in ipairs(damageCfgs) do
				if curDamage > v.damage then
					maxCurScore = v.score + maxCurScore
				end

				if preMaxDamage > v.damage then
					maxPreScore = v.score + maxPreScore
				end
			end

			if maxPreScore < maxCurScore then
				info.normalInfo.socre = info.normalInfo.socre - maxPreScore + maxCurScore
			end

			info.normalInfo.todayMaxDamage = curDamage
		end

		info.normalInfo.curDamage = curDamage
	end
end

function DivineWeiLeiTaClgModel:getTodayCreepMasterId(activityId)
	local info = self._infos[activityId]

	if info and info.normalInfo then
		return info.normalInfo.todayCreepMasterId
	end

	return 0
end

function DivineWeiLeiTaClgModel:getTodayMaxDamage(activityId)
	local info = self._infos[activityId]

	if info and info.normalInfo then
		return checknumber(info.normalInfo.todayMaxDamage)
	end

	return 0
end

function DivineWeiLeiTaClgModel:getCurDamage(activityId)
	local info = self._infos[activityId]

	if info and info.normalInfo then
		return checknumber(info.normalInfo.curDamage)
	end

	return 0
end

function DivineWeiLeiTaClgModel:getScore(activityId)
	local info = self._infos[activityId]

	if info and info.normalInfo then
		return info.normalInfo.socre or 0
	end

	return 0
end

function DivineWeiLeiTaClgModel:getGainPrizeIds(activityId)
	local info = self._infos[activityId]

	if info and info.normalInfo then
		return info.normalInfo.gainedPrizeIds or {}
	end

	return {}
end

function DivineWeiLeiTaClgModel:isCanGetProgressReward(activityId, prizeId)
	local info = self._infos[activityId]

	if info and info.normalInfo then
		local score = info.normalInfo.socre
		local prizeCfg = DivineWeiLeiTaClgConfig.instance:getNormalPrizeCfg(activityId, prizeId)

		return not info.normalInfo.prizeGainMap[prizeId] and score >= prizeCfg.score
	end

	return false
end

function DivineWeiLeiTaClgModel:isGetedProgressReward(activityId, prizeId)
	local info = self._infos[activityId]

	if info and info.normalInfo then
		return info.normalInfo.prizeGainMap[prizeId]
	end

	return false
end

function DivineWeiLeiTaClgModel:getNormalFmtMo()
	self._normalFmtMo = self._normalFmtMo or DivineWeiLeiTaClgNormalFmtMo.New()

	return self._normalFmtMo
end

DivineWeiLeiTaClgModel.instance = DivineWeiLeiTaClgModel.New()

return DivineWeiLeiTaClgModel
