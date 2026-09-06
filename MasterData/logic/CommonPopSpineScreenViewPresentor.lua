-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/view/CommonPopSpineScreenViewPresentor.lua

module("logic.extensions.spineinterface.view.CommonPopSpineScreenViewPresentor", package.seeall)

local CommonPopSpineScreenViewPresentor = class("CommonPopSpineScreenViewPresentor", ViewPresentor)

function CommonPopSpineScreenViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CommonPopSpineScreenViewPresentor:dependWhatResources()
	return {
		"ui/views/spineinterface/commonpopspinescreenview.prefab"
	}
end

function CommonPopSpineScreenViewPresentor:buildViews()
	return {
		CommonPopSpineScreenView.New()
	}
end

function CommonPopSpineScreenViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return CommonPopSpineScreenViewPresentor
