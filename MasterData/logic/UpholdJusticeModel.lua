-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/upholdjustice/model/UpholdJusticeModel.lua

module("logic.extensions.upholdjustice.model.UpholdJusticeModel", package.seeall)

local UpholdJusticeModel = class("UpholdJusticeModel", BaseModel)

function UpholdJusticeModel:onInit()
	self:onReset()
end

function UpholdJusticeModel:onReset()
	self._infoMap = {}
	self._rankInfoMap = {}
end

function UpholdJusticeModel:onGetInfo(msg)
	local pb = GameUtil.pbToTable(msg)

	self._infoMap[pb.activityId] = pb
end

function UpholdJusticeModel:getInfo(activityId)
	return self._infoMap[activityId]
end

function UpholdJusticeModel:onGetRankInfo(msg)
	local pb = GameUtil.pbToTable(msg)

	self._rankInfoMap[pb.activityId] = pb
end

function UpholdJusticeModel:getRankInfo(activityId)
	return self._rankInfoMap[activityId]
end

function UpholdJusticeModel:onDonateOrGain(msg)
	return
end

UpholdJusticeModel.instance = UpholdJusticeModel.New()

return UpholdJusticeModel
