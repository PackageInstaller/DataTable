-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuanlonghuangnuoya/model/CiyuanlonghuangnuoyaModel.lua

module("logic.extensions.ciyuanlonghuangnuoya.model.CiyuanlonghuangnuoyaModel", package.seeall)

local CiyuanlonghuangnuoyaModel = class("CiyuanlonghuangnuoyaModel", BaseModel)

function CiyuanlonghuangnuoyaModel:onInit()
	self:onReset()
end

function CiyuanlonghuangnuoyaModel:onReset()
	self._msgPool = {}
	self._fightPbMap = {}
end

function CiyuanlonghuangnuoyaModel:onGetInfo(msg)
	self._msgPool[msg.activityId] = GameUtil.pbToTable(msg)
end

function CiyuanlonghuangnuoyaModel:getInfo(activityId)
	return self._msgPool[activityId]
end

function CiyuanlonghuangnuoyaModel:onResetStage(msg)
	local pb = GameUtil.pbToTable(msg)
	local info = self._msgPool[msg.activityId]

	for k, v in pairs(info.stageInfo or {}) do
		if v.stageId == pb.stageId then
			info.stageInfo[k] = nil

			break
		end
	end
end

function CiyuanlonghuangnuoyaModel:handleFightRes(msg)
	local pb = GameUtil.pbToTable(msg)

	self._fightPbMap[msg.activityId] = pb

	if pb.passPhase then
		local info = self:getInfo(msg.activityId)

		info.curPhaseId = checknumber(info.curPhaseId) + 1
		info.stageInfo = {}
	end
end

function CiyuanlonghuangnuoyaModel:onConfirm(msg)
	local pb = GameUtil.pbToTable(msg)

	if pb.passPhase then
		local info = self:getInfo(msg.activityId)

		info.curPhaseId = checknumber(info.curPhaseId) + 1
		info.stageInfo = {}
	end
end

function CiyuanlonghuangnuoyaModel:getFightPb(activityId)
	return self._fightPbMap[activityId]
end

CiyuanlonghuangnuoyaModel.instance = CiyuanlonghuangnuoyaModel.New()

return CiyuanlonghuangnuoyaModel
