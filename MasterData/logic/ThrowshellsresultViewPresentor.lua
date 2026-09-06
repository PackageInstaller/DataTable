-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throwshells/view/ThrowshellsresultViewPresentor.lua

module("logic.extensions.throwshells.view.ThrowshellsresultViewPresentor", package.seeall)

local ThrowshellsresultViewPresentor = class("ThrowshellsresultViewPresentor", ViewPresentor)

function ThrowshellsresultViewPresentor:ctor()
	ThrowshellsresultViewPresentor.super.ctor(self)
end

function ThrowshellsresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ThrowshellsresultViewPresentor:dependWhatResources()
	return {
		"ui/views/throwshells/throwshellsresultview.prefab"
	}
end

function ThrowshellsresultViewPresentor:buildViews()
	return {
		ThrowShellsResultView.New()
	}
end

return ThrowshellsresultViewPresentor
