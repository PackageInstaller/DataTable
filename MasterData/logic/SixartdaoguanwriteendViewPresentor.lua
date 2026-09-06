-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/view/SixartdaoguanwriteendViewPresentor.lua

module("logic.extensions.sixartdaoguan.view.SixartdaoguanwriteendViewPresentor", package.seeall)

local SixartdaoguanwriteendViewPresentor = class("SixartdaoguanwriteendViewPresentor", ViewPresentor)

function SixartdaoguanwriteendViewPresentor:ctor()
	SixartdaoguanwriteendViewPresentor.super.ctor(self)
end

function SixartdaoguanwriteendViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SixartdaoguanwriteendViewPresentor:dependWhatResources()
	return {
		"ui/views/sixartdaoguan/sixartdaoguanwriteendview.prefab"
	}
end

function SixartdaoguanwriteendViewPresentor:buildViews()
	return {
		SixartdaoguanwriteendView.New()
	}
end

return SixartdaoguanwriteendViewPresentor
