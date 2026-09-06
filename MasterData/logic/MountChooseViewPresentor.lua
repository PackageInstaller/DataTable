-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mount/view/MountChooseViewPresentor.lua

module("logic.extensions.mount.view.MountChooseViewPresentor", package.seeall)

local MountChooseViewPresentor = class("MountChooseViewPresentor", ViewPresentor)

function MountChooseViewPresentor:ctor()
	MountChooseViewPresentor.super.ctor(self)
end

function MountChooseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MountChooseViewPresentor:dependWhatResources()
	return {
		"ui/views/mount/mountchooseview.prefab"
	}
end

function MountChooseViewPresentor:buildViews()
	return {
		MountChooseView.New()
	}
end

return MountChooseViewPresentor
