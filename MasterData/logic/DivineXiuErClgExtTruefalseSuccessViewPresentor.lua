-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/view/DivineXiuErClgExtTruefalseSuccessViewPresentor.lua

module("logic.extensions.divinexiuerclg.view.DivineXiuErClgExtTruefalseSuccessViewPresentor", package.seeall)

local DivineXiuErClgExtTruefalseSuccessViewPresentor = class("DivineXiuErClgExtTruefalseSuccessViewPresentor", ViewPresentor)

function DivineXiuErClgExtTruefalseSuccessViewPresentor:ctor()
	DivineXiuErClgExtTruefalseSuccessViewPresentor.super.ctor(self)
end

function DivineXiuErClgExtTruefalseSuccessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineXiuErClgExtTruefalseSuccessViewPresentor:dependWhatResources()
	return {
		"ui/views/divinexiuerclg/divinexiuerclgexttruefalsesuccessview.prefab"
	}
end

function DivineXiuErClgExtTruefalseSuccessViewPresentor:buildViews()
	return {
		DivineXiuErClgExtTruefalseSuccessView.New()
	}
end

return DivineXiuErClgExtTruefalseSuccessViewPresentor
