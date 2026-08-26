-- chunkname: @modules/logic/versionactivity/model/VersionActivity112Model.lua

module("modules.logic.versionactivity.model.VersionActivity112Model", package.seeall)

local VersionActivity112Model = class("VersionActivity112Model", BaseModel)

function VersionActivity112Model:onInit()
	self.infosDic = {}
end

function VersionActivity112Model:reInit()
	self:onInit()
end

function VersionActivity112Model:updateInfo(msg)
	self._lastActId = msg.activityId
	self.infosDic[msg.activityId] = {}

	for i, v in ipairs(msg.infos) do
		self.infosDic[msg.activityId][v.id] = v
	end

	VersionActivity112TaskListModel.instance:refreshAlllTaskInfo(msg.activityId, msg.act112Tasks)
	VersionActivityController.instance:dispatchEvent(VersionActivityEvent.VersionActivity112Update)
end

function VersionActivity112Model:updateRewardState(actId, id)
	self.infosDic[actId][id].state = 1

	VersionActivityController.instance:dispatchEvent(VersionActivityEvent.VersionActivity112Update)
end

function VersionActivity112Model:getRewardState(actId, id)
	if self.infosDic[actId] and self.infosDic[actId][id] then
		return self.infosDic[actId][id].state
	end

	return 0
end

function VersionActivity112Model:hasGetReward(id, actId)
	actId = actId or self._lastActId

	if self.infosDic[actId] and self.infosDic[actId][id] then
		return self.infosDic[actId][id].state == 1
	end

	return false
end

function VersionActivity112Model:getRewardList(actId)
	actId = actId or self._lastActId

	local configList = VersionActivityConfig.instance:getAct112Config(actId)
	local list = {}

	for i, v in ipairs(configList) do
		table.insert(list, v)
	end

	return list
end

VersionActivity112Model.instance = VersionActivity112Model.New()

return VersionActivity112Model
