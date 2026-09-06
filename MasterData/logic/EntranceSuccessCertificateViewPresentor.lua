-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/entrance/view/EntranceSuccessCertificateViewPresentor.lua

module("logic.extensions.entrance.view.EntrancecertificateViewPresentor", package.seeall)

local EntrancecertificateViewPresentor = class("EntrancecertificateViewPresentor", ViewWithGuidePresentor)

function EntrancecertificateViewPresentor:ctor()
	EntrancecertificateViewPresentor.super.ctor(self)
end

function EntrancecertificateViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EntrancecertificateViewPresentor:dependWhatResources()
	return {
		"ui/views/entrance/entrancecertificateview.prefab"
	}
end

function EntrancecertificateViewPresentor:buildViews()
	return {
		EntranceSuccessCertificateView.New()
	}
end

return EntrancecertificateViewPresentor
