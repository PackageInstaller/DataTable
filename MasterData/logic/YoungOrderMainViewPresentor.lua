-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydarkmm/view/youngorder/YoungOrderMainViewPresentor.lua

module("logic.extensions.holydarkmm.view.youngorder.YoungOrderMainViewPresentor", package.seeall)

local YoungOrderMainViewPresentor = class("YoungOrderMainViewPresentor", HolyDarkMMMainViewPresentor)

function YoungOrderMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/holydarkmm/youngorder/youngordermainview.prefab"
	}
end

function YoungOrderMainViewPresentor:buildViews()
	return {
		YoungOrderMainView.New()
	}
end

return YoungOrderMainViewPresentor
