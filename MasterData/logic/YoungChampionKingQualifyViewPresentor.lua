-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungChampionKingQualifyViewPresentor.lua

module("logic.extensions.youngchampionking.view.YoungChampionKingQualifyViewPresentor", package.seeall)

local YoungChampionKingQualifyViewPresentor = class("YoungChampionKingQualifyViewPresentor", ViewPresentor)

function YoungChampionKingQualifyViewPresentor:ctor()
	YoungChampionKingQualifyViewPresentor.super.ctor(self)
end

function YoungChampionKingQualifyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YoungChampionKingQualifyViewPresentor:dependWhatResources()
	return {
		"ui/views/youngchampionking/youngchampionkingqualifyview.prefab"
	}
end

function YoungChampionKingQualifyViewPresentor:buildViews()
	return {
		YoungChampionKingQualifyView.New()
	}
end

return YoungChampionKingQualifyViewPresentor
