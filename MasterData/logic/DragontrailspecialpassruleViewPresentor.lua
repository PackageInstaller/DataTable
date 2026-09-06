-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/DragontrailspecialpassruleViewPresentor.lua

module("logic.extensions.dragontrial.view.DragontrailspecialpassruleViewPresentor", package.seeall)

local DragontrailspecialpassruleViewPresentor = class("DragontrailspecialpassruleViewPresentor", ViewPresentor)

function DragontrailspecialpassruleViewPresentor:ctor()
	DragontrailspecialpassruleViewPresentor.super.ctor(self)
end

function DragontrailspecialpassruleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragontrailspecialpassruleViewPresentor:dependWhatResources()
	return {
		"ui/views/dragontrial/dragontrailspecialpassruleview.prefab"
	}
end

function DragontrailspecialpassruleViewPresentor:buildViews()
	return {
		DragontrailspecialpassruleView.New()
	}
end

return DragontrailspecialpassruleViewPresentor
