-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicimprove/view/PsychicLeaseViewPresentor.lua

module("logic.extensions.psychicimprove.view.PsychicLeaseViewPresentor", package.seeall)

local PsychicLeaseViewPresentor = class("PsychicLeaseViewPresentor", ViewPresentor)

function PsychicLeaseViewPresentor:ctor()
	PsychicLeaseViewPresentor.super.ctor(self)
end

function PsychicLeaseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PsychicLeaseViewPresentor:dependWhatResources()
	return {
		"ui/views/psychicimprove/psychicleaseview.prefab"
	}
end

function PsychicLeaseViewPresentor:buildViews()
	return {
		PsychicLeaseView.New()
	}
end

return PsychicLeaseViewPresentor
