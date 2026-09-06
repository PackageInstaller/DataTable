-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/view/DivineXiuErClgMainViewPresentor.lua

module("logic.extensions.divinexiuerclg.view.DivineXiuErClgMainViewPresentor", package.seeall)

local DivineXiuErClgMainViewPresentor = class("DivineXiuErClgMainViewPresentor", ViewPresentor)

function DivineXiuErClgMainViewPresentor:ctor()
	DivineXiuErClgMainViewPresentor.super.ctor(self)
end

function DivineXiuErClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineXiuErClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinexiuerclg/divinexiuerclgmainview.prefab"
	}
end

function DivineXiuErClgMainViewPresentor:buildViews()
	return {
		DivineXiuErClgMainView.New()
	}
end

return DivineXiuErClgMainViewPresentor
