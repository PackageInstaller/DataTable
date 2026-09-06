-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefuyaoclg/model/DivineFuYaoClgModel.lua

module("logic.extensions.divinefuyaoclg.model.DivineFuYaoClgModel", package.seeall)

local DivineFuYaoClgModel = class("DivineFuYaoClgModel", BaseModel)

function DivineFuYaoClgModel:onInit()
	self:onReset()
end

function DivineFuYaoClgModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._norFmtMo = nil
	self._extFmtMo = nil
end

function DivineFuYaoClgModel:getSubMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = DivineFuYaoClgSubMo.New(activityId)
	end

	return self._moPool[activityId]
end

function DivineFuYaoClgModel:getNormalFmtMo()
	if self._norFmtMo == nil then
		self._norFmtMo = DivineFuYaoClgNormalFmtMo.New()
	end

	return self._norFmtMo
end

function DivineFuYaoClgModel:getExtremeFmtMo()
	if self._extFmtMo == nil then
		self._extFmtMo = DivineFuYaoClgExtremeFmtMo.New()
	end

	return self._extFmtMo
end

DivineFuYaoClgModel.instance = DivineFuYaoClgModel.New()

return DivineFuYaoClgModel
