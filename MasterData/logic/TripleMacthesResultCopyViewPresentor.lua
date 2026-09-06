-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/view/TripleMacthesResultCopyViewPresentor.lua

module("logic.extensions.triplemacthesgame.view.TripleMacthesResultCopyViewPresentor", package.seeall)

local TripleMacthesResultCopyViewPresentor = class("TripleMacthesResultCopyViewPresentor", ViewPresentor)

function TripleMacthesResultCopyViewPresentor:ctor()
	TripleMacthesResultCopyViewPresentor.super.ctor(self)
end

function TripleMacthesResultCopyViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TripleMacthesResultCopyViewPresentor:dependWhatResources()
	return {
		"ui/views/triplemacthesgame/triplemacthesresultcopyview.prefab"
	}
end

function TripleMacthesResultCopyViewPresentor:buildViews()
	return {
		TripleMacthesResultCopyView.New()
	}
end

return TripleMacthesResultCopyViewPresentor
