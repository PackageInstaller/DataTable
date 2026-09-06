-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rolerelationship/view/RoleRelationshipArchiveViewPresentor.lua

module("logic.extensions.scenariocopy.view.rolerelationship.RoleRelationshipArchiveViewPresentor", package.seeall)

local RoleRelationshipArchiveViewPresentor = class("RoleRelationshipArchiveViewPresentor", ViewPresentor)

function RoleRelationshipArchiveViewPresentor:ctor()
	RoleRelationshipArchiveViewPresentor.super.ctor(self)
end

function RoleRelationshipArchiveViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RoleRelationshipArchiveViewPresentor:dependWhatResources()
	return {
		"ui/views/rolerelationship/rolerelationshiparchiveview.prefab"
	}
end

function RoleRelationshipArchiveViewPresentor:buildViews()
	return {
		RoleRelationshipArchiveView.New()
	}
end

return RoleRelationshipArchiveViewPresentor
