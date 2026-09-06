-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamyouth/view/DreamyouthViewPresentor.lua

module("logic.extensions.dreamyouth.view.DreamyouthViewPresentor", package.seeall)

local DreamyouthViewPresentor = class("DreamyouthViewPresentor", ViewPresentor)

function DreamyouthViewPresentor:ctor()
	DreamyouthViewPresentor.super.ctor(self)
end

function DreamyouthViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamyouthViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamyouth/dreamyouthview.prefab"
	}
end

function DreamyouthViewPresentor:buildViews()
	return {
		DreamyouthView.New()
	}
end

return DreamyouthViewPresentor
