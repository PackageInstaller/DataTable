-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/makingmooncake/view/MakingMoonCakeSelectViewPresentor.lua

module("logic.extensions.makingmooncake.view.MakingMoonCakeSelectViewPresentor", package.seeall)

local MakingMoonCakeSelectViewPresentor = class("MakingMoonCakeSelectViewPresentor", ViewPresentor)

function MakingMoonCakeSelectViewPresentor:ctor()
	MakingMoonCakeSelectViewPresentor.super.ctor(self)
end

function MakingMoonCakeSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MakingMoonCakeSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/makingmooncake/makingmooncakeselectview.prefab"
	}
end

function MakingMoonCakeSelectViewPresentor:buildViews()
	return {
		MakingMoonCakeSelectView.New()
	}
end

return MakingMoonCakeSelectViewPresentor
