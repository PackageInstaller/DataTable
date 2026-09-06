-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangzhengli/view/ChuangzhenglimainViewPresentor.lua

module("logic.extensions.chuangzhengli.view.ChuangzhenglimainViewPresentor", package.seeall)

local ChuangzhenglimainViewPresentor = class("ChuangzhenglimainViewPresentor", ViewPresentor)

function ChuangzhenglimainViewPresentor:ctor()
	ChuangzhenglimainViewPresentor.super.ctor(self)
end

function ChuangzhenglimainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChuangzhenglimainViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangzhengli/chuangzhenglimainview.prefab"
	}
end

function ChuangzhenglimainViewPresentor:buildViews()
	return {
		ChuangzhenglimainView.New()
	}
end

return ChuangzhenglimainViewPresentor
