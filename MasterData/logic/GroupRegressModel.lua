-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupregress/model/GroupRegressModel.lua

module("logic.extensions.groupregress.model.GroupRegressModel", package.seeall)

local GroupRegressModel = class("GroupRegressModel", BaseModel)

function GroupRegressModel:onInit()
	self:onReset()
end

function GroupRegressModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end
end

function GroupRegressModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = GroupRegressSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

GroupRegressModel.instance = GroupRegressModel.New()

return GroupRegressModel
