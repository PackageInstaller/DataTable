-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originzhengli/view/OriginZhengliFmtExViewPresentor.lua

module("logic.extensions.originzhengli.view.OriginZhengliFmtExViewPresentor", package.seeall)

local OriginZhengliFmtExViewPresentor = class("OriginZhengliFmtExViewPresentor", ViewPresentor)

function OriginZhengliFmtExViewPresentor:ctor()
	OriginZhengliFmtExViewPresentor.super.ctor(self)
end

function OriginZhengliFmtExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginZhengliFmtExViewPresentor:dependWhatResources()
	return {
		"ui/views/originzhengli/originzhenglifmtexview.prefab"
	}
end

function OriginZhengliFmtExViewPresentor:buildViews()
	return {
		OriginZhengliFmtExView.New()
	}
end

return OriginZhengliFmtExViewPresentor
