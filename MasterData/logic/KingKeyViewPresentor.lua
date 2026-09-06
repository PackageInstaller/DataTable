-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/KingKeyViewPresentor.lua

module("logic.extensions.kingway.view.KingKeyViewPresentor", package.seeall)

local KingKeyViewPresentor = class("KingKeyViewPresentor", ViewWithGuidePresentor)

function KingKeyViewPresentor:ctor()
	KingKeyViewPresentor.super.ctor(self)
end

function KingKeyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingKeyViewPresentor:dependWhatResources()
	return {
		"ui/views/kingway/kingkeyview.prefab"
	}
end

function KingKeyViewPresentor:buildViews()
	return {
		KingKeyView.New()
	}
end

return KingKeyViewPresentor
