-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/view/LioncultureshapeViewPresentor.lua

module("logic.extensions.lionculture.view.LioncultureshapeViewPresentor", package.seeall)

local LioncultureshapeViewPresentor = class("LioncultureshapeViewPresentor", ViewPresentor)

function LioncultureshapeViewPresentor:ctor()
	LioncultureshapeViewPresentor.super.ctor(self)
end

function LioncultureshapeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LioncultureshapeViewPresentor:dependWhatResources()
	return {
		"ui/views/lionculture/lioncultureshapeview.prefab"
	}
end

function LioncultureshapeViewPresentor:buildViews()
	return {
		LioncultureshapeView.New()
	}
end

return LioncultureshapeViewPresentor
