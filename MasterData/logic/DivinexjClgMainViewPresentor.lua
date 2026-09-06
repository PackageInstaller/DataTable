-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexingjiangclg/view/DivinexjClgMainViewPresentor.lua

module("logic.extensions.divinexingjiangclg.view.DivinexjClgMainViewPresentor", package.seeall)

local DivinexjClgMainViewPresentor = class("DivinexjClgMainViewPresentor", ViewPresentor)

function DivinexjClgMainViewPresentor:ctor()
	DivinexjClgMainViewPresentor.super.ctor(self)
end

function DivinexjClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinexjClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinexingjiangclg/divinexjclgmainview.prefab"
	}
end

function DivinexjClgMainViewPresentor:buildViews()
	return {
		DivinexjClgMainView.New()
	}
end

return DivinexjClgMainViewPresentor
