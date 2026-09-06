-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailonghotsearch/model/NaiLongHotSearchModel.lua

module("logic.extensions.nailonghotsearch.model.NaiLongHotSearchModel", package.seeall)

local NaiLongHotSearchModel = class("NaiLongHotSearchModel", BaseModel)

function NaiLongHotSearchModel:onInit()
	self:onReset()
end

function NaiLongHotSearchModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end
end

function NaiLongHotSearchModel:getNaiLongHotSearchMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = NaiLongHotSearchMo.New(activityId)
	end

	return self._moPool[activityId]
end

NaiLongHotSearchModel.instance = NaiLongHotSearchModel.New()

return NaiLongHotSearchModel
