-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/view/DivineXiuErClgExtViewPresentor.lua

module("logic.extensions.divinexiuerclg.view.DivineXiuErClgExtViewPresentor", package.seeall)

local DivineXiuErClgExtViewPresentor = class("DivineXiuErClgExtViewPresentor", ViewPresentor)

function DivineXiuErClgExtViewPresentor:ctor()
	DivineXiuErClgExtViewPresentor.super.ctor(self)
end

function DivineXiuErClgExtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineXiuErClgExtViewPresentor:dependWhatResources()
	return {
		"ui/views/divinexiuerclg/divinexiuerclgextview.prefab"
	}
end

function DivineXiuErClgExtViewPresentor:buildViews()
	return {
		DivineXiuErClgExtView.New()
	}
end

return DivineXiuErClgExtViewPresentor
