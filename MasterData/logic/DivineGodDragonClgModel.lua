-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinegoddragonclg/model/DivineGodDragonClgModel.lua

module("logic.extensions.divinegoddragonclg.model.DivineGodDragonClgModel", package.seeall)

local DivineGodDragonClgModel = class("DivineGodDragonClgModel", BaseModel)

function DivineGodDragonClgModel:ctor()
	return
end

function DivineGodDragonClgModel:onInit()
	self:onReset()
end

function DivineGodDragonClgModel:onReset()
	self._info = {}
	self._rankInfo = {}
	self._killNum = 0
end

function DivineGodDragonClgModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.DivineGodDragonClg)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.DivineGodDragonClg)

		return false
	end

	for i, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.DivineGodDragonClg, v.activityId) then
			local cfg = DivineGodDragonClgConfig.instance:getActivityCfg(v.activityId)

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

function DivineGodDragonClgModel:saveInfo(msg)
	local data = GameUtil.pbToTable(msg)
	local info = {}

	info.stages = {}
	info.totalKillNum = 0

	if data.stages then
		for i, v in ipairs(data.stages) do
			info.stages[v.stageId] = v.killNum
			info.totalKillNum = info.totalKillNum + v.killNum
		end
	end

	info.progressPrizeIds = {}

	if data.progressPrizeIds then
		for i, v in ipairs(data.progressPrizeIds) do
			info.progressPrizeIds[v] = true
		end
	end

	self._info[data.activityId] = info
end

function DivineGodDragonClgModel:savePrizeGain(msg)
	local info = self._info[msg.activityId]

	info.progressPrizeIds[msg.prizeId] = true
end

function DivineGodDragonClgModel:saveRankInfo(msg)
	local data = GameUtil.pbToTable(msg)
	local rankInfo = {}

	rankInfo.rankInfos = data.rankInfos
	rankInfo.myRank = data.myRank
	self._rankInfo[msg.activityId] = rankInfo
end

function DivineGodDragonClgModel:getKillNum(activityId)
	return (self._info[activityId] or nil) and (self._info[activityId].totalKillNum or 0)
end

function DivineGodDragonClgModel:getStageKillNum(activityId, stageId)
	return (self._info[activityId] or nil) and (self._info[activityId].stages[stageId] or 0)
end

function DivineGodDragonClgModel:isCanGetProgressReward(activityId, id)
	local cfg = DivineGodDragonClgConfig.instance:getRewardProgressListCfg(activityId, id)

	return self._info[activityId] and not self._info[activityId].progressPrizeIds[id] and self._info[activityId].totalKillNum >= cfg.killNum or false
end

function DivineGodDragonClgModel:isGetedProgressReward(activityId, id)
	return (self._info[activityId] or nil) and (self._info[activityId].progressPrizeIds[id] or false)
end

function DivineGodDragonClgModel:getFmtMo()
	self._fmtMo = self._fmtMo or DivineGodDragonClgFmtMo.New()

	return self._fmtMo
end

function DivineGodDragonClgModel:getMyRank(activityId)
	return (self._rankInfo[activityId] or nil) and (self._rankInfo[activityId].myRank or 0)
end

function DivineGodDragonClgModel:getRankInfo(activityId)
	return (self._rankInfo[activityId] or nil) and (self._rankInfo[activityId].rankInfos or {})
end

function DivineGodDragonClgModel:saveKillNum(activityId, stageId, killNum)
	if self._info[activityId] then
		self._info[activityId].totalKillNum = self._info[activityId].totalKillNum - checknumber(self._info[activityId].stages[stageId]) + killNum
		self._info[activityId].stages[stageId] = killNum
	end
end

DivineGodDragonClgModel.instance = DivineGodDragonClgModel.New()

return DivineGodDragonClgModel
