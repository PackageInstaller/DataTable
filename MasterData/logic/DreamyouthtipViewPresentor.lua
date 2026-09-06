-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamyouth/view/DreamyouthtipViewPresentor.lua

module("logic.extensions.dreamyouth.view.DreamyouthtipViewPresentor", package.seeall)

local DreamyouthtipViewPresentor = class("DreamyouthtipViewPresentor", ViewPresentor)

function DreamyouthtipViewPresentor:ctor()
	DreamyouthtipViewPresentor.super.ctor(self)
end

function DreamyouthtipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DreamyouthtipViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamyouth/dreamyouthtipview.prefab"
	}
end

function DreamyouthtipViewPresentor:buildViews()
	return {
		DreamyouthtipView.New()
	}
end

return DreamyouthtipViewPresentor
