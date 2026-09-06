-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/view/DivineXiuErClgNorViewPresentor.lua

module("logic.extensions.divinexiuerclg.view.DivineXiuErClgNorViewPresentor", package.seeall)

local DivineXiuErClgNorViewPresentor = class("DivineXiuErClgNorViewPresentor", ViewPresentor)

function DivineXiuErClgNorViewPresentor:ctor()
	DivineXiuErClgNorViewPresentor.super.ctor(self)
end

function DivineXiuErClgNorViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineXiuErClgNorViewPresentor:dependWhatResources()
	return {
		"ui/views/divinexiuerclg/divinexiuerclgnorview.prefab"
	}
end

function DivineXiuErClgNorViewPresentor:buildViews()
	return {
		DivineXiuErClgNorView.New()
	}
end

return DivineXiuErClgNorViewPresentor
