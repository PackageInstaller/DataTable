-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoddragonclg/model/OriginGodDragonClgModel.lua

module("logic.extensions.origingoddragonclg.model.OriginGodDragonClgModel", package.seeall)

local OriginGodDragonClgModel = class("OriginGodDragonClgModel", BaseModel)

function OriginGodDragonClgModel:onInit()
	self:onReset()
end

function OriginGodDragonClgModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._fmtMoPool = {}
end

function OriginGodDragonClgModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = OriginGodDragonClgSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

function OriginGodDragonClgModel:getFmtMo(activityId)
	if self._fmtMoPool[activityId] == nil then
		self._fmtMoPool[activityId] = OriginGodDragonClgFmtMo.New()
	end

	return self._fmtMoPool[activityId]
end

OriginGodDragonClgModel.instance = OriginGodDragonClgModel.New()

return OriginGodDragonClgModel
