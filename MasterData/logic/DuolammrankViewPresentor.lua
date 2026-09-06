-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolamengmeng/view/DuolammrankViewPresentor.lua

module("logic.extensions.duolamengmeng.view.DuolammrankViewPresentor", package.seeall)

local DuolammrankViewPresentor = class("DuolammrankViewPresentor", ViewPresentor)

function DuolammrankViewPresentor:ctor()
	DuolammrankViewPresentor.super.ctor(self)
end

function DuolammrankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DuolammrankViewPresentor:dependWhatResources()
	return {
		"ui/views/duolamengmeng/duolammrankview.prefab"
	}
end

function DuolammrankViewPresentor:buildViews()
	return {
		DuolaMMRankView.New()
	}
end

return DuolammrankViewPresentor
