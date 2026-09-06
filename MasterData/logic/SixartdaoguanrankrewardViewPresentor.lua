-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/view/SixartdaoguanrankrewardViewPresentor.lua

module("logic.extensions.sixartdaoguan.view.SixartdaoguanrankrewardViewPresentor", package.seeall)

local SixartdaoguanrankrewardViewPresentor = class("SixartdaoguanrankrewardViewPresentor", ViewPresentor)

function SixartdaoguanrankrewardViewPresentor:ctor()
	SixartdaoguanrankrewardViewPresentor.super.ctor(self)
end

function SixartdaoguanrankrewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SixartdaoguanrankrewardViewPresentor:dependWhatResources()
	return {
		"ui/views/sixartdaoguan/sixartdaoguanrankrewardview.prefab"
	}
end

function SixartdaoguanrankrewardViewPresentor:buildViews()
	return {
		SixartdaoguanrankrewardView.New()
	}
end

return SixartdaoguanrankrewardViewPresentor
