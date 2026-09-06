-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungChampionKingFinalsViewPresentor.lua

module("logic.extensions.youngchampionking.view.YoungChampionKingFinalsViewPresentor", package.seeall)

local YoungChampionKingFinalsViewPresentor = class("YoungChampionKingFinalsViewPresentor", ViewPresentor)

function YoungChampionKingFinalsViewPresentor:ctor()
	YoungChampionKingFinalsViewPresentor.super.ctor(self)
end

function YoungChampionKingFinalsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YoungChampionKingFinalsViewPresentor:dependWhatResources()
	return {
		"ui/views/youngchampionking/youngchampionkingfinalsview.prefab"
	}
end

function YoungChampionKingFinalsViewPresentor:buildViews()
	return {
		YoungChampionKingFinalsView.New()
	}
end

return YoungChampionKingFinalsViewPresentor
