-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckydraw/view/LuckydrawtimestatemultipleViewPresentor.lua

module("logic.extensions.luckydraw.view.LuckydrawtimestatemultipleViewPresentor", package.seeall)

local LuckydrawtimestatemultipleViewPresentor = class("LuckydrawtimestatemultipleViewPresentor", ViewPresentor)

function LuckydrawtimestatemultipleViewPresentor:ctor()
	LuckydrawtimestatemultipleViewPresentor.super.ctor(self)
end

function LuckydrawtimestatemultipleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LuckydrawtimestatemultipleViewPresentor:dependWhatResources()
	return {
		"ui/views/luckydraw/luckydrawtimestatemultipleview.prefab"
	}
end

function LuckydrawtimestatemultipleViewPresentor:buildViews()
	return {
		LuckydrawtimestatemultipleView.New()
	}
end

return LuckydrawtimestatemultipleViewPresentor
