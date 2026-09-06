-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collecttangyuan/model/CollectTangyuanModel.lua

module("logic.extensions.collecttangyuan.model.CollectTangyuanModel", package.seeall)

local CollectTangyuanModel = class("CollectTangyuanModel", BaseModel)

function CollectTangyuanModel:ctor()
	return
end

function CollectTangyuanModel:onInit()
	self:onReset()
end

function CollectTangyuanModel:onReset()
	self._taskInfo = {}
end

function CollectTangyuanModel:getTaskInfo()
	return self._taskInfo
end

function CollectTangyuanModel:setActivityIdAndPlanId(activityId, planId)
	self._taskInfo.activityId = activityId
	self._taskInfo.planId = planId
end

function CollectTangyuanModel:setTaskInfos(taskInfos)
	self._taskInfo.taskInfos = taskInfos
end

CollectTangyuanModel.instance = CollectTangyuanModel.New()

return CollectTangyuanModel
