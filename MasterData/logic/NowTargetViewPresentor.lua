-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/NowTargetViewPresentor.lua

module("logic.extensions.powerland.view.NowTargetViewPresentor", package.seeall)

local NowTargetViewPresentor = class("NowTargetViewPresentor", ViewPresentor)

function NowTargetViewPresentor:ctor()
	NowTargetViewPresentor.super.ctor(self)
end

function NowTargetViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function NowTargetViewPresentor:dependWhatResources()
	return {
		"ui/views/powerland/nowtargetview.prefab"
	}
end

function NowTargetViewPresentor:buildViews()
	return {
		NowTargetView.New()
	}
end

return NowTargetViewPresentor
