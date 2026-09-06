-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemsetting/view/HuaweialertViewPresentor.lua

module("logic.extensions.systemsetting.view.HuaweialertViewPresentor", package.seeall)

local HuaweialertViewPresentor = class("HuaweialertViewPresentor", ViewPresentor)

function HuaweialertViewPresentor:ctor()
	HuaweialertViewPresentor.super.ctor(self)
end

function HuaweialertViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HuaweialertViewPresentor:dependWhatResources()
	return {
		"ui/views/systemsetting/huaweialertview.prefab"
	}
end

function HuaweialertViewPresentor:buildViews()
	return {
		HuaweialertView.New()
	}
end

return HuaweialertViewPresentor
