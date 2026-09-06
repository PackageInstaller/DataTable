-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongzhu/view/OriginlongzhuresultViewPresentor.lua

module("logic.extensions.originlongzhu.view.OriginlongzhuresultViewPresentor", package.seeall)

local OriginlongzhuresultViewPresentor = class("OriginlongzhuresultViewPresentor", ViewPresentor)

function OriginlongzhuresultViewPresentor:ctor()
	OriginlongzhuresultViewPresentor.super.ctor(self)
end

function OriginlongzhuresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginlongzhuresultViewPresentor:dependWhatResources()
	return {
		"ui/views/originlongzhu/originlongzhuresultview.prefab"
	}
end

function OriginlongzhuresultViewPresentor:buildViews()
	return {
		OriginlongzhuresultView.New()
	}
end

return OriginlongzhuresultViewPresentor
