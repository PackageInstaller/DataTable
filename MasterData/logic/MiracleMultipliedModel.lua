-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclemultiplied/model/MiracleMultipliedModel.lua

module("logic.extensions.miraclemultiplied.model.MiracleMultipliedModel", package.seeall)

local MiracleMultipliedModel = class("MiracleMultipliedModel", BaseModel)

function MiracleMultipliedModel:ctor()
	return
end

function MiracleMultipliedModel:onInit()
	self:onReset()
end

function MiracleMultipliedModel:onReset()
	self._moPool = {}
end

function MiracleMultipliedModel:getMiracleMultipliedMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = MiracleMultipliedMo.New(activityId)
	end

	return self._moPool[activityId]
end

MiracleMultipliedModel.instance = MiracleMultipliedModel.New()

return MiracleMultipliedModel
