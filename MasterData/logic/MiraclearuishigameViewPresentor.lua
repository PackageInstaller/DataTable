-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/view/copy/MiraclearuishigameViewPresentor.lua

module("logic.extensions.xiunuobrotherhood.view.copy.MiraclearuishigameViewPresentor", package.seeall)

local MiraclearuishigameViewPresentor = class("MiraclearuishigameViewPresentor", ViewPresentor)

function MiraclearuishigameViewPresentor:ctor()
	MiraclearuishigameViewPresentor.super.ctor(self)
end

function MiraclearuishigameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiraclearuishigameViewPresentor:dependWhatResources()
	local resources = {
		"ui/views/xiunuobrotherhood/copy/miraclearuishigameview.prefab"
	}

	table.insertto(resources, XiuNuoBrotherhoodGameViewPresentor.BaseResPaths)

	return resources
end

function MiraclearuishigameViewPresentor:buildViews()
	return {
		MiraclearuishigameView.New()
	}
end

return MiraclearuishigameViewPresentor
