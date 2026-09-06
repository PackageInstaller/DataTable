-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originan/view/OriginAnExtremeFmtExViewPresentor.lua

module("logic.extensions.originan.view.OriginAnExtremeFmtExViewPresentor", package.seeall)

local OriginAnExtremeFmtExViewPresentor = class("OriginAnExtremeFmtExViewPresentor", ViewPresentor)

function OriginAnExtremeFmtExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginAnExtremeFmtExViewPresentor:dependWhatResources()
	return {
		"ui/views/originan/originanextremefmtexview.prefab"
	}
end

function OriginAnExtremeFmtExViewPresentor:buildViews()
	return {
		OriginAnExtremeFmtExView.New()
	}
end

function OriginAnExtremeFmtExViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return OriginAnExtremeFmtExViewPresentor
