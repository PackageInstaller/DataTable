-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wandererpass/model/WandererpassModel.lua

module("logic.extensions.wandererpass.model.WandererpassModel", package.seeall)

local WandererpassModel = class("WandererpassModel", BaseModel)

function WandererpassModel:onInit()
	self:onReset()
end

function WandererpassModel:onReset()
	self._msgPool = {}
end

function WandererpassModel:onGetInfo(msg)
	local pb = GameUtil.pbToTable(msg)

	self._msgPool[pb.activityId] = pb
end

function WandererpassModel:getInfo(activityId)
	return self._msgPool[activityId]
end

function WandererpassModel:setInfoHasGain(activityId)
	self._msgPool[activityId] = self._msgPool[activityId] or {}

	local info = self._msgPool[activityId]

	if info then
		info.hasBuy = true
	end
end

WandererpassModel.instance = WandererpassModel.New()

return WandererpassModel
