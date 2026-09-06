-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mount/view/MountCultivateViewPresentor.lua

module("logic.extensions.mount.view.MountCultivateViewPresentor", package.seeall)

local MountCultivateViewPresentor = class("MountCultivateViewPresentor", ViewPresentor)

function MountCultivateViewPresentor:ctor()
	MountCultivateViewPresentor.super.ctor(self)
end

function MountCultivateViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function MountCultivateViewPresentor:dependWhatResources()
	return {
		"ui/views/mount/mountcultivateview.prefab"
	}
end

function MountCultivateViewPresentor:buildViews()
	return {
		MountCultivateView.New()
	}
end

return MountCultivateViewPresentor
