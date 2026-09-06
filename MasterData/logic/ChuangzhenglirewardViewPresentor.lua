-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangzhengli/view/ChuangzhenglirewardViewPresentor.lua

module("logic.extensions.chuangzhengli.view.ChuangzhenglirewardViewPresentor", package.seeall)

local ChuangzhenglirewardViewPresentor = class("ChuangzhenglirewardViewPresentor", ViewPresentor)

function ChuangzhenglirewardViewPresentor:ctor()
	ChuangzhenglirewardViewPresentor.super.ctor(self)
end

function ChuangzhenglirewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ChuangzhenglirewardViewPresentor:dependWhatResources()
	return {
		"ui/views/chuangzhengli/chuangzhenglirewardview.prefab"
	}
end

function ChuangzhenglirewardViewPresentor:buildViews()
	return {
		ChuangzhenglirewardView.New()
	}
end

return ChuangzhenglirewardViewPresentor
