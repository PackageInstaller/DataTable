-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/StrongFmtrankViewPresentor.lua

module("logic.extensions.handbook.view.StrongFmtrankViewPresentor", package.seeall)

local StrongFmtrankViewPresentor = class("StrongFmtrankViewPresentor", ViewPresentor)

function StrongFmtrankViewPresentor:ctor()
	StrongFmtrankViewPresentor.super.ctor(self)
end

function StrongFmtrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StrongFmtrankViewPresentor:dependWhatResources()
	return {
		"ui/views/powercheck/strongfmtrankview.prefab"
	}
end

function StrongFmtrankViewPresentor:buildViews()
	return {
		StrongFmtrankView.New()
	}
end

return StrongFmtrankViewPresentor
