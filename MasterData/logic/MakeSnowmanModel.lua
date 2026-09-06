-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/makesnowman/model/MakeSnowmanModel.lua

module("logic.extensions.makesnowman.model.MakeSnowmanModel", package.seeall)

local MakeSnowmanModel = class("MakeSnowmanModel", BaseModel)

function MakeSnowmanModel:ctor()
	MakeSnowmanModel.super.ctor(self)
end

function MakeSnowmanModel:onInit()
	MakeSnowmanModel.super.onInit(self)

	self._curBuildSnowman = nil
	self._gainPrizeIds = {}
	self._progress = 0
end

function MakeSnowmanModel:onReset()
	MakeSnowmanModel.super.onReset(self)

	self._curBuildSnowman = nil
	self._gainPrizeIds = {}
	self._progress = 0
end

function MakeSnowmanModel:getCurBuildSnowman()
	return checknumber(self._curBuildSnowman)
end

function MakeSnowmanModel:setCurBuildSnowman(id)
	self._curBuildSnowman = checknumber(id)
end

function MakeSnowmanModel:setData(msg)
	local data = GameUtil.pbToTable(msg)

	self._activityId = data.activityId
	self._gainPrizeIds = {}
	self._progress = 0

	local maxId = 0

	if data.gainPrizeIds then
		for i, v in ipairs(data.gainPrizeIds) do
			self._gainPrizeIds[v] = true

			if maxId < v then
				maxId = v
			end
		end
	end

	self._canGetPrizeId = maxId + 1
	self._progress = checknumber(data.progress)
end

function MakeSnowmanModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.MAKE_SNOWMAN)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.MAKE_SNOWMAN)

		return false
	end

	for i, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.MAKE_SNOWMAN, v.activityId) then
			local cfg = MakeSnowmanConfig.instance:getActivityCfg(v.activityId)

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

function MakeSnowmanModel:isCanGetProgressReward(activityId, prizeId)
	if self._activityId ~= activityId then
		return false
	end

	local actCfg = MakeSnowmanConfig.instance:getActivityCfg(activityId)
	local prizeCfg = MakeSnowmanConfig.instance:getPrizeCfg(actCfg.prizePlanId, prizeId)

	return prizeCfg.progress <= self._progress and self._canGetPrizeId == prizeId
end

function MakeSnowmanModel:isGetedProgressReward(activityId, prizeId)
	if self._activityId ~= activityId then
		return false
	end

	return self._gainPrizeIds[prizeId] or false
end

function MakeSnowmanModel:getProgress()
	return self._progress
end

function MakeSnowmanModel:getUnits()
	return self._units
end

function MakeSnowmanModel:startUnits(units)
	self._units = {}

	for i, v in ipairs(units) do
		self._units[v] = true
	end
end

function MakeSnowmanModel:clearUnits()
	self._units = {}
end

function MakeSnowmanModel:removeUnit(value)
	self._units[value] = false
end

function MakeSnowmanModel:setDragCellIndex(index)
	self._dragCellIndex = index
end

function MakeSnowmanModel:getDragCellIndex()
	return self._dragCellIndex
end

MakeSnowmanModel.instance = MakeSnowmanModel.New()

return MakeSnowmanModel
