-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newsummonpetobtain/view/NsopPlayMusicMainViewPresentor.lua

module("logic.extensions.newsummonpetobtain.view.NsopPlayMusicMainViewPresentor", package.seeall)

local NsopPlayMusicMainViewPresentor = class("NsopPlayMusicMainViewPresentor", ViewPresentor)

function NsopPlayMusicMainViewPresentor:ctor()
	NsopPlayMusicMainViewPresentor.super.ctor(self)
end

function NsopPlayMusicMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NsopPlayMusicMainViewPresentor:dependWhatResources()
	return {
		"ui/views/newsummonpetobtain/nsopplaymusicmainview.prefab"
	}
end

function NsopPlayMusicMainViewPresentor:buildViews()
	return {
		NsopPlayMusicMainView.New()
	}
end

return NsopPlayMusicMainViewPresentor
