-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originalchemymengmeng/view/OriginAlchemyMengMengSelectViewPresentor.lua

module("logic.extensions.originalchemymengmeng.view.OriginAlchemyMengMengSelectViewPresentor", package.seeall)

local OriginAlchemyMengMengSelectViewPresentor = class("OriginAlchemyMengMengSelectViewPresentor", ViewPresentor)

function OriginAlchemyMengMengSelectViewPresentor:ctor()
	OriginAlchemyMengMengSelectViewPresentor.super.ctor(self)
end

function OriginAlchemyMengMengSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginAlchemyMengMengSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/originalchemymengmeng/originalchemymengmengselectview.prefab"
	}
end

function OriginAlchemyMengMengSelectViewPresentor:buildViews()
	return {
		OriginAlchemyMengMengSelectView.New()
	}
end

return OriginAlchemyMengMengSelectViewPresentor
