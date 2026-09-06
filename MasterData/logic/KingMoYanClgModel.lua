-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmoyanclg/model/KingMoYanClgModel.lua

module("logic.extensions.kingmoyanclg.model.KingMoYanClgModel", package.seeall)

local KingMoYanClgModel = class("KingMoYanClgModel", BaseModel)

function KingMoYanClgModel:ctor()
	return
end

function KingMoYanClgModel:onInit()
	self:onReset()
end

function KingMoYanClgModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._customFmtMo = nil
end

function KingMoYanClgModel:getKingMoYanClgMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = KingMoYanClgMo.New(activityId)
	end

	return self._moPool[activityId]
end

function KingMoYanClgModel:getKingMoYanClgFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = KingMoYanClgFmtMo.New()
	end

	return self._customFmtMo
end

KingMoYanClgModel.instance = KingMoYanClgModel.New()

return KingMoYanClgModel
