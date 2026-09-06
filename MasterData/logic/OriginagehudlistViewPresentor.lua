-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originage/view/OriginagehudlistViewPresentor.lua

module("logic.extensions.originage.view.OriginagehudlistViewPresentor", package.seeall)

local OriginagehudlistViewPresentor = class("OriginagehudlistViewPresentor", ViewPresentor)

function OriginagehudlistViewPresentor:ctor()
	OriginagehudlistViewPresentor.super.ctor(self)
end

function OriginagehudlistViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginagehudlistViewPresentor:dependWhatResources()
	return {
		"ui/views/originage/originagehudlistview.prefab"
	}
end

function OriginagehudlistViewPresentor:buildViews()
	return {
		OriginagehudlistView.New()
	}
end

return OriginagehudlistViewPresentor
