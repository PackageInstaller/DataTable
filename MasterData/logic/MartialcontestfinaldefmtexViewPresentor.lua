-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialcontestfinaldefmtexViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialcontestfinaldefmtexViewPresentor", package.seeall)

local MartialcontestfinaldefmtexViewPresentor = class("MartialcontestfinaldefmtexViewPresentor", ViewPresentor)

function MartialcontestfinaldefmtexViewPresentor:ctor()
	MartialcontestfinaldefmtexViewPresentor.super.ctor(self)
end

function MartialcontestfinaldefmtexViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MartialcontestfinaldefmtexViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestfinaldefmtexview.prefab"
	}
end

function MartialcontestfinaldefmtexViewPresentor:buildViews()
	return {
		MartialcontestfinaldefmtexView.New()
	}
end

return MartialcontestfinaldefmtexViewPresentor
