-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idiomchain/model/IdiomChainModel.lua

module("logic.extensions.idiomchain.model.IdiomChainModel", package.seeall)

local IdiomChainModel = class("IdiomChainModel", BaseModel)

function IdiomChainModel:onInit()
	self:onReset()
end

function IdiomChainModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end
end

function IdiomChainModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = IdiomChainSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

IdiomChainModel.instance = IdiomChainModel.New()

return IdiomChainModel
