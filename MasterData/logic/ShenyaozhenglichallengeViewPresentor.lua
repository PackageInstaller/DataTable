-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenyaozhengli/view/ShenyaozhenglichallengeViewPresentor.lua

module("logic.extensions.shenyaozhengli.view.ShenyaozhenglichallengeViewPresentor", package.seeall)

local ShenyaozhenglichallengeViewPresentor = class("ShenyaozhenglichallengeViewPresentor", ViewPresentor)

function ShenyaozhenglichallengeViewPresentor:ctor()
	ShenyaozhenglichallengeViewPresentor.super.ctor(self)
end

function ShenyaozhenglichallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShenyaozhenglichallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/shenyaozhengli/shenyaozhenglichallengeview.prefab"
	}
end

function ShenyaozhenglichallengeViewPresentor:buildViews()
	return {
		ShenyaozhenglichallengeView.New()
	}
end

return ShenyaozhenglichallengeViewPresentor
