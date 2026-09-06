-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zijiedatatransfer/view/ZijiedatawebViewPresentor.lua

module("logic.extensions.zijiedatatransfer.view.ZijiedatawebViewPresentor", package.seeall)

local ZijiedatawebViewPresentor = class("ZijiedatawebViewPresentor", ViewPresentor)

function ZijiedatawebViewPresentor:ctor()
	ZijiedatawebViewPresentor.super.ctor(self)
end

function ZijiedatawebViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ZijiedatawebViewPresentor:dependWhatResources()
	return {
		"ui/views/zijiedatatransfer/zijiedatawebview.prefab"
	}
end

function ZijiedatawebViewPresentor:buildViews()
	return {
		ZijiedatawebView.New()
	}
end

return ZijiedatawebViewPresentor
