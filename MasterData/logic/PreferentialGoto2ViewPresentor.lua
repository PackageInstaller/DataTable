-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/PreferentialGoto2ViewPresentor.lua

module("logic.extensions.bonus.view.PreferentialGoto2ViewPresentor", package.seeall)

local PreferentialGoto2ViewPresentor = class("PreferentialGoto2ViewPresentor", ViewPresentor)

function PreferentialGoto2ViewPresentor:ctor()
	PreferentialGoto2ViewPresentor.super.ctor(self)
end

function PreferentialGoto2ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PreferentialGoto2ViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/preferentialgoto2view.prefab"
	}
end

function PreferentialGoto2ViewPresentor:buildViews()
	return {
		PreferentialGoto2View.New()
	}
end

return PreferentialGoto2ViewPresentor
