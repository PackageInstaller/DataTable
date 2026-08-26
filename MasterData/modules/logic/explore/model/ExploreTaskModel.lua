-- chunkname: @modules/logic/explore/model/ExploreTaskModel.lua

module("modules.logic.explore.model.ExploreTaskModel", package.seeall)

local ExploreTaskModel = class("ExploreTaskModel", BaseModel)

function ExploreTaskModel:ctor()
	self._models = {}
end

function ExploreTaskModel:getTaskList(collectType)
	self._models[collectType] = self._models[collectType] or ListScrollModel.New()

	return self._models[collectType]
end

ExploreTaskModel.instance = ExploreTaskModel.New()

return ExploreTaskModel
