-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/relationpower/view/RelationPowerMainViewPresentor.lua

module("logic.extensions.relationpower.view.RelationPowerMainViewPresentor", package.seeall)

local RelationPowerMainViewPresentor = class("RelationPowerMainViewPresentor", ViewPresentor)

function RelationPowerMainViewPresentor:ctor()
	RelationPowerMainViewPresentor.super.ctor(self)
end

function RelationPowerMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RelationPowerMainViewPresentor:dependWhatResources()
	return {
		"ui/views/relationpower/relationpowermainview.prefab"
	}
end

function RelationPowerMainViewPresentor:buildViews()
	return {
		RelationPowerMainView.New()
	}
end

return RelationPowerMainViewPresentor
