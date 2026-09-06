-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolveplus/view/DivineEvolvePlusCultivateViewPresentor.lua

module("logic.extensions.divineevolveplus.view.DivineEvolvePlusCultivateViewPresentor", package.seeall)

local DivineEvolvePlusCultivateViewPresentor = class("DivineEvolvePlusCultivateViewPresentor", ViewPresentor)

function DivineEvolvePlusCultivateViewPresentor:ctor()
	DivineEvolvePlusCultivateViewPresentor.super.ctor(self)
end

function DivineEvolvePlusCultivateViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineEvolvePlusCultivateViewPresentor:dependWhatResources()
	return {
		"ui/views/divineevolveplus/divineevolvepluscultivateview.prefab"
	}
end

function DivineEvolvePlusCultivateViewPresentor:buildViews()
	return {
		DivineEvolvePlusCultivateView.New()
	}
end

return DivineEvolvePlusCultivateViewPresentor
