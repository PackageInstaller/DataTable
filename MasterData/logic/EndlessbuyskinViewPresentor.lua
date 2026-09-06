-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/EndlessbuyskinViewPresentor.lua

module("logic.extensions.infinitefuture.view.EndlessbuyskinViewPresentor", package.seeall)

local EndlessbuyskinViewPresentor = class("EndlessbuyskinViewPresentor", ViewPresentor)

function EndlessbuyskinViewPresentor:ctor()
	EndlessbuyskinViewPresentor.super.ctor(self)
end

function EndlessbuyskinViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EndlessbuyskinViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/firedragon/firedragonbuyskinview.prefab"
	}
end

function EndlessbuyskinViewPresentor:buildViews()
	return {
		EndlessbuyskinView.New()
	}
end

return EndlessbuyskinViewPresentor
