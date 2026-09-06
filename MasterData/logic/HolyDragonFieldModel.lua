-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/model/HolyDragonFieldModel.lua

module("logic.extensions.holydragonfield.model.HolyDragonFieldModel", package.seeall)

local HolyDragonFieldModel = class("HolyDragonFieldModel", BaseModel)

function HolyDragonFieldModel:onInit()
	self:onReset()
end

function HolyDragonFieldModel:onReset()
	self._moPool = self._moPool or {}
	self._fmtMoPool = self._fmtMoPool or {}

	for activityId, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[activityId] = nil
	end

	for activityId, _ in pairs(self._fmtMoPool) do
		self._fmtMoPool[activityId] = nil
	end
end

function HolyDragonFieldModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = HolyDragonFieldSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

function HolyDragonFieldModel:getFmtMo(activityId)
	activityId = checknumber(activityId)

	if self._fmtMoPool[activityId] == nil then
		self._fmtMoPool[activityId] = HolyDragonFieldFmtMo.New()
	end

	return self._fmtMoPool[activityId]
end

HolyDragonFieldModel.instance = HolyDragonFieldModel.New()

return HolyDragonFieldModel
