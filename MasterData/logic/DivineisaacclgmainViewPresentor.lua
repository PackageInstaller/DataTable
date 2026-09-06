-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineisaacclg/view/DivineisaacclgmainViewPresentor.lua

module("logic.extensions.divineisaacclg.view.DivineisaacclgmainViewPresentor", package.seeall)

local DivineisaacclgmainViewPresentor = class("DivineisaacclgmainViewPresentor", ViewPresentor)

function DivineisaacclgmainViewPresentor:ctor()
	DivineisaacclgmainViewPresentor.super.ctor(self)
end

function DivineisaacclgmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineisaacclgmainViewPresentor:dependWhatResources()
	return {
		"ui/views/divineisaacclg/divineisaacclgmainview.prefab"
	}
end

function DivineisaacclgmainViewPresentor:buildViews()
	return {
		DivineisaacclgmainView.New()
	}
end

return DivineisaacclgmainViewPresentor
