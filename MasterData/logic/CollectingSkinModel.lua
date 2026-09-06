-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectingskin/model/CollectingSkinModel.lua

module("logic.extensions.collectingskin.model.CollectingSkinModel", package.seeall)

local CollectingSkinModel = class("CollectingSkinModel", BaseModel)

function CollectingSkinModel:onInit()
	self:onReset()
end

function CollectingSkinModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._posterMsgPool = {}
end

function CollectingSkinModel:onGetPosterMsg(msg)
	local pb = GameUtil.pbToTable(msg) or {}

	self._posterMsgPool[pb.activityId] = pb
end

function CollectingSkinModel:onGainPosterMsg(msg)
	local info = self._posterMsgPool[msg.activityId]

	if info then
		info.hasGain = msg.gainSuc
		info.spaceGainCount = msg.spaceGainCount
	end
end

function CollectingSkinModel:getPosterInfo(activityId)
	return self._posterMsgPool[activityId]
end

function CollectingSkinModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = CollectingSkinSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

CollectingSkinModel.instance = CollectingSkinModel.New()

return CollectingSkinModel
