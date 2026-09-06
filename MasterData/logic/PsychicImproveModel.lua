-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicimprove/model/PsychicImproveModel.lua

module("logic.extensions.psychicimprove.model.PsychicImproveModel", package.seeall)

local PsychicImproveModel = class("PsychicImproveModel", BaseModel)

function PsychicImproveModel:onInit()
	self:onReset()
end

function PsychicImproveModel:onReset()
	self._curActId = 0
	self._curCoolingTime = 0
	self._hasHidePetIds = nil
	self._lastOpenId = 0
end

function PsychicImproveModel:onGetInfo(msg)
	self._curActId = checkint(msg.activityId)
	self._curCoolingTime = checkint(msg.coolingTime)
	self._hasHidePetIds = {}

	for i, v in ipairs(msg.hasHiredPetIds) do
		self._hasHidePetIds[checkint(v)] = true
	end
end

function PsychicImproveModel:onHidePet(msg)
	self._curCoolingTime = checkint(msg.coolingTime)
	self._hasHidePetIds = self._hasHidePetIds or {}
	self._hasHidePetIds[checkint(msg.hireId)] = true
end

function PsychicImproveModel:setLastOpenId(id)
	self._lastOpenId = checkint(id)
end

function PsychicImproveModel:getLastOpenId()
	return self._lastOpenId
end

function PsychicImproveModel:getCurActId()
	return self._curActId
end

function PsychicImproveModel:getCurHidePetIds()
	return self._hasHidePetIds or {}
end

function PsychicImproveModel:getCurCoolingTime()
	return self._curCoolingTime
end

PsychicImproveModel.instance = PsychicImproveModel.New()

return PsychicImproveModel
