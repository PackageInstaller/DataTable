-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/ScbonusawardViewPresentor.lua

module("logic.extensions.scenariocopy.view.ScbonusawardViewPresentor", package.seeall)

local ScbonusawardViewPresentor = class("ScbonusawardViewPresentor", ViewPresentor)

function ScbonusawardViewPresentor:ctor()
	ScbonusawardViewPresentor.super.ctor(self)
end

function ScbonusawardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ScbonusawardViewPresentor:dependWhatResources()
	return {
		"ui/views/scenariocopy/scbonusawardview.prefab"
	}
end

function ScbonusawardViewPresentor:buildViews()
	return {
		ScbonusawardView.New()
	}
end

return ScbonusawardViewPresentor
