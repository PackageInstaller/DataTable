-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpsychicji/view/OriginpsychicjiextresultViewPresentor.lua

module("logic.extensions.originpsychicji.view.OriginpsychicjiextresultViewPresentor", package.seeall)

local OriginpsychicjiextresultViewPresentor = class("OriginpsychicjiextresultViewPresentor", ViewPresentor)

function OriginpsychicjiextresultViewPresentor:ctor()
	OriginpsychicjiextresultViewPresentor.super.ctor(self)
end

function OriginpsychicjiextresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginpsychicjiextresultViewPresentor:dependWhatResources()
	return {
		"ui/views/originpsychicji/originpsychicjiextresultview.prefab"
	}
end

function OriginpsychicjiextresultViewPresentor:buildViews()
	return {
		OriginpsychicjiextresultView.New()
	}
end

return OriginpsychicjiextresultViewPresentor
