-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throwshells/view/ThrowshellsgameViewPresentor.lua

module("logic.extensions.throwshells.view.ThrowshellsgameViewPresentor", package.seeall)

local ThrowshellsgameViewPresentor = class("ThrowshellsgameViewPresentor", ViewPresentor)

function ThrowshellsgameViewPresentor:ctor()
	ThrowshellsgameViewPresentor.super.ctor(self)
end

function ThrowshellsgameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ThrowshellsgameViewPresentor:dependWhatResources()
	return {
		"ui/views/throwshells/throwshellsgameview.prefab"
	}
end

function ThrowshellsgameViewPresentor:buildViews()
	return {
		ThrowShellsGameView.New()
	}
end

return ThrowshellsgameViewPresentor
