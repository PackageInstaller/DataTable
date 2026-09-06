-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexingjiangclg/view/DivinexjClgInfoViewPresentor.lua

module("logic.extensions.divinexingjiangclg.view.DivinexjClgInfoViewPresentor", package.seeall)

local DivinexjClgInfoViewPresentor = class("DivinexjClgInfoViewPresentor", ViewPresentor)

function DivinexjClgInfoViewPresentor:ctor()
	DivinexjClgInfoViewPresentor.super.ctor(self)
end

function DivinexjClgInfoViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinexjClgInfoViewPresentor:dependWhatResources()
	return {
		"ui/views/divinexingjiangclg/divinexjclginfoview.prefab"
	}
end

function DivinexjClgInfoViewPresentor:buildViews()
	return {
		DivinexjClgInfoView.New()
	}
end

return DivinexjClgInfoViewPresentor
