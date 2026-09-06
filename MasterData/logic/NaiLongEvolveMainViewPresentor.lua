-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailongevolve/view/NaiLongEvolveMainViewPresentor.lua

module("logic.extensions.nailongevolve.view.NaiLongEvolveMainViewPresentor", package.seeall)

local NaiLongEvolveMainViewPresentor = class("NaiLongEvolveMainViewPresentor", ViewPresentor)

function NaiLongEvolveMainViewPresentor:ctor()
	NaiLongEvolveMainViewPresentor.super.ctor(self)
end

function NaiLongEvolveMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NaiLongEvolveMainViewPresentor:dependWhatResources()
	return {
		"ui/views/nailongevolve/nailongevolvemainview.prefab"
	}
end

function NaiLongEvolveMainViewPresentor:buildViews()
	return {
		NaiLongEvolveMainView.New()
	}
end

return NaiLongEvolveMainViewPresentor
