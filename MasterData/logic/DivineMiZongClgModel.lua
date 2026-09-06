-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemizongclg/model/DivineMiZongClgModel.lua

module("logic.extensions.divinemizongclg.model.DivineMiZongClgModel", package.seeall)

local DivineMiZongClgModel = class("DivineMiZongClgModel", BaseModel)

function DivineMiZongClgModel:onInit()
	self:onReset()
end

function DivineMiZongClgModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._clgFmtMo = nil
end

function DivineMiZongClgModel:getClgMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = DivineMiZongClgMo.New(activityId)
	end

	return self._moPool[activityId]
end

function DivineMiZongClgModel:getClgFmtMo()
	if self._clgFmtMo == nil then
		self._clgFmtMo = DivineMiZongClgFmtMo.New()
	end

	return self._clgFmtMo
end

DivineMiZongClgModel.instance = DivineMiZongClgModel.New()

return DivineMiZongClgModel
