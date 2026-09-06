-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xuchallenge/view/XuChallengeFmtExViewPresentor.lua

module("logic.extensions.xuchallenge.view.XuChallengeFmtExViewPresentor", package.seeall)

local XuChallengeFmtExViewPresentor = class("XuChallengeFmtExViewPresentor", ViewPresentor)

function XuChallengeFmtExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XuChallengeFmtExViewPresentor:dependWhatResources()
	return {
		"ui/views/xuchallenge/xuchallengefmtexview.prefab"
	}
end

function XuChallengeFmtExViewPresentor:buildViews()
	return {
		XuChallengeFmtExView.New()
	}
end

return XuChallengeFmtExViewPresentor
