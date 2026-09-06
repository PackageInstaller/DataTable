-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungchampionkingrankViewPresentor.lua

module("logic.extensions.youngchampionking.view.YoungchampionkingrankViewPresentor", package.seeall)

local YoungchampionkingrankViewPresentor = class("YoungchampionkingrankViewPresentor", ViewPresentor)

function YoungchampionkingrankViewPresentor:ctor()
	YoungchampionkingrankViewPresentor.super.ctor(self)
end

function YoungchampionkingrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YoungchampionkingrankViewPresentor:dependWhatResources()
	return {
		"ui/views/youngchampionking/youngchampionkingrankview.prefab"
	}
end

function YoungchampionkingrankViewPresentor:buildViews()
	return {
		YoungchampionkingrankView.New()
	}
end

return YoungchampionkingrankViewPresentor
