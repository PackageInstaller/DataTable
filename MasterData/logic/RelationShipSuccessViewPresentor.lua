-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rolerelationship/view/RelationShipSuccessViewPresentor.lua

module("logic.extensions.scenariocopy.view.rolerelationship.RelationShipSuccessViewPresentor", package.seeall)

local RelationShipSuccessViewPresentor = class("RelationShipSuccessViewPresentor", ViewPresentor)

function RelationShipSuccessViewPresentor:ctor()
	RelationShipSuccessViewPresentor.super.ctor(self)
end

function RelationShipSuccessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RelationShipSuccessViewPresentor:dependWhatResources()
	return {
		"ui/views/rolerelationship/relationshipsuccessview.prefab"
	}
end

function RelationShipSuccessViewPresentor:buildViews()
	return {
		RelationShipSuccessView.New()
	}
end

return RelationShipSuccessViewPresentor
