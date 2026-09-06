-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialrecover/view/MaterialRecoverViewPresentor.lua

module("logic.extensions.materialrecover.view.MaterialRecoverViewPresentor", package.seeall)

local MaterialRecoverViewPresentor = class("MaterialRecoverViewPresentor", ViewWithGuidePresentor)

function MaterialRecoverViewPresentor:ctor()
	MaterialRecoverViewPresentor.super.ctor(self)
end

function MaterialRecoverViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MaterialRecoverViewPresentor:dependWhatResources()
	return {
		"ui/views/materialrecover/resrecoveryview.prefab"
	}
end

function MaterialRecoverViewPresentor:buildViews()
	return {
		MaterialRecoverView.New()
	}
end

function MaterialRecoverViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return MaterialRecoverViewPresentor
