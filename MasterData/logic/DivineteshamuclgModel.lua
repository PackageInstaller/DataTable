-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineteshamuclg/model/DivineteshamuclgModel.lua

module("logic.extensions.divineteshamuclg.view.DivineteshamuclgModel", package.seeall)

local DivineteshamuclgModel = class("DivineteshamuclgModel", BaseModel)

function DivineteshamuclgModel:ctor()
	return
end

function DivineteshamuclgModel:onInit()
	self:onReset()
end

function DivineteshamuclgModel:onReset()
	self._msgInfos = {}
	self._fmtMo = nil
end

function DivineteshamuclgModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)

	for i, v in ipairs(self._msgInfos[msg.activityId].divineTeshamuFloorInfos) do
		v.passStages = v.passStages or {}
	end
end

function DivineteshamuclgModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function DivineteshamuclgModel:onResetFloor(activityId, floorId)
	local info = self:getInfo(activityId)
	local prizeCfgs = DivineteshamuclgConfig.instance:getPrizeCfgs(activityId)

	for i, v in ipairs(info.divineTeshamuFloorInfos) do
		if v.floorId == floorId then
			v.curStageId = 1
			v.soldierNum = 0
			v.lastAlivePetNum = 0
			v.lastDeadPetNUm = 0
			v.passStages = {}

			if floorId ~= #prizeCfgs then
				v.isFirstPass = false
			end
		end
	end
end

function DivineteshamuclgModel:getFmtMo()
	self._fmtMo = self._fmtMo or DivineteshamuclgFmtMo.New()

	return self._fmtMo
end

function DivineteshamuclgModel:onAdvanceRes(msg)
	local info = self:getInfo(msg.activityId)

	for i, v in ipairs(info.divineTeshamuFloorInfos) do
		if v.floorId == msg.floorId then
			v.curStageId = msg.stageId

			break
		end
	end
end

function DivineteshamuclgModel:getSoldierCount(activityId, floorId)
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.divineTeshamuFloorInfos) do
		if v.floorId == floorId then
			return v.soldierNum
		end
	end

	return 0
end

function DivineteshamuclgModel:isStagePass(activityId, floorId, stageId)
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.divineTeshamuFloorInfos) do
		if v.floorId == floorId then
			return table.indexof(v.passStages, stageId)
		end
	end

	return false
end

function DivineteshamuclgModel:hasStagePass(activityId, floorId)
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.divineTeshamuFloorInfos) do
		if v.floorId == floorId then
			return #v.passStages > 0
		end
	end

	return false
end

DivineteshamuclgModel.instance = DivineteshamuclgModel.New()

return DivineteshamuclgModel
