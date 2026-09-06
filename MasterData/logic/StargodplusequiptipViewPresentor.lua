-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodplus/view/StargodplusequiptipViewPresentor.lua

module("logic.extensions.stargodplus.view.StargodplusequiptipViewPresentor", package.seeall)

local StargodplusequiptipViewPresentor = class("StargodplusequiptipViewPresentor", ViewPresentor)

function StargodplusequiptipViewPresentor:ctor()
	StargodplusequiptipViewPresentor.super.ctor(self)
end

function StargodplusequiptipViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function StargodplusequiptipViewPresentor:dependWhatResources()
	return {
		"ui/views/stargodplus/stargodplusequiptip.prefab"
	}
end

function StargodplusequiptipViewPresentor:buildViews()
	return {
		StargodplusequiptipView.New()
	}
end

function StargodplusequiptipViewPresentor:onClickOutside()
	UIStateManager.instance:popByName(self.viewName)
end

return StargodplusequiptipViewPresentor
