-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/FiredragonViewPresentor.lua

module("logic.extensions.infinitefuture.view.FiredragonViewPresentor", package.seeall)

local FiredragonViewPresentor = class("FiredragonViewPresentor", ViewPresentor)

function FiredragonViewPresentor:ctor()
	FiredragonViewPresentor.super.ctor(self)
end

function FiredragonViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FiredragonViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/firedragon/firedragonview.prefab"
	}
end

function FiredragonViewPresentor:buildViews()
	return {
		FiredragonView.New()
	}
end

return FiredragonViewPresentor
