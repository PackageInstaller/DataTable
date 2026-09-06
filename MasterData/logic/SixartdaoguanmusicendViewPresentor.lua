-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/view/SixartdaoguanmusicendViewPresentor.lua

module("logic.extensions.sixartdaoguan.view.SixartdaoguanmusicendViewPresentor", package.seeall)

local SixartdaoguanmusicendViewPresentor = class("SixartdaoguanmusicendViewPresentor", ViewPresentor)

function SixartdaoguanmusicendViewPresentor:ctor()
	SixartdaoguanmusicendViewPresentor.super.ctor(self)
end

function SixartdaoguanmusicendViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SixartdaoguanmusicendViewPresentor:dependWhatResources()
	return {
		"ui/views/sixartdaoguan/sixartdaoguanmusicendview.prefab"
	}
end

function SixartdaoguanmusicendViewPresentor:buildViews()
	return {
		SixartdaoguanmusicendView.New()
	}
end

return SixartdaoguanmusicendViewPresentor
