-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originage/view/OriginagebindViewPresentor.lua

module("logic.extensions.originage.view.OriginagebindViewPresentor", package.seeall)

local OriginagebindViewPresentor = class("OriginagebindViewPresentor", ViewPresentor)

function OriginagebindViewPresentor:ctor()
	OriginagebindViewPresentor.super.ctor(self)
end

function OriginagebindViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginagebindViewPresentor:dependWhatResources()
	return {
		"ui/views/originage/originagebindview.prefab"
	}
end

function OriginagebindViewPresentor:buildViews()
	return {
		OriginagebindView.New()
	}
end

return OriginagebindViewPresentor
