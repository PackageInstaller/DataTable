-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingciyuan/view/DivineKingCiYuanPassViewPresentor.lua

module("logic.extensions.divinekingciyuan.view.DivineKingCiYuanPassViewPresentor", package.seeall)

local DivineKingCiYuanPassViewPresentor = class("DivineKingCiYuanPassViewPresentor", ViewPresentor)

function DivineKingCiYuanPassViewPresentor:ctor()
	DivineKingCiYuanPassViewPresentor.super.ctor(self)
end

function DivineKingCiYuanPassViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineKingCiYuanPassViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingciyuan/divinekingciyuanpassview.prefab"
	}
end

function DivineKingCiYuanPassViewPresentor:buildViews()
	return {
		DivineKingCiYuanPassView.New()
	}
end

return DivineKingCiYuanPassViewPresentor
