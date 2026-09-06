-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/emperorsubdue/view/EmperorSubdueFmtExViewPresentor.lua

module("logic.extensions.emperorsubdue.view.EmperorSubdueFmtExViewPresentor", package.seeall)

local EmperorSubdueFmtExViewPresentor = class("EmperorSubdueFmtExViewPresentor", ViewPresentor)

function EmperorSubdueFmtExViewPresentor:ctor()
	EmperorSubdueFmtExViewPresentor.super.ctor(self)
end

function EmperorSubdueFmtExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EmperorSubdueFmtExViewPresentor:dependWhatResources()
	return {
		"ui/views/emperorsubdue/emperorsubduefmtexview.prefab"
	}
end

function EmperorSubdueFmtExViewPresentor:buildViews()
	return {
		EmperorSubdueFmtExView.New()
	}
end

return EmperorSubdueFmtExViewPresentor
