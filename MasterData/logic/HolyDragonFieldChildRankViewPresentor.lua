-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/view/HolyDragonFieldChildRankViewPresentor.lua

module("logic.extensions.holydragonfield.view.HolyDragonFieldChildRankViewPresentor", package.seeall)

local HolyDragonFieldChildRankViewPresentor = class("HolyDragonFieldChildRankViewPresentor", ViewPresentor)

function HolyDragonFieldChildRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyDragonFieldChildRankViewPresentor:dependWhatResources()
	return {
		"ui/views/commontabrank/holydragonfieldchildrankview.prefab"
	}
end

function HolyDragonFieldChildRankViewPresentor:buildViews()
	return {
		HolyDragonFieldChildRankView.New()
	}
end

function HolyDragonFieldChildRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HolyDragonFieldChildRankViewPresentor
