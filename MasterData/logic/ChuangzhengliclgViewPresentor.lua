-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangzhengli/view/ChuangzhengliclgViewPresentor.lua

module("logic.extensions.chuangzhengli.view.ChuangzhengliclgViewPresentor", package.seeall)

local ChuangzhengliclgViewPresentor = class("ChuangzhengliclgViewPresentor", ViewPresentor)

function ChuangzhengliclgViewPresentor:ctor()
	ChuangzhengliclgViewPresentor.super.ctor(self)
end

function ChuangzhengliclgViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChuangzhengliclgViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangzhengli/chuangzhengliclgview.prefab"
	}
end

function ChuangzhengliclgViewPresentor:buildViews()
	return {
		ChuangzhengliclgView.New()
	}
end

return ChuangzhengliclgViewPresentor
