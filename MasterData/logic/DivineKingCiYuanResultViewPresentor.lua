-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingciyuan/view/DivineKingCiYuanResultViewPresentor.lua

module("logic.extensions.divinekingciyuan.view.DivineKingCiYuanResultViewPresentor", package.seeall)

local DivineKingCiYuanResultViewPresentor = class("DivineKingCiYuanResultViewPresentor", ViewPresentor)

function DivineKingCiYuanResultViewPresentor:ctor()
	DivineKingCiYuanResultViewPresentor.super.ctor(self)
end

function DivineKingCiYuanResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function DivineKingCiYuanResultViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingciyuan/divinekingciyuanresultview.prefab"
	}
end

function DivineKingCiYuanResultViewPresentor:buildViews()
	return {
		DivineKingCiYuanResultView.New()
	}
end

return DivineKingCiYuanResultViewPresentor
