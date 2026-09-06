-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessbattle/view/EndlessPopViewPresentor.lua

module("logic.extensions.endlessbattle.view.EndlessPopViewPresentor", package.seeall)

local EndlessPopViewPresentor = class("EndlessPopViewPresentor", ViewPresentor)

function EndlessPopViewPresentor:ctor()
	EndlessPopViewPresentor.super.ctor(self)
end

function EndlessPopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function EndlessPopViewPresentor:dependWhatResources()
	return {
		"ui/views/endlessbattle/endlesspopview.prefab"
	}
end

function EndlessPopViewPresentor:buildViews()
	return {
		EndlessPopView.New()
	}
end

return EndlessPopViewPresentor
