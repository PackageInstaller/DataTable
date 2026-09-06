-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originalchemymengmeng/view/OriginAlchemyMengMengFmtViewPresentor.lua

module("logic.extensions.originalchemymengmeng.view.OriginAlchemyMengMengFmtViewPresentor", package.seeall)

local OriginAlchemyMengMengFmtViewPresentor = class("OriginAlchemyMengMengFmtViewPresentor", ViewPresentor)

function OriginAlchemyMengMengFmtViewPresentor:ctor()
	OriginAlchemyMengMengFmtViewPresentor.super.ctor(self)
end

function OriginAlchemyMengMengFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginAlchemyMengMengFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/originalchemymengmeng/originalchemymengmengfmtview.prefab"
	}
end

function OriginAlchemyMengMengFmtViewPresentor:buildViews()
	return {
		OriginAlchemyMengMengFmtView.New()
	}
end

return OriginAlchemyMengMengFmtViewPresentor
