-- chunkname: @modules/logic/versionactivity3_1/towerdeep/model/TowerDeepOperActModel.lua

module("modules.logic.versionactivity3_1.towerdeep.model.TowerDeepOperActModel", package.seeall)

local TowerDeepOperActModel = class("TowerDeepOperActModel", BaseModel)

function TowerDeepOperActModel:onInit()
	self:reInit()
end

function TowerDeepOperActModel:reInit()
	self._maxLayer = 0
end

function TowerDeepOperActModel:setMaxLayer(layer)
	self._maxLayer = layer
end

function TowerDeepOperActModel:getMaxLayer()
	return self._maxLayer
end

function TowerDeepOperActModel:isTaskFinished(taskId)
	local taskMo = TaskModel.instance:getTaskById(taskId)

	return taskMo and taskMo.finishCount > 0
end

function TowerDeepOperActModel:getNextTaskId(taskId)
	local taskCos = TowerDeepOperActConfig.instance:getTaskCos()

	for _, taskCo in pairs(taskCos) do
		if not LuaUtil.isEmptyStr(taskCo.prepose) and taskId == tonumber(taskCo.prepose) then
			return taskCo.id
		end
	end

	return 0
end

TowerDeepOperActModel.instance = TowerDeepOperActModel.New()

return TowerDeepOperActModel
