-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/view/TripleMacthesPrizeViewPresentor.lua

module("logic.extensions.triplemacthesgame.view.TripleMacthesPrizeViewPresentor", package.seeall)

local TripleMacthesPrizeViewPresentor = class("TripleMacthesPrizeViewPresentor", ViewPresentor)

function TripleMacthesPrizeViewPresentor:ctor()
	TripleMacthesPrizeViewPresentor.super.ctor(self)
end

function TripleMacthesPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TripleMacthesPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/triplemacthesgame/triplemacthesprizeview.prefab"
	}
end

function TripleMacthesPrizeViewPresentor:buildViews()
	return {
		TripleMacthesPrizeView.New()
	}
end

return TripleMacthesPrizeViewPresentor
