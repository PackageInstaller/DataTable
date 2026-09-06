-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianwelfare/view/NnwelfareprizeViewPresentor.lua

module("logic.extensions.niannianwelfare.view.NnwelfareprizeViewPresentor", package.seeall)

local NnwelfareprizeViewPresentor = class("NnwelfareprizeViewPresentor", ViewPresentor)

function NnwelfareprizeViewPresentor:ctor()
	NnwelfareprizeViewPresentor.super.ctor(self)
end

function NnwelfareprizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NnwelfareprizeViewPresentor:dependWhatResources()
	return {
		"ui/views/niannianwelfare/nnwelfareprizeview.prefab"
	}
end

function NnwelfareprizeViewPresentor:buildViews()
	return {
		NnWelfarePrizeView.New()
	}
end

return NnwelfareprizeViewPresentor
