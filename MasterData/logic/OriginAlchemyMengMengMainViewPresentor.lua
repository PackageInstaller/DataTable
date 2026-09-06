-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originalchemymengmeng/view/OriginAlchemyMengMengMainViewPresentor.lua

module("logic.extensions.originalchemymengmeng.view.OriginAlchemyMengMengMainViewPresentor", package.seeall)

local OriginAlchemyMengMengMainViewPresentor = class("OriginAlchemyMengMengMainViewPresentor", ViewPresentor)

function OriginAlchemyMengMengMainViewPresentor:ctor()
	OriginAlchemyMengMengMainViewPresentor.super.ctor(self)
end

function OriginAlchemyMengMengMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginAlchemyMengMengMainViewPresentor:dependWhatResources()
	return {
		"ui/views/originalchemymengmeng/originalchemymengmengmainview.prefab"
	}
end

function OriginAlchemyMengMengMainViewPresentor:buildViews()
	return {
		OriginAlchemyMengMengMainView.New()
	}
end

return OriginAlchemyMengMengMainViewPresentor
