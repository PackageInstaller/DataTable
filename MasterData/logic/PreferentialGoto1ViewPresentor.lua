-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/PreferentialGoto1ViewPresentor.lua

module("logic.extensions.bonus.view.PreferentialGoto1ViewPresentor", package.seeall)

local PreferentialGoto1ViewPresentor = class("PreferentialGoto1ViewPresentor", ViewPresentor)

function PreferentialGoto1ViewPresentor:ctor()
	PreferentialGoto1ViewPresentor.super.ctor(self)
end

function PreferentialGoto1ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PreferentialGoto1ViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/preferentialgoto1view.prefab"
	}
end

function PreferentialGoto1ViewPresentor:buildViews()
	return {
		PreferentialGoto1View.New()
	}
end

return PreferentialGoto1ViewPresentor
