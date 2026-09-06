-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/snowmancar/model/SnowManCarModel.lua

module("logic.extensions.snowmancar.model.SnowManCarModel", package.seeall)

local SnowManCarModel = class("SnowManCarModel", BaseModel)

function SnowManCarModel:onInit()
	self:onReset()
end

function SnowManCarModel:onReset()
	self._activityInfo = {}
	self._serverKey = {}
end

function SnowManCarModel:onSnowmanCarInfoRes(msg)
	local pb = GameUtil.pbToTable(msg)

	self._activityInfo[pb.activityId] = pb
end

function SnowManCarModel:onSnowmanCarStartRes(msg)
	local pb = GameUtil.pbToTable(msg)

	self._serverKey[pb.activityId] = pb.serverKey
end

function SnowManCarModel:getActivityInfo(activityId)
	if self._activityInfo and self._activityInfo[activityId] then
		return self._activityInfo[activityId]
	end

	return nil
end

function SnowManCarModel:getServerKey(activityId)
	if self._serverKey and self._serverKey[activityId] then
		return self._serverKey[activityId]
	end

	return 0
end

SnowManCarModel.instance = SnowManCarModel.New()

return SnowManCarModel
