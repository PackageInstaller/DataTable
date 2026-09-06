-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkBossViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSparkBossViewPresentor", package.seeall)

local ElementSparkBossViewPresentor = class("ElementSparkBossViewPresentor", ViewPresentor)

function ElementSparkBossViewPresentor:ctor()
	ElementSparkBossViewPresentor.super.ctor(self)
end

function ElementSparkBossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElementSparkBossViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparkbossview.prefab"
	}
end

function ElementSparkBossViewPresentor:buildViews()
	return {
		ElementSparkBossView.New()
	}
end

return ElementSparkBossViewPresentor
