-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originzhengli/view/OriginZhengliMainViewPresentor.lua

module("logic.extensions.originzhengli.view.OriginZhengliMainViewPresentor", package.seeall)

local OriginZhengliMainViewPresentor = class("OriginZhengliMainViewPresentor", ViewPresentor)

function OriginZhengliMainViewPresentor:ctor()
	OriginZhengliMainViewPresentor.super.ctor(self)
end

function OriginZhengliMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginZhengliMainViewPresentor:dependWhatResources()
	return {
		"ui/views/originzhengli/originzhenglimainview.prefab"
	}
end

function OriginZhengliMainViewPresentor:buildViews()
	return {
		OriginZhengliMainView.New()
	}
end

return OriginZhengliMainViewPresentor
