-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tianmanking/TianmankingcontractViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.tianmanking.TianmankingcontractViewPresentor", package.seeall)

local TianmankingcontractViewPresentor = class("TianmankingcontractViewPresentor", ViewPresentor)

function TianmankingcontractViewPresentor:ctor()
	TianmankingcontractViewPresentor.super.ctor(self)
end

function TianmankingcontractViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TianmankingcontractViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/tianmanking/tianmankingcontractview.prefab"
	}
end

function TianmankingcontractViewPresentor:buildViews()
	return {
		TianmankingcontractView.New()
	}
end

return TianmankingcontractViewPresentor
