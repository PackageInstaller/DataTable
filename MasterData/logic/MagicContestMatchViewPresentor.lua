-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magiccontest/view/MagicContestMatchViewPresentor.lua

module("logic.extensions.magiccontest.view.MagicContestMatchViewPresentor", package.seeall)

local MagicContestMatchViewPresentor = class("MagicContestMatchViewPresentor", ViewPresentor)

function MagicContestMatchViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MagicContestMatchViewPresentor:dependWhatResources()
	return {
		"ui/views/magiccontest/magiccontestmatchview.prefab"
	}
end

function MagicContestMatchViewPresentor:buildViews()
	return {
		MagicContestMatchView.New()
	}
end

return MagicContestMatchViewPresentor
