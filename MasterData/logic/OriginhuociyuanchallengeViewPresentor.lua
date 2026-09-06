-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhuociyuan/view/OriginhuociyuanchallengeViewPresentor.lua

module("logic.extensions.originhuociyuan.view.OriginhuociyuanchallengeViewPresentor", package.seeall)

local OriginhuociyuanchallengeViewPresentor = class("OriginhuociyuanchallengeViewPresentor", ViewPresentor)

function OriginhuociyuanchallengeViewPresentor:ctor()
	OriginhuociyuanchallengeViewPresentor.super.ctor(self)
end

function OriginhuociyuanchallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginhuociyuanchallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/originhuociyuan/originhuociyuanchallengeview.prefab"
	}
end

function OriginhuociyuanchallengeViewPresentor:buildViews()
	return {
		OriginhuociyuanchallengeView.New()
	}
end

return OriginhuociyuanchallengeViewPresentor
