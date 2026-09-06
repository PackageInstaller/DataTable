-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/growup/model/GrowUpRoadModel.lua

module("logic.extensions.growup.model.GrowUpRoadModel", package.seeall)

local GrowUpRoadModel = class("GrowUpRoadModel", BaseModel)

function GrowUpRoadModel:setHasGainPet(activityId, hasGainPet)
	self._hasGainPet = self._hasGainPet or {}
	self._hasGainPet[activityId] = hasGainPet
end

function GrowUpRoadModel:getHasGainPet(activityId)
	return self._hasGainPet[activityId]
end

function GrowUpRoadModel:setTaskInfo(taskInfo)
	self._taskInfo = {}

	for i, v in ipairs(taskInfo) do
		self._taskInfo[v.taskId] = {
			curProcess = v.curProcess,
			hasGainPrize = v.hasGainPrize
		}
	end
end

function GrowUpRoadModel:gainTaskPrizeById(id)
	self._taskInfo[id].hasGainPrize = true
end

function GrowUpRoadModel:getTaskInfoById(id)
	if self._taskInfo[id] == nil then
		self._taskInfo[id] = {
			hasGainPrize = false,
			curProcess = 0
		}
	end

	return self._taskInfo[id]
end

function GrowUpRoadModel:setCurId(curId)
	self._curStrengthenType = curId
end

function GrowUpRoadModel:getCurStrengthenType()
	return self._curStrengthenType
end

GrowUpRoadModel.instance = GrowUpRoadModel.New()

return GrowUpRoadModel
