-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originwelfare/model/OriginWelfareModel.lua

module("logic.extensions.originwelfare.model.OriginWelfareModel", package.seeall)

local OriginWelfareModel = class("OriginWelfareModel", BaseModel)

function OriginWelfareModel:ctor()
	return
end

function OriginWelfareModel:onInit()
	self:onReset()
end

function OriginWelfareModel:onReset()
	self._infos = {}
end

function OriginWelfareModel:getInfo(activityId)
	return self._infos[activityId]
end

function OriginWelfareModel:handlePM_OriginWelfareInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)
end

function OriginWelfareModel:handlePM_OriginWelfareLightUpRes(msg)
	local info = self._infos[msg.activityId]

	info.hasLightUp = msg.hasLightUp
end

OriginWelfareModel.instance = OriginWelfareModel.New()

return OriginWelfareModel
