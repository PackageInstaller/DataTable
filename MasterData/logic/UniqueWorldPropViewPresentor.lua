-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uniqueworld/view/UniqueWorldPropViewPresentor.lua

module("logic.extensions.uniqueworld.view.UniqueWorldPropViewPresentor", package.seeall)

local UniqueWorldPropViewPresentor = class("UniqueWorldPropViewPresentor", ViewPresentor)

function UniqueWorldPropViewPresentor:ctor()
	UniqueWorldPropViewPresentor.super.ctor(self)
end

function UniqueWorldPropViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function UniqueWorldPropViewPresentor:dependWhatResources()
	return {
		"ui/views/uniqueworld/uniqueworldpropview.prefab"
	}
end

function UniqueWorldPropViewPresentor:buildViews()
	return {
		UniqueWorldPropView.New()
	}
end

return UniqueWorldPropViewPresentor
