-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originalchemymengmeng/view/OriginAlchemyMengMengFightEndViewPresentor.lua

module("logic.extensions.originalchemymengmeng.view.OriginAlchemyMengMengFightEndViewPresentor", package.seeall)

local OriginAlchemyMengMengFightEndViewPresentor = class("OriginAlchemyMengMengFightEndViewPresentor", ViewPresentor)

function OriginAlchemyMengMengFightEndViewPresentor:ctor()
	OriginAlchemyMengMengFightEndViewPresentor.super.ctor(self)
end

function OriginAlchemyMengMengFightEndViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginAlchemyMengMengFightEndViewPresentor:dependWhatResources()
	return {
		"ui/views/originalchemymengmeng/originalchemymengmengfightendview.prefab"
	}
end

function OriginAlchemyMengMengFightEndViewPresentor:buildViews()
	return {
		OriginAlchemyMengMengFightEndView.New()
	}
end

return OriginAlchemyMengMengFightEndViewPresentor
