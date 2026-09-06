-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinechenclg/view/DivineChenClgExtremeViewPresentor.lua

module("logic.extensions.divinechenclg.view.DivineChenClgExtremeViewPresentor", package.seeall)

local DivineChenClgExtremeViewPresentor = class("DivineChenClgExtremeViewPresentor", ViewPresentor)

function DivineChenClgExtremeViewPresentor:ctor()
	DivineChenClgExtremeViewPresentor.super.ctor(self)
end

function DivineChenClgExtremeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineChenClgExtremeViewPresentor:dependWhatResources()
	return {
		"ui/views/divinechenclg/divinechenclgextremeview.prefab"
	}
end

function DivineChenClgExtremeViewPresentor:buildViews()
	return {
		DivineChenClgExtremeView.New()
	}
end

return DivineChenClgExtremeViewPresentor
