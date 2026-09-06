-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throwshells/view/ThrowshellsmainViewPresentor.lua

module("logic.extensions.throwshells.view.ThrowshellsmainViewPresentor", package.seeall)

local ThrowshellsmainViewPresentor = class("ThrowshellsmainViewPresentor", ViewPresentor)

function ThrowshellsmainViewPresentor:ctor()
	ThrowshellsmainViewPresentor.super.ctor(self)
end

function ThrowshellsmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ThrowshellsmainViewPresentor:dependWhatResources()
	return {
		"ui/views/throwshells/throwshellsmainview.prefab"
	}
end

function ThrowshellsmainViewPresentor:buildViews()
	return {
		ThrowShellsMainView.New()
	}
end

return ThrowshellsmainViewPresentor
