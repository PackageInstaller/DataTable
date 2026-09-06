-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialcontestfinalallplayerViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialcontestfinalallplayerViewPresentor", package.seeall)

local MartialcontestfinalallplayerViewPresentor = class("MartialcontestfinalallplayerViewPresentor", ViewPresentor)

function MartialcontestfinalallplayerViewPresentor:ctor()
	MartialcontestfinalallplayerViewPresentor.super.ctor(self)
end

function MartialcontestfinalallplayerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MartialcontestfinalallplayerViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestfinalallplayerview.prefab"
	}
end

function MartialcontestfinalallplayerViewPresentor:buildViews()
	return {
		MartialcontestfinalallplayerView.New()
	}
end

return MartialcontestfinalallplayerViewPresentor
