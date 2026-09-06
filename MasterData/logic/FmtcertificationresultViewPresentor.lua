-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/FmtcertificationresultViewPresentor.lua

module("logic.extensions.recommendfmt.view.FmtcertificationresultViewPresentor", package.seeall)

local FmtcertificationresultViewPresentor = class("FmtcertificationresultViewPresentor", ViewPresentor)

function FmtcertificationresultViewPresentor:ctor()
	FmtcertificationresultViewPresentor.super.ctor(self)
end

function FmtcertificationresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FmtcertificationresultViewPresentor:dependWhatResources()
	return {
		"ui/views/recommendfmt/fmtcertificationresultview.prefab"
	}
end

function FmtcertificationresultViewPresentor:buildViews()
	return {
		FmtcertificationresultView.New()
	}
end

return FmtcertificationresultViewPresentor
