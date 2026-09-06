-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xuchallenge/view/XuChallengePetBindViewPresentor.lua

module("logic.extensions.xuchallenge.view.XuChallengePetBindViewPresentor", package.seeall)

local XuChallengePetBindViewPresentor = class("XuChallengePetBindViewPresentor", ViewPresentor)

function XuChallengePetBindViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function XuChallengePetBindViewPresentor:dependWhatResources()
	return {
		"ui/views/xuchallenge/xuchallengepetbindview.prefab"
	}
end

function XuChallengePetBindViewPresentor:buildViews()
	return {
		XuChallengePetBindView.New()
	}
end

return XuChallengePetBindViewPresentor
