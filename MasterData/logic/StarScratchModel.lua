-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starscratch/model/StarScratchModel.lua

module("logic.extensions.starscratch.model.StarScratchModel", package.seeall)

local StarScratchModel = class("StarScratchModel", BaseModel)

function StarScratchModel:ctor()
	StarScratchModel.super.ctor(self)
end

function StarScratchModel:onInit()
	self:onReset()
end

function StarScratchModel:onReset()
	self._info = {}
end

function StarScratchModel:saveInfo(msg)
	local data = GameUtil.pbToTable(msg)
	local info = {}

	info.broadcast = data.broadcast or {}
	info.curCycle = {}

	if data.curCycle then
		data.curCycle.scratchs = data.curCycle.scratchs or {}
		info.curCycle[data.curCycle.cycleId] = {}

		local cycleInfo = info.curCycle[data.curCycle.cycleId]

		cycleInfo.cycleId = data.curCycle.cycleId
		cycleInfo.drawTimes = data.curCycle.drawTimes
		cycleInfo.scratchs = {}

		for i, v in ipairs(data.curCycle.scratchs or {}) do
			cycleInfo.scratchs[v.id] = v
		end
	end

	self._info[msg.activityId] = info
end

function StarScratchModel:saveBuyInfo(msg, activityId, cycleId)
	local data = GameUtil.pbToTable(msg)

	if not self._info[activityId].curCycle[cycleId] then
		self._info[activityId].curCycle[cycleId] = {}
		self._info[activityId].curCycle[cycleId].cycleId = cycleId
	end

	local cycleInfo = self._info[activityId].curCycle[cycleId]

	cycleInfo.drawTimes = checknumber(cycleInfo.drawTimes) + 1
	cycleInfo.scratchs = cycleInfo.scratchs or {}
	cycleInfo.scratchs[data.newOne.id] = data.newOne
end

function StarScratchModel:saveBroadcast(msg)
	local data = GameUtil.pbToTable(msg)
	local info = self._info[msg.activityId]

	info.broadcast = data.broadcast or {}
end

function StarScratchModel:saveGainPrize(msg)
	local cycleInfo = self._info[msg.activityId].curCycle[msg.cycleId]

	if cycleInfo.scratchs then
		for i, v in ipairs(cycleInfo.scratchs) do
			if v.id == msg.id then
				v.hadGained = true

				break
			end
		end
	end
end

function StarScratchModel:getBroadcastInfo(activityId)
	local info = self._info[activityId]

	return (info or nil) and (info.broadcast or {})
end

function StarScratchModel:getCycleInfo(activityId, cycleId)
	local info = self._info[activityId]

	return info and info.curCycle[cycleId]
end

function StarScratchModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.StarScratch)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.StarScratch)

		return false
	end

	for i, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.StarScratch, v.activityId) then
			local cfg = StarScratchConfig.instance:getActivityCfg(v.activityId)

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

StarScratchModel.instance = StarScratchModel.New()

return StarScratchModel
