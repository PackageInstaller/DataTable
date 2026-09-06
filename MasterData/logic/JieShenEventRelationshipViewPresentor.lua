-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenevent/view/JieShenEventRelationshipViewPresentor.lua

module("logic.extensions.jieshenevent.view.JieShenEventRelationshipViewPresentor", package.seeall)

local JieShenEventRelationshipViewPresentor = class("JieShenEventRelationshipViewPresentor", ViewPresentor)

function JieShenEventRelationshipViewPresentor:ctor()
	JieShenEventRelationshipViewPresentor.super.ctor(self)
end

function JieShenEventRelationshipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JieShenEventRelationshipViewPresentor:dependWhatResources()
	return {
		"ui/views/jieshenevent/jiesheneventrelationshipview.prefab"
	}
end

function JieShenEventRelationshipViewPresentor:buildViews()
	return {
		JieShenEventRelationshipView.New()
	}
end

return JieShenEventRelationshipViewPresentor
