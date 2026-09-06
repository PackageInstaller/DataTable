-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/view/TripleMacthesRankViewPresentor.lua

module("logic.extensions.triplemacthesgame.view.TripleMacthesRankViewPresentor", package.seeall)

local TripleMacthesRankViewPresentor = class("TripleMacthesRankViewPresentor", ViewPresentor)

function TripleMacthesRankViewPresentor:ctor()
	TripleMacthesRankViewPresentor.super.ctor(self)
end

function TripleMacthesRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TripleMacthesRankViewPresentor:dependWhatResources()
	return {
		"ui/views/triplemacthesgame/triplemacthesrankview.prefab"
	}
end

function TripleMacthesRankViewPresentor:buildViews()
	return {
		TripleMacthesRankView.New()
	}
end

return TripleMacthesRankViewPresentor
