-- chunkname: @modules/logic/versionactivity3_4/chg/model/ChgSysModel.lua

module("modules.logic.versionactivity3_4.chg.model.ChgSysModel", package.seeall)

local ChgSysModel = class("ChgSysModel", BaseModel)

function ChgSysModel:onInit()
	self:reInit()
end

function ChgSysModel:reInit()
	self.__config = ChgConfig.instance
	self.__taskType = TaskEnum.TaskType.RoleActivity
end

function ChgSysModel:actId()
	assert(self.__config, "pleaes call self:_internal_set_config(config) first")

	return self.__config:actId()
end

function ChgSysModel:taskType()
	return assert(self.__taskType, "pleaes call self:_internal_set_taskType(taskType) first")
end

function ChgSysModel:config()
	return assert(self.__config, "pleaes call self:_internal_set_config(config) first")
end

function ChgSysModel:isLevelUnlock(episodeId)
	return RoleActivityModel.instance:isLevelUnlock(self:actId(), episodeId)
end

function ChgSysModel:isLevelPass(episodeId)
	return RoleActivityModel.instance:isLevelPass(self:actId(), episodeId)
end

function ChgSysModel:currentEpisodeIdToPlay()
	return RoleActivityModel.instance:currentEpisodeIdToPlay(self:actId())
end

function ChgSysModel:getStoryLevelList()
	return RoleActivityConfig.instance:getStoryLevelList(self:actId())
end

ChgSysModel.instance = ChgSysModel.New()

return ChgSysModel
