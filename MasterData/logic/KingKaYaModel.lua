-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingkaya/model/KingKaYaModel.lua

module("logic.extensions.kingkaya.model.KingKaYaModel", package.seeall)

local KingKaYaModel = class("KingKaYaModel", BaseModel)

function KingKaYaModel:ctor()
	return
end

function KingKaYaModel:onInit()
	self:onReset()
end

function KingKaYaModel:onReset()
	self._moPool = self._moPool or {}

	table.clear(self._moPool)

	self._norCustomFmtMoPool = self._norCustomFmtMoPool or {}

	table.clear(self._norCustomFmtMoPool)

	self._extCustomFmtMoPool = self._extCustomFmtMoPool or {}

	table.clear(self._extCustomFmtMoPool)
end

function KingKaYaModel:getKingKaYaMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = KingKaYaMo.New(activityId)
	end

	return self._moPool[activityId]
end

function KingKaYaModel:getNorCustomFmtMo(activityId)
	if self._norCustomFmtMoPool[activityId] == nil then
		self._norCustomFmtMoPool[activityId] = KingKaYaNorCustomFmtMo.New()
	end

	return self._norCustomFmtMoPool[activityId]
end

function KingKaYaModel:getExtCustomFmtMo(activityId)
	if self._extCustomFmtMoPool[activityId] == nil then
		self._extCustomFmtMoPool[activityId] = KingKaYaExtCustomFmtMo.New()
	end

	return self._extCustomFmtMoPool[activityId]
end

KingKaYaModel.instance = KingKaYaModel.New()

return KingKaYaModel
