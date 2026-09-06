-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petrelation/view/PetrelationViewPresentor.lua

module("logic.extensions.petrelation.view.PetrelationViewPresentor", package.seeall)

local PetrelationViewPresentor = class("PetrelationViewPresentor", ViewPresentor)

function PetrelationViewPresentor:ctor()
	PetrelationViewPresentor.super.ctor(self)
end

function PetrelationViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PetrelationViewPresentor:dependWhatResources()
	local tempPath = {}

	table.insert(tempPath, "ui/views/petrelation/petrelationview.prefab")

	local type = tonumber(self:getFirstParam()) or 1

	for i, v in ipairs(PetRelationModel.instance:getUrl(type, 640 / tonumber(PetRelationConfig.instance:getCommonValue("DEFAULT_SCALE")))) do
		table.insert(tempPath, v)
	end

	return tempPath
end

function PetrelationViewPresentor:buildViews()
	return {
		PetrelationView.New()
	}
end

return PetrelationViewPresentor
