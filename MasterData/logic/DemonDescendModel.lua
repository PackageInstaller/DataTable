-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/demondescend/model/DemonDescendModel.lua

module("logic.extensions.demondescend.model.DemonDescendModel", package.seeall)

local DemonDescendModel = class("DemonDescendModel", BaseModel)

function DemonDescendModel:onInit()
	self:onReset()
end

function DemonDescendModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._stageFmtMo = nil
	self._bossFmtMo = nil
end

function DemonDescendModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = DemonDescendSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

function DemonDescendModel:getStageFmtMo()
	if self._stageFmtMo == nil then
		self._stageFmtMo = DemonDescendStageFmtMo.New()
	end

	return self._stageFmtMo
end

function DemonDescendModel:getBossFmtMo()
	if self._bossFmtMo == nil then
		self._bossFmtMo = DemonDescendBossFmtMo.New()
	end

	return self._bossFmtMo
end

DemonDescendModel.instance = DemonDescendModel.New()

return DemonDescendModel
