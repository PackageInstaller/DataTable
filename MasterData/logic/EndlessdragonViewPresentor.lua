-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/EndlessdragonViewPresentor.lua

module("logic.extensions.infinitefuture.view.EndlessdragonViewPresentor", package.seeall)

local EndlessdragonViewPresentor = class("EndlessdragonViewPresentor", ViewPresentor)

function EndlessdragonViewPresentor:ctor()
	EndlessdragonViewPresentor.super.ctor(self)
end

function EndlessdragonViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EndlessdragonViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/infinitefuture/endlessdragonview.prefab"
	}
end

function EndlessdragonViewPresentor:buildViews()
	return {
		EndlessdragonView.New()
	}
end

return EndlessdragonViewPresentor
