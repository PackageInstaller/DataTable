-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/view/LioncultureViewPresentor.lua

module("logic.extensions.lionculture.view.LioncultureViewPresentor", package.seeall)

local LioncultureViewPresentor = class("LioncultureViewPresentor", ViewPresentor)

function LioncultureViewPresentor:ctor()
	LioncultureViewPresentor.super.ctor(self)
end

function LioncultureViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LioncultureViewPresentor:dependWhatResources()
	return {
		"ui/views/lionculture/lioncultureview.prefab"
	}
end

function LioncultureViewPresentor:buildViews()
	return {
		LioncultureView.New()
	}
end

return LioncultureViewPresentor
