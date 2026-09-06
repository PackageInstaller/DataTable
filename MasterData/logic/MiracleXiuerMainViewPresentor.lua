-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclexiuer/view/MiracleXiuerMainViewPresentor.lua

module("logic.extensions.miraclexiuer.view.MiracleXiuerMainViewPresentor", package.seeall)

local MiracleXiuerMainViewPresentor = class("MiracleXiuerMainViewPresentor", ViewPresentor)

function MiracleXiuerMainViewPresentor:ctor()
	MiracleXiuerMainViewPresentor.super.ctor(self)
end

function MiracleXiuerMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiracleXiuerMainViewPresentor:dependWhatResources()
	return {
		"ui/views/miraclexiuer/miraclexiuermainview.prefab"
	}
end

function MiracleXiuerMainViewPresentor:buildViews()
	return {
		MiracleXiuerMainView.New()
	}
end

return MiracleXiuerMainViewPresentor
