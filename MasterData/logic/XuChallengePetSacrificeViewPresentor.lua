-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xuchallenge/view/XuChallengePetSacrificeViewPresentor.lua

module("logic.extensions.xuchallenge.view.XuChallengePetSacrificeViewPresentor", package.seeall)

local XuChallengePetSacrificeViewPresentor = class("XuChallengePetSacrificeViewPresentor", ViewPresentor)

function XuChallengePetSacrificeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function XuChallengePetSacrificeViewPresentor:dependWhatResources()
	return {
		"ui/views/xuchallenge/xuchallengepetsacrificeview.prefab"
	}
end

function XuChallengePetSacrificeViewPresentor:buildViews()
	return {
		XuChallengePetSacrificeView.New()
	}
end

return XuChallengePetSacrificeViewPresentor
