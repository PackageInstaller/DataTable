-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinechenclg/view/DivineChenClgResultViewPresentor.lua

module("logic.extensions.divinechenclg.view.DivineChenClgResultViewPresentor", package.seeall)

local DivineChenClgResultViewPresentor = class("DivineChenClgResultViewPresentor", ViewPresentor)

function DivineChenClgResultViewPresentor:ctor()
	DivineChenClgResultViewPresentor.super.ctor(self)
end

function DivineChenClgResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineChenClgResultViewPresentor:dependWhatResources()
	return {
		"ui/views/divinechenclg/divinechenclgresultview.prefab"
	}
end

function DivineChenClgResultViewPresentor:buildViews()
	return {
		DivineChenClgResultView.New()
	}
end

return DivineChenClgResultViewPresentor
