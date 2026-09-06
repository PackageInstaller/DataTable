-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineisaacclg/view/DivineisaacclgstageViewPresentor.lua

module("logic.extensions.divineisaacclg.view.DivineisaacclgstageViewPresentor", package.seeall)

local DivineisaacclgstageViewPresentor = class("DivineisaacclgstageViewPresentor", ViewPresentor)

function DivineisaacclgstageViewPresentor:ctor()
	DivineisaacclgstageViewPresentor.super.ctor(self)
end

function DivineisaacclgstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineisaacclgstageViewPresentor:dependWhatResources()
	return {
		"ui/views/divineisaacclg/divineisaacclgstageview.prefab"
	}
end

function DivineisaacclgstageViewPresentor:buildViews()
	return {
		DivineisaacclgstageView.New()
	}
end

return DivineisaacclgstageViewPresentor
