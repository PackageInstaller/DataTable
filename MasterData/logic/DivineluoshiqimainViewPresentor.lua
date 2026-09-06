-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/view/copy/DivineluoshiqimainViewPresentor.lua

module("logic.extensions.xiunuobrotherhood.view.copy.DivineluoshiqimainViewPresentor", package.seeall)

local DivineluoshiqimainViewPresentor = class("DivineluoshiqimainViewPresentor", ViewPresentor)

function DivineluoshiqimainViewPresentor:ctor()
	DivineluoshiqimainViewPresentor.super.ctor(self)
end

function DivineluoshiqimainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineluoshiqimainViewPresentor:dependWhatResources()
	return {
		"ui/views/xiunuobrotherhood/copy/divineluoshiqimainview.prefab"
	}
end

function DivineluoshiqimainViewPresentor:buildViews()
	return {
		DivineluoshiqimainView.New()
	}
end

return DivineluoshiqimainViewPresentor
