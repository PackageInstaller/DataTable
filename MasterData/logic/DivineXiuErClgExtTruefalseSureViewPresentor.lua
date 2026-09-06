-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/view/DivineXiuErClgExtTruefalseSureViewPresentor.lua

module("logic.extensions.divinexiuerclg.view.DivineXiuErClgExtTruefalseSureViewPresentor", package.seeall)

local DivineXiuErClgExtTruefalseSureViewPresentor = class("DivineXiuErClgExtTruefalseSureViewPresentor", ViewPresentor)

function DivineXiuErClgExtTruefalseSureViewPresentor:ctor()
	DivineXiuErClgExtTruefalseSureViewPresentor.super.ctor(self)
end

function DivineXiuErClgExtTruefalseSureViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineXiuErClgExtTruefalseSureViewPresentor:dependWhatResources()
	return {
		"ui/views/divinexiuerclg/divinexiuerclgexttruefalsesureview.prefab"
	}
end

function DivineXiuErClgExtTruefalseSureViewPresentor:buildViews()
	return {
		DivineXiuErClgExtTruefalseSureView.New()
	}
end

return DivineXiuErClgExtTruefalseSureViewPresentor
