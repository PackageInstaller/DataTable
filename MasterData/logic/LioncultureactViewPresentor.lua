-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/view/LioncultureactViewPresentor.lua

module("logic.extensions.lionculture.view.LioncultureactViewPresentor", package.seeall)

local LioncultureactViewPresentor = class("LioncultureactViewPresentor", ViewPresentor)

function LioncultureactViewPresentor:ctor()
	LioncultureactViewPresentor.super.ctor(self)
end

function LioncultureactViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LioncultureactViewPresentor:dependWhatResources()
	return {
		"ui/views/lionculture/lioncultureactview.prefab"
	}
end

function LioncultureactViewPresentor:buildViews()
	return {
		LioncultureactView.New()
	}
end

return LioncultureactViewPresentor
