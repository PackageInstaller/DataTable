-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/view/TripleMacthesStartViewPresentor.lua

module("logic.extensions.triplemacthesgame.view.TripleMacthesStartViewPresentor", package.seeall)

local TripleMacthesStartViewPresentor = class("TripleMacthesStartViewPresentor", ViewPresentor)

function TripleMacthesStartViewPresentor:ctor()
	TripleMacthesStartViewPresentor.super.ctor(self)
end

function TripleMacthesStartViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TripleMacthesStartViewPresentor:dependWhatResources()
	return {
		"ui/views/triplemacthesgame/triplemacthesstartview.prefab"
	}
end

function TripleMacthesStartViewPresentor:buildViews()
	return {
		TripleMacthesStartView.New()
	}
end

return TripleMacthesStartViewPresentor
