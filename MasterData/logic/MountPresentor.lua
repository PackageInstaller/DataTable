-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mount/view/MountPresentor.lua

module("logic.extensions.mount.view.MountPresentor", package.seeall)

local MountPresentor = class("MountPresentor", ViewWithGuidePresentor)

MountPresentor.MountViewBkgView = "ui/views/mount/mountviewbkgview.prefab"

function MountPresentor:ctor()
	MountPresentor.super.ctor(self)
end

function MountPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MountPresentor:dependWhatResources()
	return {
		"ui/views/mount/mountview.prefab",
		MountPresentor.MountViewBkgView
	}
end

function MountPresentor:getTempResources()
	local avatarMo = DressModel.instance:getAvatarMoByOrigin(SceneMainPlayer.instance.userVar)

	return avatarMo:getAssetsList(AvatarType.UI)
end

function MountPresentor:buildViews()
	return {
		MountView.New()
	}
end

return MountPresentor
