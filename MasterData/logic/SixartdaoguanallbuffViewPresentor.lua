-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/view/SixartdaoguanallbuffViewPresentor.lua

module("logic.extensions.sixartdaoguan.view.SixartdaoguanallbuffViewPresentor", package.seeall)

local SixartdaoguanallbuffViewPresentor = class("SixartdaoguanallbuffViewPresentor", ViewPresentor)

function SixartdaoguanallbuffViewPresentor:ctor()
	SixartdaoguanallbuffViewPresentor.super.ctor(self)
end

function SixartdaoguanallbuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SixartdaoguanallbuffViewPresentor:dependWhatResources()
	return {
		"ui/views/sixartdaoguan/sixartdaoguanallbuffview.prefab"
	}
end

function SixartdaoguanallbuffViewPresentor:buildViews()
	return {
		SixartdaoguanallbuffView.New()
	}
end

return SixartdaoguanallbuffViewPresentor
