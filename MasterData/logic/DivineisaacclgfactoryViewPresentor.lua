-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineisaacclg/view/DivineisaacclgfactoryViewPresentor.lua

module("logic.extensions.divineisaacclg.view.DivineisaacclgfactoryViewPresentor", package.seeall)

local DivineisaacclgfactoryViewPresentor = class("DivineisaacclgfactoryViewPresentor", ViewPresentor)

function DivineisaacclgfactoryViewPresentor:ctor()
	DivineisaacclgfactoryViewPresentor.super.ctor(self)
end

function DivineisaacclgfactoryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineisaacclgfactoryViewPresentor:dependWhatResources()
	return {
		"ui/views/divineisaacclg/divineisaacclgfactoryview.prefab"
	}
end

function DivineisaacclgfactoryViewPresentor:buildViews()
	return {
		DivineisaacclgfactoryView.New()
	}
end

return DivineisaacclgfactoryViewPresentor
