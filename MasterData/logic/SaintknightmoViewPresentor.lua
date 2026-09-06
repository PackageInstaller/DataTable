-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightmo/view/SaintknightmoViewPresentor.lua

module("logic.extensions.saintknightmo.view.SaintknightmoViewPresentor", package.seeall)

local SaintknightmoViewPresentor = class("SaintknightmoViewPresentor", ViewPresentor)

function SaintknightmoViewPresentor:ctor()
	SaintknightmoViewPresentor.super.ctor(self)
end

function SaintknightmoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SaintknightmoViewPresentor:dependWhatResources()
	return {
		"ui/views/saintknightmo/saintknightmoview.prefab"
	}
end

function SaintknightmoViewPresentor:buildViews()
	return {
		SaintknightmoView.New()
	}
end

return SaintknightmoViewPresentor
