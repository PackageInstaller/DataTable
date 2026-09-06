-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/view/ResPopupViewPresentor.lua

module("logic.extensions.materialchallenge.view.ResPopupViewPresentor", package.seeall)

local ResPopupViewPresentor = class("ResPopupViewPresentor", ViewPresentor)

function ResPopupViewPresentor:ctor()
	ResPopupViewPresentor.super.ctor(self)
end

function ResPopupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ResPopupViewPresentor:dependWhatResources()
	return {
		"ui/views/materialchallenge/respopupview.prefab"
	}
end

function ResPopupViewPresentor:buildViews()
	return {
		ResPopupView.New()
	}
end

return ResPopupViewPresentor
