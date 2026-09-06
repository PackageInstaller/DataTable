-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magiccontest/view/MagicContestBuffPreViewPresentor.lua

module("logic.extensions.magiccontest.view.MagicContestBuffPreViewPresentor", package.seeall)

local MagicContestBuffPreViewPresentor = class("MagicContestBuffPreViewPresentor", ViewPresentor)

function MagicContestBuffPreViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MagicContestBuffPreViewPresentor:dependWhatResources()
	return {
		"ui/views/magiccontest/magiccontestbuffpreview.prefab"
	}
end

function MagicContestBuffPreViewPresentor:buildViews()
	return {
		MagicContestBuffPreView.New()
	}
end

return MagicContestBuffPreViewPresentor
