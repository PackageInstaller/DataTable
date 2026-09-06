-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/view/SixartdaoguanyueextViewPresentor.lua

module("logic.extensions.sixartdaoguan.view.SixartdaoguanyueextViewPresentor", package.seeall)

local SixartdaoguanyueextViewPresentor = class("SixartdaoguanyueextViewPresentor", ViewPresentor)

function SixartdaoguanyueextViewPresentor:ctor()
	SixartdaoguanyueextViewPresentor.super.ctor(self)
end

function SixartdaoguanyueextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SixartdaoguanyueextViewPresentor:dependWhatResources()
	return {
		"ui/views/sixartdaoguan/sixartdaoguanyueextview.prefab"
	}
end

function SixartdaoguanyueextViewPresentor:buildViews()
	return {
		SixartdaoguanyueextView.New()
	}
end

function SixartdaoguanyueextViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SixartdaoguanyueextViewPresentor
