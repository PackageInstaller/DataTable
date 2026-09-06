-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/iceqibugame/model/IceQibuGameModel.lua

module("logic.extensions.iceqibugame.model.IceQibuGameModel", package.seeall)

local IceQibuGameModel = class("IceQibuGameModel", BaseModel)

function IceQibuGameModel:onInit()
	self:onReset()
end

function IceQibuGameModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end
end

function IceQibuGameModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = IceQibuGameSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

IceQibuGameModel.instance = IceQibuGameModel.New()

return IceQibuGameModel
