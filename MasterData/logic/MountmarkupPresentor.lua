-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mount/view/MountmarkupPresentor.lua

module("logic.extensions.mount.view.MountmarkupPresentor", package.seeall)

local MountmarkupPresentor = class("MountmarkupPresentor", ViewPresentor)

function MountmarkupPresentor:ctor()
	MountmarkupPresentor.super.ctor(self)
end

function MountmarkupPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MountmarkupPresentor:dependWhatResources()
	return {
		"ui/views/mount/mountmarkupview.prefab"
	}
end

function MountmarkupPresentor:buildViews()
	return {
		MountmarkupView.New()
	}
end

return MountmarkupPresentor
