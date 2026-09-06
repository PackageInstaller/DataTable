-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/view/copy/DivineluoshiqigameViewPresentor.lua

module("logic.extensions.xiunuobrotherhood.view.copy.DivineluoshiqigameViewPresentor", package.seeall)

local DivineluoshiqigameViewPresentor = class("DivineluoshiqigameViewPresentor", ViewPresentor)

function DivineluoshiqigameViewPresentor:ctor()
	DivineluoshiqigameViewPresentor.super.ctor(self)
end

function DivineluoshiqigameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineluoshiqigameViewPresentor:dependWhatResources()
	local resources = {
		"ui/views/xiunuobrotherhood/copy/divineluoshiqigameview.prefab"
	}

	table.insertto(resources, XiuNuoBrotherhoodGameViewPresentor.BaseResPaths)

	return resources
end

function DivineluoshiqigameViewPresentor:buildViews()
	return {
		DivineluoshiqigameView.New()
	}
end

return DivineluoshiqigameViewPresentor
