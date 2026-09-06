-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpsychicji/view/OriginpsychicjistageViewPresentor.lua

module("logic.extensions.originpsychicji.view.OriginpsychicjistageViewPresentor", package.seeall)

local OriginpsychicjistageViewPresentor = class("OriginpsychicjistageViewPresentor", ViewPresentor)

function OriginpsychicjistageViewPresentor:ctor()
	OriginpsychicjistageViewPresentor.super.ctor(self)
end

function OriginpsychicjistageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginpsychicjistageViewPresentor:dependWhatResources()
	return {
		"ui/views/originpsychicji/originpsychicjistageview.prefab"
	}
end

function OriginpsychicjistageViewPresentor:buildViews()
	return {
		OriginpsychicjistageView.New()
	}
end

return OriginpsychicjistageViewPresentor
