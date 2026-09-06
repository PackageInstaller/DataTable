-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/headitem/view/HeadalertViewPresentor.lua

module("logic.extensions.headitem.view.HeadalertViewPresentor", package.seeall)

local HeadalertViewPresentor = class("HeadalertViewPresentor", ViewPresentor)

function HeadalertViewPresentor:ctor()
	HeadalertViewPresentor.super.ctor(self)
end

function HeadalertViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HeadalertViewPresentor:dependWhatResources()
	return {
		"ui/views/headitem/headalertview.prefab"
	}
end

function HeadalertViewPresentor:buildViews()
	return {
		HeadalertView.New()
	}
end

return HeadalertViewPresentor
