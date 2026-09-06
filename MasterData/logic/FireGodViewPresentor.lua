-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/paladinlottery/FireGodViewPresentor.lua

module("logic.extensions.lottery.view.paladin.FireGodViewPresentor", package.seeall)

local FireGodViewPresentor = class("FireGodViewPresentor", ViewPresentor)

function FireGodViewPresentor:ctor()
	FireGodViewPresentor.super.ctor(self)
end

function FireGodViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FireGodViewPresentor:dependWhatResources()
	return {
		"ui/views/paladinlottery/firegodview.prefab"
	}
end

function FireGodViewPresentor:buildViews()
	return {
		FireGodView.New()
	}
end

return FireGodViewPresentor
