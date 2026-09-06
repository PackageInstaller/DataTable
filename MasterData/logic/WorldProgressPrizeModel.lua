-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldprogressprize/model/WorldProgressPrizeModel.lua

module("logic.extensions.worldprogressprize.model.WorldProgressPrizeModel", package.seeall)

local WorldProgressPrizeModel = class("WorldProgressPrizeModel", BaseModel)

function WorldProgressPrizeModel:onInit()
	self:onReset()
end

function WorldProgressPrizeModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end
end

function WorldProgressPrizeModel:getWorldProgressPrizeMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = WorldProgressPrizeMo.New(activityId)
	end

	return self._moPool[activityId]
end

WorldProgressPrizeModel.instance = WorldProgressPrizeModel.New()

return WorldProgressPrizeModel
