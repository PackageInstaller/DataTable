-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiunuo/model/DivineXiuNuoModel.lua

module("logic.extensions.divinexiunuo.model.DivineXiuNuoModel", package.seeall)

local DivineXiuNuoModel = class("DivineXiuNuoModel", BaseModel)

function DivineXiuNuoModel:onInit()
	self:onReset()
end

function DivineXiuNuoModel:onReset()
	self._msgPool = {}
	self._fightPbMap = {}
end

function DivineXiuNuoModel:onGetInfo(msg)
	self._msgPool[msg.activityId] = GameUtil.pbToTable(msg)
end

function DivineXiuNuoModel:getInfo(activityId)
	return self._msgPool[activityId]
end

function DivineXiuNuoModel:handleFightRes(msg)
	local pb = GameUtil.pbToTable(msg)

	self._fightPbMap[msg.activityId] = pb

	if pb.passPhase then
		local info = self:getInfo(msg.activityId)

		info.curPhaseId = checknumber(info.curPhaseId) + 1
		info.stageInfo = {}
	end
end

function DivineXiuNuoModel:onResetStage(msg)
	local pb = GameUtil.pbToTable(msg)
	local info = self._msgPool[msg.activityId]

	for k, v in pairs(info.stageInfo or {}) do
		if v.stageId == pb.stageId then
			info.stageInfo[k] = nil

			break
		end
	end
end

function DivineXiuNuoModel:getFightPb(activityId)
	return self._fightPbMap[activityId]
end

DivineXiuNuoModel.instance = DivineXiuNuoModel.New()

return DivineXiuNuoModel
