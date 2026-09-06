-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rolerelationship/view/RoleRelationshipViewPresentor.lua

module("logic.extensions.scenariocopy.view.rolerelationship.RoleRelationshipViewPresentor", package.seeall)

local RoleRelationshipViewPresentor = class("RoleRelationshipViewPresentor", ViewPresentor)

function RoleRelationshipViewPresentor:ctor()
	RoleRelationshipViewPresentor.super.ctor(self)
end

function RoleRelationshipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RoleRelationshipViewPresentor:dependWhatResources()
	return {
		"ui/views/rolerelationship/rolerelationshipview.prefab"
	}
end

function RoleRelationshipViewPresentor:buildViews()
	return {
		RoleRelationshipView.New()
	}
end

return RoleRelationshipViewPresentor
