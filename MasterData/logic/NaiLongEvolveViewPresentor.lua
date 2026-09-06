-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailongevolve/view/NaiLongEvolveViewPresentor.lua

module("logic.extensions.nailongevolve.view.NaiLongEvolveViewPresentor", package.seeall)

local NaiLongEvolveViewPresentor = class("NaiLongEvolveViewPresentor", ViewPresentor)

function NaiLongEvolveViewPresentor:ctor()
	NaiLongEvolveViewPresentor.super.ctor(self)
end

function NaiLongEvolveViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NaiLongEvolveViewPresentor:dependWhatResources()
	return {
		"ui/views/nailongevolve/nailongevolveview.prefab"
	}
end

function NaiLongEvolveViewPresentor:buildViews()
	return {
		NaiLongEvolveView.New()
	}
end

return NaiLongEvolveViewPresentor
