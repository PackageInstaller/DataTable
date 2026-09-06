-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hexlineup/model/HexLineupModel.lua

module("logic.extensions.hexlineup.model.HexLineupModel", package.seeall)

local HexLineupModel = class("HexLineupModel", BaseModel)

function HexLineupModel:onInit()
	self:onReset()
end

function HexLineupModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end
end

function HexLineupModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = HexLineupSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

HexLineupModel.instance = HexLineupModel.New()

return HexLineupModel
