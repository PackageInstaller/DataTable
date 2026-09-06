-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhotbloodmmclg/view/OriginHotBloodMMClgMainViewPresentor.lua

module("logic.extensions.originhotbloodmmclg.view.OriginHotBloodMMClgMainViewPresentor", package.seeall)

local OriginHotBloodMMClgMainViewPresentor = class("OriginHotBloodMMClgMainViewPresentor", ViewPresentor)

function OriginHotBloodMMClgMainViewPresentor:ctor()
	OriginHotBloodMMClgMainViewPresentor.super.ctor(self)
end

function OriginHotBloodMMClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginHotBloodMMClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/originhotbloodmmclg/originhotbloodmmclgmainview.prefab"
	}
end

function OriginHotBloodMMClgMainViewPresentor:buildViews()
	return {
		OriginHotBloodMMClgMainView.New()
	}
end

return OriginHotBloodMMClgMainViewPresentor
