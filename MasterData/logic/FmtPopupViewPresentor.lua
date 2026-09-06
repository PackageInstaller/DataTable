-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/FmtPopupViewPresentor.lua

module("logic.extensions.recommendfmt.view.FmtPopupViewPresentor", package.seeall)

local FmtPopupViewPresentor = class("FmtPopupViewPresentor", ViewPresentor)

function FmtPopupViewPresentor:ctor()
	FmtPopupViewPresentor.super.ctor(self)
end

function FmtPopupViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function FmtPopupViewPresentor:dependWhatResources()
	return {
		"ui/views/recommendfmt/fmtpopupview.prefab"
	}
end

function FmtPopupViewPresentor:buildViews()
	return {
		FmtPopupView.New()
	}
end

return FmtPopupViewPresentor
