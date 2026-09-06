-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/FiredragonlotteryViewPresentor.lua

module("logic.extensions.infinitefuture.view.FiredragonlotteryViewPresentor", package.seeall)

local FiredragonlotteryViewPresentor = class("FiredragonlotteryViewPresentor", ViewPresentor)

function FiredragonlotteryViewPresentor:ctor()
	FiredragonlotteryViewPresentor.super.ctor(self)
end

function FiredragonlotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FiredragonlotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/firedragon/firedragonlotteryview.prefab"
	}
end

function FiredragonlotteryViewPresentor:buildViews()
	return {
		FiredragonlotteryView.New()
	}
end

return FiredragonlotteryViewPresentor
