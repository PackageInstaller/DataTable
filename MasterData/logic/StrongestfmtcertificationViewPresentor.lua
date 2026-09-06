-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/StrongestfmtcertificationViewPresentor.lua

module("logic.extensions.recommendfmt.view.StrongestfmtcertificationViewPresentor", package.seeall)

local StrongestfmtcertificationViewPresentor = class("StrongestfmtcertificationViewPresentor", ViewPresentor)

function StrongestfmtcertificationViewPresentor:ctor()
	StrongestfmtcertificationViewPresentor.super.ctor(self)
end

function StrongestfmtcertificationViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StrongestfmtcertificationViewPresentor:dependWhatResources()
	return {
		"ui/views/recommendfmt/strongestfmtcertificationview.prefab"
	}
end

function StrongestfmtcertificationViewPresentor:buildViews()
	return {
		StrongestfmtcertificationView.New()
	}
end

return StrongestfmtcertificationViewPresentor
