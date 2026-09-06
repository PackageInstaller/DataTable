-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/view/DivineXiuErClgNorSureViewPresentor.lua

module("logic.extensions.divinexiuerclg.view.DivineXiuErClgNorSureViewPresentor", package.seeall)

local DivineXiuErClgNorSureViewPresentor = class("DivineXiuErClgNorSureViewPresentor", ViewPresentor)

function DivineXiuErClgNorSureViewPresentor:ctor()
	DivineXiuErClgNorSureViewPresentor.super.ctor(self)
end

function DivineXiuErClgNorSureViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineXiuErClgNorSureViewPresentor:dependWhatResources()
	return {
		"ui/views/divinexiuerclg/divinexiuerclgnorsureview.prefab"
	}
end

function DivineXiuErClgNorSureViewPresentor:buildViews()
	return {
		DivineXiuErClgNorSureView.New()
	}
end

return DivineXiuErClgNorSureViewPresentor
