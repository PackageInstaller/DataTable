-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miukechallenge/view/MiukemainViewPresentor.lua

module("logic.extensions.miukechallenge.view.MiukemainViewPresentor", package.seeall)

local MiukemainViewPresentor = class("MiukemainViewPresentor", ViewPresentor)

function MiukemainViewPresentor:ctor()
	MiukemainViewPresentor.super.ctor(self)
end

function MiukemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiukemainViewPresentor:dependWhatResources()
	return {
		"ui/views/miukechallenge/miukemainview.prefab"
	}
end

function MiukemainViewPresentor:buildViews()
	return {
		MiukemainView.New()
	}
end

return MiukemainViewPresentor
