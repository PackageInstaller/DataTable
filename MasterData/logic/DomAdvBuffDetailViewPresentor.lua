-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/DomAdvBuffDetailViewPresentor.lua

module("logic.extensions.domainadventure.view.DomAdvBuffDetailViewPresentor", package.seeall)

local DomAdvBuffDetailViewPresentor = class("DomAdvBuffDetailViewPresentor", ViewPresentor)

function DomAdvBuffDetailViewPresentor:ctor()
	DomAdvBuffDetailViewPresentor.super.ctor(self)
end

function DomAdvBuffDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DomAdvBuffDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/domainadventure/domadvbuffdetailview.prefab"
	}
end

function DomAdvBuffDetailViewPresentor:buildViews()
	return {
		DomAdvBuffDetailView.New()
	}
end

return DomAdvBuffDetailViewPresentor
