-- chunkname: @modules/logic/explore/model/ExploreRewardModel.lua

module("modules.logic.explore.model.ExploreRewardModel", package.seeall)

local ExploreRewardModel = class("ExploreRewardModel", ListScrollModel)

function ExploreRewardModel:test()
	self:setList({
		{},
		{},
		{},
		{},
		{},
		{},
		{}
	})
end

ExploreRewardModel.instance = ExploreRewardModel.New()

return ExploreRewardModel
