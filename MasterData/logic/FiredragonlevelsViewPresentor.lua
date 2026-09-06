-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/FiredragonlevelsViewPresentor.lua

module("logic.extensions.infinitefuture.view.FiredragonlevelsViewPresentor", package.seeall)

local FiredragonlevelsViewPresentor = class("FiredragonlevelsViewPresentor", ViewPresentor)

function FiredragonlevelsViewPresentor:ctor()
	FiredragonlevelsViewPresentor.super.ctor(self)
end

function FiredragonlevelsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FiredragonlevelsViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/firedragon/firedragonlevelsview.prefab"
	}
end

function FiredragonlevelsViewPresentor:buildViews()
	return {
		FiredragonlevelsView.New()
	}
end

return FiredragonlevelsViewPresentor
