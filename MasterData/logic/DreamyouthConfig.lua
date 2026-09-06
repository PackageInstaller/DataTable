-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamyouth/config/DreamyouthConfig.lua

module("logic.extensions.dreamyouth.config.DreamyouthConfig", package.seeall)

local DreamyouthConfig = class("DreamyouthConfig", BaseConfig)

function DreamyouthConfig:onInit()
	DreamyouthConfig.super.onInit(self)

	self._dream_youth_activity = nil
	self._dream_youth_task = nil
	self._dream_youth_strengthen = nil
	self._tabview = nil
	self.ST_Pet = 1
	self.ST_Level = 2
	self.ST_WakeUp = 3
end

function DreamyouthConfig:getNames()
	return {
		"dream_youth_activity",
		"dream_youth_task",
		"dream_youth_strengthen",
		"tabview"
	}
end

function DreamyouthConfig:handleConfig(name, content)
	if name == "dream_youth_activity" then
		self._dream_youth_activity = content
	elseif name == "dream_youth_task" then
		self._dream_youth_task = content
	elseif name == "dream_youth_strengthen" then
		self._dream_youth_strengthen = content
	elseif name == "tabview" then
		self._tabview = content
	end
end

function DreamyouthConfig:initTaskConf()
	self._taskPrizeTotal = {}

	local prize = string.split(self:getCoinItemStr(), ":")
	local ptype = checknumber(prize[1])
	local pid = checknumber(prize[2])

	for i, v in ipairs(self:getTaskCfg()) do
		local type = v.type

		if self._taskPrizeTotal[type] == nil then
			self._taskPrizeTotal[type] = 0
		end

		local vprize = string.split(v.prize, ":")

		if checknumber(vprize[1]) == ptype and checknumber(vprize[2]) == pid then
			self._taskPrizeTotal[type] = self._taskPrizeTotal[type] + checknumber(vprize[3])
		end
	end
end

function DreamyouthConfig:taskPrizeTotal(taskType)
	if self._taskPrizeTotal == nil then
		self:initTaskConf()
	end

	return self._taskPrizeTotal[taskType]
end

function DreamyouthConfig:getActCfg()
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(checknumber(GameEnum.ActivityType.Dreamyouth))

	for _, item in pairs(cfgs) do
		if GameUtil.checkIsInTimePeriod(item.startTime, item.endTime) then
			return item
		end
	end

	return nil
end

function DreamyouthConfig:getActId()
	local cfg = self:getActCfg()

	if cfg then
		return cfg.activityId
	end

	return -2
end

function DreamyouthConfig:coinForStrengthenType(strengthenType)
	return checknumber(self:getStrengthenCfg()[strengthenType].needScore)
end

function DreamyouthConfig:countMaxStrengthenType(strengthenType)
	return checknumber(self:getStrengthenCfg()[strengthenType].countMax)
end

function DreamyouthConfig:weekTimesStrengthenType(strengthenType)
	return 0
end

function DreamyouthConfig:getPackId(i)
	return checknumber(string.split(self:getCfg().packId, "#")[i])
end

function DreamyouthConfig:getTabCfg()
	return self._tabview
end

function DreamyouthConfig:getCfg()
	return self._dream_youth_activity[self:getActId()]
end

function DreamyouthConfig:getTaskCfg()
	return self._dream_youth_task[self:getActId()]
end

function DreamyouthConfig:getStrengthenCfg()
	return self._dream_youth_strengthen[self:getCfg().strengthenPlanId]
end

function DreamyouthConfig:getCoinItemStr()
	return self:getCfg().itemId
end

function DreamyouthConfig:getCoinIconUrl()
	local iconUrl = ""
	local matMo = string.splitToNumber(self:getCoinItemStr(), ":")
	local cfg = MaterialMgr.getMatCfg(matMo[1], matMo[2])

	if cfg then
		local icon = cfg.icon

		iconUrl = GameUrl.getItemIconUrl(icon)
	end

	return iconUrl
end

local json = require("cjson")

DreamyouthConfig.instance = DreamyouthConfig.New()

return DreamyouthConfig
