-- chunkname: @modules/logic/versionactivity/model/VersionActivityTaskBonusListModel.lua

module("modules.logic.versionactivity.model.VersionActivityTaskBonusListModel", package.seeall)

local VersionActivityTaskBonusListModel = class("VersionActivityTaskBonusListModel", ListScrollModel)

function VersionActivityTaskBonusListModel:onInit()
	return
end

function VersionActivityTaskBonusListModel:reInit()
	self.taskActivityMo = nil
end

function VersionActivityTaskBonusListModel:initTaskBonusList()
	return
end

function VersionActivityTaskBonusListModel:refreshList()
	self:setList(TaskConfig.instance:getTaskActivityBonusConfig(TaskEnum.TaskType.ActivityDungeon))
end

function VersionActivityTaskBonusListModel:getTaskActivityMo()
	self.taskActivityMo = self.taskActivityMo or TaskModel.instance:getTaskActivityMO(TaskEnum.TaskType.ActivityDungeon)

	return self.taskActivityMo
end

function VersionActivityTaskBonusListModel:recordPrefixActivityPointCount()
	local taskActivityMo = self:getTaskActivityMo()

	self.prefixActivityPointCount = taskActivityMo.value
end

function VersionActivityTaskBonusListModel:checkActivityPointCountHasChange()
	return self.prefixActivityPointCount ~= self:getTaskActivityMo().value
end

function VersionActivityTaskBonusListModel:checkNeedPlayEffect(defineId, pointCount)
	local pointValue = TaskConfig.instance:getTaskBonusValue(TaskEnum.TaskType.ActivityDungeon, defineId, pointCount)

	return pointValue > self.prefixActivityPointCount and pointValue <= self:getTaskActivityMo().value
end

VersionActivityTaskBonusListModel.instance = VersionActivityTaskBonusListModel.New()

return VersionActivityTaskBonusListModel
