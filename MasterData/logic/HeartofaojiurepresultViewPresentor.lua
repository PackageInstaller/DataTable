-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofaojiurep/view/HeartofaojiurepresultViewPresentor.lua

module("logic.extensions.heartofaojiurep.view.HeartofaojiurepresultViewPresentor", package.seeall)

local HeartofaojiurepresultViewPresentor = class("HeartofaojiurepresultViewPresentor", ViewPresentor)

function HeartofaojiurepresultViewPresentor:ctor()
	HeartofaojiurepresultViewPresentor.super.ctor(self)
end

function HeartofaojiurepresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HeartofaojiurepresultViewPresentor:dependWhatResources()
	return {
		"ui/views/heartofaojiurep/heartofaojiurepresultview.prefab"
	}
end

function HeartofaojiurepresultViewPresentor:buildViews()
	return {
		HeartofaojiurepresultView.New()
	}
end

return HeartofaojiurepresultViewPresentor
