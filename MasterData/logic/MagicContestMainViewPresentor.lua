-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magiccontest/view/MagicContestMainViewPresentor.lua

module("logic.extensions.magiccontest.view.MagicContestMainViewPresentor", package.seeall)

local MagicContestMainViewPresentor = class("MagicContestMainViewPresentor", ViewPresentor)

function MagicContestMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MagicContestMainViewPresentor:dependWhatResources()
	return {
		"ui/views/magiccontest/magiccontestmainview.prefab"
	}
end

function MagicContestMainViewPresentor:buildViews()
	return {
		MagicContestMainView.New()
	}
end

return MagicContestMainViewPresentor
