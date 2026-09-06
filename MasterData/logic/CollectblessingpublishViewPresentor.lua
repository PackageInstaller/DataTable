-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/CollectblessingpublishViewPresentor.lua

module("logic.extensions.birthdaywishes.view.CollectblessingpublishViewPresentor", package.seeall)

local CollectblessingpublishViewPresentor = class("CollectblessingpublishViewPresentor", ViewPresentor)

function CollectblessingpublishViewPresentor:ctor()
	CollectblessingpublishViewPresentor.super.ctor(self)
end

function CollectblessingpublishViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CollectblessingpublishViewPresentor:dependWhatResources()
	return {
		"ui/views/collectblessing/collectblessingpublishview.prefab"
	}
end

function CollectblessingpublishViewPresentor:buildViews()
	return {
		CollectBlessingPublishView.New()
	}
end

return CollectblessingpublishViewPresentor
