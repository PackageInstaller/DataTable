-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialcontestfinalrankresultViewPresentor.lua

module("logic.extensions.martialcontest.view.MartialcontestfinalrankresultViewPresentor", package.seeall)

local MartialcontestfinalrankresultViewPresentor = class("MartialcontestfinalrankresultViewPresentor", ViewPresentor)

function MartialcontestfinalrankresultViewPresentor:ctor()
	MartialcontestfinalrankresultViewPresentor.super.ctor(self)
end

function MartialcontestfinalrankresultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MartialcontestfinalrankresultViewPresentor:dependWhatResources()
	return {
		"ui/views/martialcontest/martialcontestfinalrankresultview.prefab"
	}
end

function MartialcontestfinalrankresultViewPresentor:buildViews()
	return {
		MartialcontestfinalrankresultView.New()
	}
end

return MartialcontestfinalrankresultViewPresentor
