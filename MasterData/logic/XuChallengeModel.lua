-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xuchallenge/model/XuChallengeModel.lua

module("logic.extensions.xuchallenge.model.XuChallengeModel", package.seeall)

local XuChallengeModel = class("XuChallengeModel", BaseModel)

function XuChallengeModel:onInit()
	self:onReset()
end

function XuChallengeModel:onReset()
	self._moPool = self._moPool or {}

	for activityId, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[activityId] = nil
	end
end

function XuChallengeModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = XuChallengeSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

XuChallengeModel.instance = XuChallengeModel.New()

return XuChallengeModel
