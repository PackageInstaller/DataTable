-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originage/view/OriginagemainViewPresentor.lua

module("logic.extensions.originage.view.OriginagemainViewPresentor", package.seeall)

local OriginagemainViewPresentor = class("OriginagemainViewPresentor", ViewPresentor)

function OriginagemainViewPresentor:ctor()
	OriginagemainViewPresentor.super.ctor(self)
end

function OriginagemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginagemainViewPresentor:dependWhatResources()
	return {
		"ui/views/originage/originagemainview.prefab"
	}
end

function OriginagemainViewPresentor:buildViews()
	return {
		OriginagemainView.New()
	}
end

return OriginagemainViewPresentor
