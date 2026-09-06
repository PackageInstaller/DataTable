-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailonghotsearch/view/NaiLongHotSearchMainViewPresentor.lua

module("logic.extensions.nailonghotsearch.view.NaiLongHotSearchMainViewPresentor", package.seeall)

local NaiLongHotSearchMainViewPresentor = class("NaiLongHotSearchMainViewPresentor", ViewPresentor)

function NaiLongHotSearchMainViewPresentor:ctor()
	NaiLongHotSearchMainViewPresentor.super.ctor(self)
end

function NaiLongHotSearchMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NaiLongHotSearchMainViewPresentor:dependWhatResources()
	return {
		"ui/views/anchorsimulator/nailonghotsearchmainview.prefab"
	}
end

function NaiLongHotSearchMainViewPresentor:buildViews()
	return {
		NaiLongHotSearchMainView.New()
	}
end

return NaiLongHotSearchMainViewPresentor
