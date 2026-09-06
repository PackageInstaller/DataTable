-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originzhengli/view/OriginZhengliBuffViewPresentor.lua

module("logic.extensions.originzhengli.view.OriginZhengliBuffViewPresentor", package.seeall)

local OriginZhengliBuffViewPresentor = class("OriginZhengliBuffViewPresentor", ViewPresentor)

function OriginZhengliBuffViewPresentor:ctor()
	OriginZhengliBuffViewPresentor.super.ctor(self)
end

function OriginZhengliBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginZhengliBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/originzhengli/originzhenglibuffview.prefab"
	}
end

function OriginZhengliBuffViewPresentor:buildViews()
	return {
		OriginZhengliBuffView.New()
	}
end

return OriginZhengliBuffViewPresentor
