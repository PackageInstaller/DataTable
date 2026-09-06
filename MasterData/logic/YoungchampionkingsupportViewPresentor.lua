-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungchampionkingsupportViewPresentor.lua

module("logic.extensions.youngchampionking.view.YoungchampionkingsupportViewPresentor", package.seeall)

local YoungchampionkingsupportViewPresentor = class("YoungchampionkingsupportViewPresentor", ViewPresentor)

function YoungchampionkingsupportViewPresentor:ctor()
	YoungchampionkingsupportViewPresentor.super.ctor(self)
end

function YoungchampionkingsupportViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function YoungchampionkingsupportViewPresentor:dependWhatResources()
	return {
		"ui/views/youngchampionking/youngchampionkingsupportview.prefab"
	}
end

function YoungchampionkingsupportViewPresentor:buildViews()
	return {
		YoungchampionkingsupportView.New()
	}
end

return YoungchampionkingsupportViewPresentor
