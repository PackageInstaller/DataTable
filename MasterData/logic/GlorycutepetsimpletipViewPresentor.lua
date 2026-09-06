-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/view/GlorycutepetsimpletipViewPresentor.lua

module("logic.extensions.glorybattle.view.GlorycutepetsimpletipViewPresentor", package.seeall)

local GlorycutepetsimpletipViewPresentor = class("GlorycutepetsimpletipViewPresentor", ViewPresentor)

function GlorycutepetsimpletipViewPresentor:ctor()
	GlorycutepetsimpletipViewPresentor.super.ctor(self)
end

function GlorycutepetsimpletipViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GlorycutepetsimpletipViewPresentor:dependWhatResources()
	return {
		"ui/views/glorybattle/glorycutepetsimpletipview.prefab"
	}
end

function GlorycutepetsimpletipViewPresentor:buildViews()
	return {
		GlorycutepetsimpletipView.New()
	}
end

function GlorycutepetsimpletipViewPresentor:setGrayMaskGO(grayMaskGO)
	GlorycutepetsimpletipViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	goutil.setActive(grayMaskGO, false)
end

return GlorycutepetsimpletipViewPresentor
