-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaixinmmclg/view/OriginAiXinMMClgTipViewPresentor.lua

module("logic.extensions.originaixinmmclg.view.OriginAiXinMMClgTipViewPresentor", package.seeall)

local OriginAiXinMMClgTipViewPresentor = class("OriginAiXinMMClgTipViewPresentor", ViewPresentor)

function OriginAiXinMMClgTipViewPresentor:ctor()
	OriginAiXinMMClgTipViewPresentor.super.ctor(self)
end

function OriginAiXinMMClgTipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginAiXinMMClgTipViewPresentor:dependWhatResources()
	return {
		"ui/views/kingspacedragon/copy/divineymjdchangetipview.prefab"
	}
end

function OriginAiXinMMClgTipViewPresentor:buildViews()
	return {
		OriginAiXinMMClgTipView.New()
	}
end

return OriginAiXinMMClgTipViewPresentor
