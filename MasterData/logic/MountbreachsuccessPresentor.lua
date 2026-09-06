-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mount/view/MountbreachsuccessPresentor.lua

module("logic.extensions.mount.view.MountbreachsuccessPresentor", package.seeall)

local MountbreachsuccessPresentor = class("MountbreachsuccessPresentor", ViewPresentor)

function MountbreachsuccessPresentor:ctor()
	MountbreachsuccessPresentor.super.ctor(self)
end

function MountbreachsuccessPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MountbreachsuccessPresentor:dependWhatResources()
	return {
		"ui/views/mount/mountbreachsuccessview.prefab"
	}
end

function MountbreachsuccessPresentor:buildViews()
	return {
		MountbreachsuccessView.New()
	}
end

return MountbreachsuccessPresentor
