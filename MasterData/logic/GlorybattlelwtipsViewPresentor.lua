-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/view/GlorybattlelwtipsViewPresentor.lua

module("logic.extensions.glorybattle.view.GlorybattlelwtipsViewPresentor", package.seeall)

local GlorybattlelwtipsViewPresentor = class("GlorybattlelwtipsViewPresentor", ViewPresentor)

function GlorybattlelwtipsViewPresentor:ctor()
	GlorybattlelwtipsViewPresentor.super.ctor(self)
end

function GlorybattlelwtipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GlorybattlelwtipsViewPresentor:dependWhatResources()
	return {
		"ui/views/glorybattle/glorybattlelwtipsview.prefab"
	}
end

function GlorybattlelwtipsViewPresentor:buildViews()
	return {
		GlorybattlelwtipsView.New()
	}
end

function GlorybattlelwtipsViewPresentor:setGrayMaskGO(grayMaskGO)
	GlorybattlelwtipsViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	goutil.setActive(grayMaskGO, false)
end

return GlorybattlelwtipsViewPresentor
