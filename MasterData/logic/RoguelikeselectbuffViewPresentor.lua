-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/RoguelikeselectbuffViewPresentor.lua

module("logic.extensions.roguelike.view.RoguelikeselectbuffViewPresentor", package.seeall)

local RoguelikeselectbuffViewPresentor = class("RoguelikeselectbuffViewPresentor", ViewPresentor)

function RoguelikeselectbuffViewPresentor:ctor()
	RoguelikeselectbuffViewPresentor.super.ctor(self)
end

function RoguelikeselectbuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RoguelikeselectbuffViewPresentor:dependWhatResources()
	return {
		"ui/views/roguelike/roguelikeselectbuffview.prefab"
	}
end

function RoguelikeselectbuffViewPresentor:buildViews()
	return {
		RoguelikeselectbuffView.New()
	}
end

function RoguelikeselectbuffViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath("fx_ui_yuanzheng/fx_ui_yuanzheng_xuanka.prefab")
	}
end

function RoguelikeselectbuffViewPresentor:setGrayMaskGO(grayMaskGO)
	RoguelikeselectbuffViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	GameUtil.SetActive(grayMaskGO, false)
end

return RoguelikeselectbuffViewPresentor
