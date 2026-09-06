-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiyaclg/model/DivineMiyaClgModel.lua

module("logic.extensions.divinemiyaclg.model.DivineMiyaClgModel", package.seeall)

local DivineMiyaClgModel = class("DivineMiyaClgModel", BaseModel)

DivineMiyaClgModel.ReadFlag = "DivineMiyaClgModel.ReadFlag"

function DivineMiyaClgModel:onInit()
	self:onReset()
end

function DivineMiyaClgModel:onReset()
	self._info = {}
	self._fmtMo = nil
end

function DivineMiyaClgModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.DivineMiyaClg)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.DivineMiyaClg)

		return false
	end

	for i, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.DivineMiyaClg, v.activityId) then
			local cfg = DivineMiyaClgConfig.instance:getActivityCfg(v.activityId)

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

function DivineMiyaClgModel:getFmtMo()
	self._fmtMo = self._fmtMo or DivineMiyaClgFmtMo.New()

	return self._fmtMo
end

function DivineMiyaClgModel:saveInfo(msg)
	local info = GameUtil.pbToTable(msg)

	info.stagePrizeMap = {}

	if info.progressPrizeGainedBitId then
		for i, v in ipairs(info.progressPrizeGainedBitId) do
			info.stagePrizeMap[v] = true
		end
	end

	info.curPassMaxStage = 0
	info.stageChangeInfoMap = {}

	if info.stageInfo then
		for i, v in ipairs(info.stageInfo) do
			info.stageChangeInfoMap[v.stageId] = v

			if v.passed == true and v.stageId > info.curPassMaxStage then
				info.curPassMaxStage = v.stageId
			end
		end
	end

	self._info[msg.activityId] = info
end

function DivineMiyaClgModel:saveProgressPrizeInfo(msg)
	local info = self._info[msg.activityId]

	if info then
		info.stagePrizeMap = info.stagePrizeMap or {}
		info.stagePrizeMap[msg.dataBitId] = true
	end
end

function DivineMiyaClgModel:saveChangeStageInfo(msg)
	local info = self._info[msg.activityId]
	local data = GameUtil.pbToTable(msg)

	if info then
		info.stageChangeInfoMap = info.stageChangeInfoMap or {}

		for i, v in ipairs(data.stageInfo or {}) do
			info.stageChangeInfoMap[v.stageId] = v
		end

		info.curPassMaxStage = 0

		for i, v in pairs(info.stageChangeInfoMap) do
			if v.passed == true and v.stageId > info.curPassMaxStage then
				info.curPassMaxStage = v.stageId
			end
		end

		info.usedSkillCount = msg.usedSkillCount
	end
end

function DivineMiyaClgModel:saveBattleInfo(msg)
	local info = self._info[msg.activityId]
	local data = GameUtil.pbToTable(msg)

	if info then
		info.stageChangeInfoMap = info.stageChangeInfoMap or {}
		info.stageChangeInfoMap[data.stageId] = data.stageInfo
		info.curPassMaxStage = data.stageId
		info.historyMaxStageIdPassed = data.historyMaxStageIdPassed
	end
end

function DivineMiyaClgModel:getMaxStagePassed(activityId)
	local info = self._info[activityId]

	if info then
		return info.historyMaxStageIdPassed
	end

	return 0
end

function DivineMiyaClgModel:getCurPassMaxStage(activityId)
	local info = self._info[activityId]

	if info then
		return info.curPassMaxStage
	end

	return 0
end

function DivineMiyaClgModel:getIsGanStagePrize(activityId, stageId)
	local info = self._info[activityId]

	if info and info.stagePrizeMap then
		return info.stagePrizeMap[stageId]
	end

	return false
end

function DivineMiyaClgModel:getUsedSkillCount(activityId)
	local info = self._info[activityId]

	if info then
		return info.usedSkillCount
	end

	return 0
end

function DivineMiyaClgModel:getStageInfo(activityId, stageId)
	local info = self._info[activityId]

	if info and info.stageChangeInfoMap then
		return info.stageChangeInfoMap[stageId]
	end

	return nil
end

function DivineMiyaClgModel:saveReadImgRule(activityId)
	GameUtil.saveUserData(DivineMiyaClgModel.ReadFlag .. "#imgRule#" .. activityId, true)
end

function DivineMiyaClgModel:getReadImgRule(activityId)
	return GameUtil.getUserData(DivineMiyaClgModel.ReadFlag .. "#imgRule#" .. activityId)
end

DivineMiyaClgModel.instance = DivineMiyaClgModel.New()

return DivineMiyaClgModel
