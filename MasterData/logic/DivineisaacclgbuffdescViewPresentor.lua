-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineisaacclg/view/DivineisaacclgbuffdescViewPresentor.lua

module("logic.extensions.divineisaacclg.view.DivineisaacclgbuffdescViewPresentor", package.seeall)

local DivineisaacclgbuffdescViewPresentor = class("DivineisaacclgbuffdescViewPresentor", ViewPresentor)

function DivineisaacclgbuffdescViewPresentor:ctor()
	DivineisaacclgbuffdescViewPresentor.super.ctor(self)
end

function DivineisaacclgbuffdescViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineisaacclgbuffdescViewPresentor:dependWhatResources()
	return {
		"ui/views/divineisaacclg/divineisaacclgbuffdescview.prefab"
	}
end

function DivineisaacclgbuffdescViewPresentor:buildViews()
	return {
		DivineisaacclgbuffdescView.New()
	}
end

return DivineisaacclgbuffdescViewPresentor
