-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originalchemymengmeng/view/OriginAlchemyMengMengLevelViewPresentor.lua

module("logic.extensions.originalchemymengmeng.view.OriginAlchemyMengMengLevelViewPresentor", package.seeall)

local OriginAlchemyMengMengLevelViewPresentor = class("OriginAlchemyMengMengLevelViewPresentor", ViewPresentor)

function OriginAlchemyMengMengLevelViewPresentor:ctor()
	OriginAlchemyMengMengLevelViewPresentor.super.ctor(self)
end

function OriginAlchemyMengMengLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginAlchemyMengMengLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/originalchemymengmeng/originalchemymengmenglevelview.prefab"
	}
end

function OriginAlchemyMengMengLevelViewPresentor:buildViews()
	return {
		OriginAlchemyMengMengLevelView.New()
	}
end

return OriginAlchemyMengMengLevelViewPresentor
