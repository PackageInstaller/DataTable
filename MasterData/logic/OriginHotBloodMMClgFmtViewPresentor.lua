-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhotbloodmmclg/view/OriginHotBloodMMClgFmtViewPresentor.lua

module("logic.extensions.originhotbloodmmclg.view.OriginHotBloodMMClgFmtViewPresentor", package.seeall)

local OriginHotBloodMMClgFmtViewPresentor = class("OriginHotBloodMMClgFmtViewPresentor", ViewPresentor)

function OriginHotBloodMMClgFmtViewPresentor:ctor()
	OriginHotBloodMMClgFmtViewPresentor.super.ctor(self)
end

function OriginHotBloodMMClgFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginHotBloodMMClgFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/originhotbloodmmclg/originhotbloodmmclgfmtview.prefab"
	}
end

function OriginHotBloodMMClgFmtViewPresentor:buildViews()
	return {
		OriginHotBloodMMClgFmtView.New()
	}
end

return OriginHotBloodMMClgFmtViewPresentor
