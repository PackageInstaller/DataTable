-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mirrortrial/view/MirrortrialbuyscoreViewPresentor.lua

module("logic.extensions.mirrortrial.view.MirrortrialbuyscoreViewPresentor", package.seeall)

local MirrortrialbuyscoreViewPresentor = class("MirrortrialbuyscoreViewPresentor", ViewPresentor)

function MirrortrialbuyscoreViewPresentor:ctor()
	MirrortrialbuyscoreViewPresentor.super.ctor(self)
end

function MirrortrialbuyscoreViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function MirrortrialbuyscoreViewPresentor:dependWhatResources()
	return {
		"ui/views/mirrortrial/mirrortrialbuyscoreview.prefab"
	}
end

function MirrortrialbuyscoreViewPresentor:buildViews()
	return {
		MirrortrialbuyscoreView.New()
	}
end

return MirrortrialbuyscoreViewPresentor
