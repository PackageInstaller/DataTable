-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/parallelkingdragon/model/ParallelkingdragonModel.lua

module("logic.extensions.parallelkingdragon.view.ParallelkingdragonModel", package.seeall)

local ParallelkingdragonModel = class("ParallelkingdragonModel", BaseModel)

function ParallelkingdragonModel:ctor()
	return
end

function ParallelkingdragonModel:onInit()
	self:onReset()
end

function ParallelkingdragonModel:onReset()
	self._msgInfos = {}
	self._fmtMo = nil
end

function ParallelkingdragonModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)
end

function ParallelkingdragonModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function ParallelkingdragonModel:getFmtMo()
	self._fmtMo = self._fmtMo or ParallelkingdragonFmtMo.New()

	return self._fmtMo
end

function ParallelkingdragonModel:updateMaxPassStageId(activityId, stageId)
	local info = self:getInfo(activityId)

	info.maxPassStageId = math.max(info.maxPassStageId, stageId)
end

ParallelkingdragonModel.instance = ParallelkingdragonModel.New()

return ParallelkingdragonModel
