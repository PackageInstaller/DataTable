-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydarkmm/view/youngorder/YoungOrderChallengeViewPresentor.lua

module("logic.extensions.holydarkmm.view.youngorder.YoungOrderChallengeViewPresentor", package.seeall)

local YoungOrderChallengeViewPresentor = class("YoungOrderChallengeViewPresentor", HolyDarkMMChallengeViewPresentor)

function YoungOrderChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/holydarkmm/youngorder/youngorderchallengeview.prefab"
	}
end

function YoungOrderChallengeViewPresentor:buildViews()
	return {
		YoungOrderChallengeView.New()
	}
end

return YoungOrderChallengeViewPresentor
