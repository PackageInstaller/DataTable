-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclemultiplied/view/MiracleMultipliedMainViewPresentor.lua

module("logic.extensions.miraclemultiplied.view.MiracleMultipliedMainViewPresentor", package.seeall)

local MiracleMultipliedMainViewPresentor = class("MiracleMultipliedMainViewPresentor", ViewPresentor)

function MiracleMultipliedMainViewPresentor:ctor()
	MiracleMultipliedMainViewPresentor.super.ctor(self)
end

function MiracleMultipliedMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiracleMultipliedMainViewPresentor:dependWhatResources()
	return {
		"ui/views/miraclemultiplied/miraclemultipliedmainview.prefab"
	}
end

function MiracleMultipliedMainViewPresentor:buildViews()
	return {
		MiracleMultipliedMainView.New()
	}
end

return MiracleMultipliedMainViewPresentor
