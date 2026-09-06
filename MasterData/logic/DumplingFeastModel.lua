-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dumplingfeast/model/DumplingFeastModel.lua

module("logic.extensions.dumplingfeast.model.DumplingFeastModel", package.seeall)

local DumplingFeastModel = class("DumplingFeastModel", BaseModel)

function DumplingFeastModel:onInit()
	self:onReset()
end

function DumplingFeastModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._fmtMoPool = {}
end

function DumplingFeastModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = DumplingFeastSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

function DumplingFeastModel:getFmtMo(activityId)
	if self._fmtMoPool[activityId] == nil then
		self._fmtMoPool[activityId] = DumplingFeastBossFmtMo.New()
	end

	return self._fmtMoPool[activityId]
end

DumplingFeastModel.instance = DumplingFeastModel.New()

return DumplingFeastModel
