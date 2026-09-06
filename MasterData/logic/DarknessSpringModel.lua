-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darknessspring/model/DarknessSpringModel.lua

module("logic.extensions.darknessspring.model.DarknessSpringModel", package.seeall)

local DarknessSpringModel = class("DarknessSpringModel", BaseModel)

function DarknessSpringModel:onInit()
	self:onReset()
end

function DarknessSpringModel:onReset()
	self._info = {}
end

function DarknessSpringModel:onDarknessSpringGetInfoRes(msg)
	local pb = GameUtil.pbToTable(msg)

	self._info[pb.activityId] = pb
end

function DarknessSpringModel:getActivityInfo(activityId)
	if self._info and self._info[activityId] then
		return self._info[activityId]
	end

	return nil
end

DarknessSpringModel.instance = DarknessSpringModel.New()

return DarknessSpringModel
