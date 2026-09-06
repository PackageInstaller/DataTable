-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/view/DivineXiuErClgExtTruefalseViewPresentor.lua

module("logic.extensions.divinexiuerclg.view.DivineXiuErClgExtTruefalseViewPresentor", package.seeall)

local DivineXiuErClgExtTruefalseViewPresentor = class("DivineXiuErClgExtTruefalseViewPresentor", ViewPresentor)

function DivineXiuErClgExtTruefalseViewPresentor:ctor()
	DivineXiuErClgExtTruefalseViewPresentor.super.ctor(self)
end

function DivineXiuErClgExtTruefalseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineXiuErClgExtTruefalseViewPresentor:dependWhatResources()
	return {
		"ui/views/divinexiuerclg/divinexiuerclgexttruefalseview.prefab"
	}
end

function DivineXiuErClgExtTruefalseViewPresentor:buildViews()
	return {
		DivineXiuErClgExtTruefalseView.New()
	}
end

return DivineXiuErClgExtTruefalseViewPresentor
