-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/view/LioncultureformationViewPresentor.lua

module("logic.extensions.lionculture.view.LioncultureformationViewPresentor", package.seeall)

local LioncultureformationViewPresentor = class("LioncultureformationViewPresentor", ViewPresentor)

function LioncultureformationViewPresentor:ctor()
	LioncultureformationViewPresentor.super.ctor(self)
end

function LioncultureformationViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LioncultureformationViewPresentor:dependWhatResources()
	return {
		"ui/views/lionculture/lioncultureformationview.prefab"
	}
end

function LioncultureformationViewPresentor:buildViews()
	return {
		LioncultureformationView.New()
	}
end

return LioncultureformationViewPresentor
