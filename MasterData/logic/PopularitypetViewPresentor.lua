-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/popularitylist/view/PopularitypetViewPresentor.lua

module("logic.extensions.popularitylist.view.PopularitypetViewPresentor", package.seeall)

local PopularitypetViewPresentor = class("PopularitypetViewPresentor", ViewPresentor)

function PopularitypetViewPresentor:ctor()
	PopularitypetViewPresentor.super.ctor(self)
end

function PopularitypetViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PopularitypetViewPresentor:dependWhatResources()
	return {
		"ui/views/popularitylist/popularitypetview.prefab"
	}
end

function PopularitypetViewPresentor:buildViews()
	return {
		PopularityPetView.New()
	}
end

return PopularitypetViewPresentor
