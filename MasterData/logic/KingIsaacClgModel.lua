-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingisaacclg/model/KingIsaacClgModel.lua

module("logic.extensions.kingisaacclg.model.KingIsaacClgModel", package.seeall)

local KingIsaacClgModel = class("KingIsaacClgModel", BaseModel)

function KingIsaacClgModel:ctor()
	return
end

function KingIsaacClgModel:onInit()
	self:onReset()
end

function KingIsaacClgModel:onReset()
	self._kicDataPool = self._kicDataPool or {}

	table.clear(self._kicDataPool)

	self._customFmtMoPool = self._customFmtMoPool or {}

	table.clear(self._customFmtMoPool)
end

function KingIsaacClgModel:getKicData(activityId)
	if self._kicDataPool[activityId] == nil then
		self._kicDataPool[activityId] = KingIsaacClgData.New(activityId)
	end

	return self._kicDataPool[activityId]
end

function KingIsaacClgModel:getKicCustomFmtMo(activityId)
	if self._customFmtMoPool[activityId] == nil then
		self._customFmtMoPool[activityId] = KingIsaacClgCustomFmtMo.New()
	end

	return self._customFmtMoPool[activityId]
end

KingIsaacClgModel.instance = KingIsaacClgModel.New()

return KingIsaacClgModel
