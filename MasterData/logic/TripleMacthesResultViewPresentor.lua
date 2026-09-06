-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/view/TripleMacthesResultViewPresentor.lua

module("logic.extensions.triplemacthesgame.view.TripleMacthesResultViewPresentor", package.seeall)

local TripleMacthesResultViewPresentor = class("TripleMacthesResultViewPresentor", ViewPresentor)

function TripleMacthesResultViewPresentor:ctor()
	TripleMacthesResultViewPresentor.super.ctor(self)
end

function TripleMacthesResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TripleMacthesResultViewPresentor:dependWhatResources()
	return {
		"ui/views/triplemacthesgame/triplemacthesresultview.prefab"
	}
end

function TripleMacthesResultViewPresentor:buildViews()
	return {
		TripleMacthesResultView.New()
	}
end

return TripleMacthesResultViewPresentor
