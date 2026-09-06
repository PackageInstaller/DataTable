-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetuntian/view/DivineTunTianExtFightendViewPresentor.lua

module("logic.extensions.divinetuntian.view.DivineTunTianExtFightendViewPresentor", package.seeall)

local DivineTunTianExtFightendViewPresentor = class("DivineTunTianExtFightendViewPresentor", ViewPresentor)

function DivineTunTianExtFightendViewPresentor:ctor()
	DivineTunTianExtFightendViewPresentor.super.ctor(self)
end

function DivineTunTianExtFightendViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineTunTianExtFightendViewPresentor:dependWhatResources()
	return {
		"ui/views/divinetuntian/divinetuntianextfightendview.prefab"
	}
end

function DivineTunTianExtFightendViewPresentor:buildViews()
	return {
		DivineTunTianExtFightendView.New()
	}
end

return DivineTunTianExtFightendViewPresentor
