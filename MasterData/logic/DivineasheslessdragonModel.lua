-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineasheslessdragon/model/DivineasheslessdragonModel.lua

module("logic.extensions.divineasheslessdragon.view.DivineasheslessdragonModel", package.seeall)

local DivineasheslessdragonModel = class("DivineasheslessdragonModel", BaseModel)

function DivineasheslessdragonModel:ctor()
	return
end

function DivineasheslessdragonModel:onInit()
	self:onReset()
end

function DivineasheslessdragonModel:onReset()
	self._msgInfos = {}
	self._activityId = 0
end

function DivineasheslessdragonModel:setInfo(msg)
	self._msgInfos[msg.activityId] = msg.passedStageId
end

function DivineasheslessdragonModel:getPassedStageId(activityId)
	return self._msgInfos[activityId] or 0
end

function DivineasheslessdragonModel:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = DivineasheslessdragonCustomFmtMo.New()
	end

	return self._customFmtMo
end

function DivineasheslessdragonModel:setActivityId(activityId)
	self._activityId = activityId
end

function DivineasheslessdragonModel:getActivityId()
	return self._activityId
end

DivineasheslessdragonModel.instance = DivineasheslessdragonModel.New()

return DivineasheslessdragonModel
