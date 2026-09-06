-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejieshen/view/DivineSuccessViewPresentor.lua

module("logic.extensions.divinejieshen.view.DivineSuccessViewPresentor", package.seeall)

local DivineSuccessViewPresentor = class("DivineSuccessViewPresentor", ViewPresentor)

function DivineSuccessViewPresentor:ctor()
	DivineSuccessViewPresentor.super.ctor(self)
end

function DivineSuccessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineSuccessViewPresentor:dependWhatResources()
	return {
		"ui/views/divinejieshen/divinesuccessview.prefab"
	}
end

function DivineSuccessViewPresentor:buildViews()
	return {
		DivineSuccessView.New()
	}
end

return DivineSuccessViewPresentor
