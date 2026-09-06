-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zdlverify/view/ZdlVerifyActViewPresentor.lua

module("logic.extensions.zdlverify.view.ZdlVerifyActViewPresentor", package.seeall)

local ZdlVerifyActViewPresentor = class("ZdlVerifyActViewPresentor", ViewPresentor)

function ZdlVerifyActViewPresentor:ctor()
	ZdlVerifyActViewPresentor.super.ctor(self)
end

function ZdlVerifyActViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ZdlVerifyActViewPresentor:dependWhatResources()
	return {
		"ui/views/zdlverify/zdlverifyactview.prefab"
	}
end

function ZdlVerifyActViewPresentor:buildViews()
	return {
		ZdlVerifyActView.New()
	}
end

return ZdlVerifyActViewPresentor
