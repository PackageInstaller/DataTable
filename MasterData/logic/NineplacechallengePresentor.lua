-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/NineplacechallengePresentor.lua

module("logic.extensions.nineplace.view.NineplacechallengePresentor", package.seeall)

local NineplacechallengePresentor = class("NineplacechallengePresentor", ViewWithGuidePresentor)

function NineplacechallengePresentor:ctor()
	NineplacechallengePresentor.super.ctor(self)
end

function NineplacechallengePresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NineplacechallengePresentor:dependWhatResources()
	return {
		"ui/views/nineplace/nineplacechallengeview.prefab"
	}
end

function NineplacechallengePresentor:buildViews()
	return {
		NineplacechallengeView.New()
	}
end

return NineplacechallengePresentor
