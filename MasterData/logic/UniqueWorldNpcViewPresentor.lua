-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uniqueworld/view/UniqueWorldNpcViewPresentor.lua

module("logic.extensions.uniqueworld.view.UniqueWorldNpcViewPresentor", package.seeall)

local UniqueWorldNpcViewPresentor = class("UniqueWorldNpcViewPresentor", ViewPresentor)

function UniqueWorldNpcViewPresentor:ctor()
	UniqueWorldNpcViewPresentor.super.ctor(self)
end

function UniqueWorldNpcViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function UniqueWorldNpcViewPresentor:dependWhatResources()
	return {
		"ui/views/uniqueworld/uniqueworldnpcview.prefab"
	}
end

function UniqueWorldNpcViewPresentor:buildViews()
	return {
		UniqueWorldNpcView.New()
	}
end

return UniqueWorldNpcViewPresentor
