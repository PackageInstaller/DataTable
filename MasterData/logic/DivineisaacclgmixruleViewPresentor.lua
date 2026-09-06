-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineisaacclg/view/DivineisaacclgmixruleViewPresentor.lua

module("logic.extensions.divineisaacclg.view.DivineisaacclgmixruleViewPresentor", package.seeall)

local DivineisaacclgmixruleViewPresentor = class("DivineisaacclgmixruleViewPresentor", ViewPresentor)

function DivineisaacclgmixruleViewPresentor:ctor()
	DivineisaacclgmixruleViewPresentor.super.ctor(self)
end

function DivineisaacclgmixruleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineisaacclgmixruleViewPresentor:dependWhatResources()
	return {
		"ui/views/divineisaacclg/divineisaacclgmixruleview.prefab"
	}
end

function DivineisaacclgmixruleViewPresentor:buildViews()
	return {
		DivineisaacclgmixruleView.New()
	}
end

return DivineisaacclgmixruleViewPresentor
