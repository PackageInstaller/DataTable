-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/view/xiwangshennv/XiWangShenNvEnvelopeSpineScreenViewPresentor.lua

module("logic.extensions.spineinterface.view.xiwangshennv/XiWangShenNvEnvelopeSpineScreenViewPresentor", package.seeall)

local XiWangShenNvEnvelopeSpineScreenViewPresentor = class("XiWangShenNvEnvelopeSpineScreenViewPresentor", ViewPresentor)

function XiWangShenNvEnvelopeSpineScreenViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XiWangShenNvEnvelopeSpineScreenViewPresentor:dependWhatResources()
	return {
		"ui/views/spineinterface/xiwangshennvenvelopespinescreenview.prefab"
	}
end

function XiWangShenNvEnvelopeSpineScreenViewPresentor:buildViews()
	return {
		XiWangShenNvEnvelopeSpineScreenView.New()
	}
end

function XiWangShenNvEnvelopeSpineScreenViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return XiWangShenNvEnvelopeSpineScreenViewPresentor
