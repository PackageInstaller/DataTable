-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongzhu/view/OriginlongzhufmtexViewPresentor.lua

module("logic.extensions.originlongzhu.view.OriginlongzhufmtexViewPresentor", package.seeall)

local OriginlongzhufmtexViewPresentor = class("OriginlongzhufmtexViewPresentor", ViewPresentor)

function OriginlongzhufmtexViewPresentor:ctor()
	OriginlongzhufmtexViewPresentor.super.ctor(self)
end

function OriginlongzhufmtexViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginlongzhufmtexViewPresentor:dependWhatResources()
	return {
		"ui/views/originlongzhu/originlongzhufmtexview.prefab"
	}
end

function OriginlongzhufmtexViewPresentor:buildViews()
	return {
		OriginlongzhufmtexView.New()
	}
end

return OriginlongzhufmtexViewPresentor
