-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinechenclg/view/DivineChenClgMainViewPresentor.lua

module("logic.extensions.divinechenclg.view.DivineChenClgMainViewPresentor", package.seeall)

local DivineChenClgMainViewPresentor = class("DivineChenClgMainViewPresentor", ViewPresentor)

function DivineChenClgMainViewPresentor:ctor()
	DivineChenClgMainViewPresentor.super.ctor(self)
end

function DivineChenClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineChenClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinechenclg/divinechenclgmainview.prefab"
	}
end

function DivineChenClgMainViewPresentor:buildViews()
	return {
		DivineChenClgMainView.New()
	}
end

return DivineChenClgMainViewPresentor
