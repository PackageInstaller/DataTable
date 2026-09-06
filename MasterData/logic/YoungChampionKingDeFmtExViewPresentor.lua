-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungChampionKingDeFmtExViewPresentor.lua

module("logic.extensions.youngchampionking.view.YoungChampionKingDeFmtExViewPresentor", package.seeall)

local YoungChampionKingDeFmtExViewPresentor = class("YoungChampionKingDeFmtExViewPresentor", ViewPresentor)

function YoungChampionKingDeFmtExViewPresentor:ctor()
	YoungChampionKingDeFmtExViewPresentor.super.ctor(self)
end

function YoungChampionKingDeFmtExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YoungChampionKingDeFmtExViewPresentor:dependWhatResources()
	return {
		"ui/views/youngchampionking/youngchampionkingdefmtexview.prefab"
	}
end

function YoungChampionKingDeFmtExViewPresentor:buildViews()
	return {
		YoungChampionKingDeFmtExView.New()
	}
end

function YoungChampionKingDeFmtExViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return YoungChampionKingDeFmtExViewPresentor
