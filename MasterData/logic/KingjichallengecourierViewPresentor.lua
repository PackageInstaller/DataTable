-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingjichallenge/view/KingjichallengecourierViewPresentor.lua

module("logic.extensions.kingjichallenge.view.KingjichallengecourierViewPresentor", package.seeall)

local KingjichallengecourierViewPresentor = class("KingjichallengecourierViewPresentor", ViewPresentor)

function KingjichallengecourierViewPresentor:ctor()
	KingjichallengecourierViewPresentor.super.ctor(self)
end

function KingjichallengecourierViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingjichallengecourierViewPresentor:dependWhatResources()
	return {
		"ui/views/kingjichallenge/kingjichallengecourierview.prefab"
	}
end

function KingjichallengecourierViewPresentor:buildViews()
	return {
		KingjichallengecourierView.New()
	}
end

return KingjichallengecourierViewPresentor
