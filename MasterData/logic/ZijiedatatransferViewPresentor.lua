-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zijiedatatransfer/view/ZijiedatatransferViewPresentor.lua

module("logic.extensions.zijiedatatransfer.view.ZijiedatatransferViewPresentor", package.seeall)

local ZijiedatatransferViewPresentor = class("ZijiedatatransferViewPresentor", ViewPresentor)

function ZijiedatatransferViewPresentor:ctor()
	ZijiedatatransferViewPresentor.super.ctor(self)
end

function ZijiedatatransferViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ZijiedatatransferViewPresentor:dependWhatResources()
	return {
		"ui/views/zijiedatatransfer/zijiedatatransferview.prefab"
	}
end

function ZijiedatatransferViewPresentor:buildViews()
	return {
		ZijiedatatransferView.New()
	}
end

return ZijiedatatransferViewPresentor
