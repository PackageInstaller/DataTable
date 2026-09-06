-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungchampionkingfinalshowViewPresentor.lua

module("logic.extensions.youngchampionking.view.YoungchampionkingfinalshowViewPresentor", package.seeall)

local YoungchampionkingfinalshowViewPresentor = class("YoungchampionkingfinalshowViewPresentor", ViewPresentor)

function YoungchampionkingfinalshowViewPresentor:ctor()
	YoungchampionkingfinalshowViewPresentor.super.ctor(self)
end

function YoungchampionkingfinalshowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YoungchampionkingfinalshowViewPresentor:dependWhatResources()
	return {
		"ui/views/youngchampionking/youngchampionkingfinalshowview.prefab"
	}
end

function YoungchampionkingfinalshowViewPresentor:buildViews()
	return {
		YoungchampionkingfinalshowView.New()
	}
end

return YoungchampionkingfinalshowViewPresentor
