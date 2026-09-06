-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/view/copy/DivineluoshiqiselectViewPresentor.lua

module("logic.extensions.xiunuobrotherhood.view.copy.DivineluoshiqiselectViewPresentor", package.seeall)

local DivineluoshiqiselectViewPresentor = class("DivineluoshiqiselectViewPresentor", ViewPresentor)

function DivineluoshiqiselectViewPresentor:ctor()
	DivineluoshiqiselectViewPresentor.super.ctor(self)
end

function DivineluoshiqiselectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineluoshiqiselectViewPresentor:dependWhatResources()
	return {
		"ui/views/xiunuobrotherhood/copy/divineluoshiqiselectview.prefab"
	}
end

function DivineluoshiqiselectViewPresentor:buildViews()
	return {
		DivineluoshiqiselectView.New()
	}
end

return DivineluoshiqiselectViewPresentor
