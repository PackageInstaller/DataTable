-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialcontestfinalViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialcontestfinalViewPresentor", package.seeall)

local MartialcontestfinalViewPresentor = class("MartialcontestfinalViewPresentor", ViewPresentor)

function MartialcontestfinalViewPresentor:ctor()
	MartialcontestfinalViewPresentor.super.ctor(self)
end

function MartialcontestfinalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MartialcontestfinalViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestfinalview.prefab"
	}
end

function MartialcontestfinalViewPresentor:buildViews()
	return {
		MartialcontestfinalView.New()
	}
end

return MartialcontestfinalViewPresentor
