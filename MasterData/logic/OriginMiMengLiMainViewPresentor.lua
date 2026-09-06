-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originmimengli/view/OriginMiMengLiMainViewPresentor.lua

module("logic.extensions.originmimengli.view.OriginMiMengLiMainViewPresentor", package.seeall)

local OriginMiMengLiMainViewPresentor = class("OriginMiMengLiMainViewPresentor", ViewPresentor)

function OriginMiMengLiMainViewPresentor:ctor()
	OriginMiMengLiMainViewPresentor.super.ctor(self)
end

function OriginMiMengLiMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginMiMengLiMainViewPresentor:dependWhatResources()
	return {
		"ui/views/originmimengli/originmimenglimainview.prefab"
	}
end

function OriginMiMengLiMainViewPresentor:buildViews()
	return {
		OriginMiMengLiMainView.New()
	}
end

return OriginMiMengLiMainViewPresentor
