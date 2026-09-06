-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinechenclg/view/DivineChenClgNormalViewPresentor.lua

module("logic.extensions.divinechenclg.view.DivineChenClgNormalViewPresentor", package.seeall)

local DivineChenClgNormalViewPresentor = class("DivineChenClgNormalViewPresentor", ViewPresentor)

function DivineChenClgNormalViewPresentor:ctor()
	DivineChenClgNormalViewPresentor.super.ctor(self)
end

function DivineChenClgNormalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineChenClgNormalViewPresentor:dependWhatResources()
	return {
		"ui/views/divinechenclg/divinechenclgnormalview.prefab"
	}
end

function DivineChenClgNormalViewPresentor:buildViews()
	return {
		DivineChenClgNormalView.New()
	}
end

return DivineChenClgNormalViewPresentor
