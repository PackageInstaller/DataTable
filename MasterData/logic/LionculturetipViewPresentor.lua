-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/view/LionculturetipViewPresentor.lua

module("logic.extensions.lionculture.view.LionculturetipViewPresentor", package.seeall)

local LionculturetipViewPresentor = class("LionculturetipViewPresentor", ViewPresentor)

function LionculturetipViewPresentor:ctor()
	LionculturetipViewPresentor.super.ctor(self)
end

function LionculturetipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LionculturetipViewPresentor:dependWhatResources()
	return {
		"ui/views/lionculture/lionculturetipview.prefab"
	}
end

function LionculturetipViewPresentor:buildViews()
	return {
		LionculturetipView.New()
	}
end

return LionculturetipViewPresentor
