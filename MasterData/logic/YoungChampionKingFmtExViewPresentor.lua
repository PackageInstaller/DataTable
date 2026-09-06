-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungChampionKingFmtExViewPresentor.lua

module("logic.extensions.youngchampionking.view.YoungChampionKingFmtExViewPresentor", package.seeall)

local YoungChampionKingFmtExViewPresentor = class("YoungChampionKingFmtExViewPresentor", ViewPresentor)

function YoungChampionKingFmtExViewPresentor:ctor()
	YoungChampionKingFmtExViewPresentor.super.ctor(self)
end

function YoungChampionKingFmtExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YoungChampionKingFmtExViewPresentor:dependWhatResources()
	return {
		"ui/views/youngchampionking/youngchampionkingfmtexview.prefab"
	}
end

function YoungChampionKingFmtExViewPresentor:buildViews()
	return {
		YoungChampionKingFmtExView.New()
	}
end

function YoungChampionKingFmtExViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return YoungChampionKingFmtExViewPresentor
