-- chunkname: @modules/logic/versionactivity1_2/jiexika/model/Activity114FeaturesModel.lua

module("modules.logic.versionactivity1_2.jiexika.model.Activity114FeaturesModel", package.seeall)

local Activity114FeaturesModel = class("Activity114FeaturesModel", ListScrollModel)

function Activity114FeaturesModel:onFeatureListUpdate(featureList)
	local list = {}

	for i = 1, #featureList do
		list[i] = Activity114Config.instance:getFeatureCo(Activity114Model.instance.id, featureList[i])
	end

	self:setList(list)
end

Activity114FeaturesModel.instance = Activity114FeaturesModel.New()

return Activity114FeaturesModel
