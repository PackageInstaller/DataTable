-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailonghotsearch/view/NaiLongHotSearchReplyViewPresentor.lua

module("logic.extensions.nailonghotsearch.view.NaiLongHotSearchReplyViewPresentor", package.seeall)

local NaiLongHotSearchReplyViewPresentor = class("NaiLongHotSearchReplyViewPresentor", ViewPresentor)

function NaiLongHotSearchReplyViewPresentor:ctor()
	NaiLongHotSearchReplyViewPresentor.super.ctor(self)
end

function NaiLongHotSearchReplyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NaiLongHotSearchReplyViewPresentor:dependWhatResources()
	return {
		"ui/views/anchorsimulator/nailonghotsearchreplyview.prefab"
	}
end

function NaiLongHotSearchReplyViewPresentor:buildViews()
	return {
		NaiLongHotSearchReplyView.New()
	}
end

return NaiLongHotSearchReplyViewPresentor
