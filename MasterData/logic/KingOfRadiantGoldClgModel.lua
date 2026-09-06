-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingofradiantgoldclg/model/KingOfRadiantGoldClgModel.lua

module("logic.extensions.kingofradiantgoldclg.model.KingOfRadiantGoldClgModel", package.seeall)

local KingOfRadiantGoldClgModel = class("KingOfRadiantGoldClgModel", BaseModel)

function KingOfRadiantGoldClgModel:onInit()
	self:onReset()
end

function KingOfRadiantGoldClgModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._fmtMo = nil
end

function KingOfRadiantGoldClgModel:getClgMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = KingOfRadiantGoldClgMo.New(activityId)
	end

	return self._moPool[activityId]
end

function KingOfRadiantGoldClgModel:getFmtMo()
	if self._fmtMo == nil then
		self._fmtMo = KingOfRadiantGoldClgFmtMo.New()
	end

	return self._fmtMo
end

KingOfRadiantGoldClgModel.instance = KingOfRadiantGoldClgModel.New()

return KingOfRadiantGoldClgModel
