-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelanspeswerresaultViewPresentor.lua

module("logic.extensions.goodfeel.view.GoodfeelanspeswerresaultViewPresentor", package.seeall)

local GoodfeelanspeswerresaultViewPresentor = class("GoodfeelanspeswerresaultViewPresentor", ViewPresentor)

function GoodfeelanspeswerresaultViewPresentor:ctor()
	GoodfeelanspeswerresaultViewPresentor.super.ctor(self)
end

function GoodfeelanspeswerresaultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoodfeelanspeswerresaultViewPresentor:dependWhatResources()
	return {
		"ui/views/goodfeel/goodfeelanspeswerresaultview.prefab"
	}
end

function GoodfeelanspeswerresaultViewPresentor:buildViews()
	return {
		GoodfeelanspeswerresaultView.New()
	}
end

function GoodfeelanspeswerresaultViewPresentor:onClickOutside()
	self:close()
end

return GoodfeelanspeswerresaultViewPresentor
