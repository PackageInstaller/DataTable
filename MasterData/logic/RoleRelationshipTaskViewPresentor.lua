-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rolerelationship/view/RoleRelationshipTaskViewPresentor.lua

module("logic.extensions.scenariocopy.view.rolerelationship.RoleRelationshipTaskViewPresentor", package.seeall)

local RoleRelationshipTaskViewPresentor = class("RoleRelationshipTaskViewPresentor", ViewPresentor)

function RoleRelationshipTaskViewPresentor:ctor()
	RoleRelationshipTaskViewPresentor.super.ctor(self)
end

function RoleRelationshipTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RoleRelationshipTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/rolerelationship/rolerelationshiptaskview.prefab"
	}
end

function RoleRelationshipTaskViewPresentor:buildViews()
	return {
		RoleRelationshipTaskView.New()
	}
end

return RoleRelationshipTaskViewPresentor
