-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magiccontest/view/MagicContestBuffViewPresentor.lua

module("logic.extensions.magiccontest.view.MagicContestBuffViewPresentor", package.seeall)

local MagicContestBuffViewPresentor = class("MagicContestBuffViewPresentor", ViewPresentor)

function MagicContestBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MagicContestBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/magiccontest/magiccontestbuffview.prefab"
	}
end

function MagicContestBuffViewPresentor:buildViews()
	return {
		MagicContestBuffView.New()
	}
end

return MagicContestBuffViewPresentor
