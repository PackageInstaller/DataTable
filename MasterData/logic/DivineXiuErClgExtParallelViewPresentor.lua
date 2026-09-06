-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/view/DivineXiuErClgExtParallelViewPresentor.lua

module("logic.extensions.divinexiuerclg.view.DivineXiuErClgExtParallelViewPresentor", package.seeall)

local DivineXiuErClgExtParallelViewPresentor = class("DivineXiuErClgExtParallelViewPresentor", ViewPresentor)

function DivineXiuErClgExtParallelViewPresentor:ctor()
	DivineXiuErClgExtParallelViewPresentor.super.ctor(self)
end

function DivineXiuErClgExtParallelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineXiuErClgExtParallelViewPresentor:dependWhatResources()
	return {
		"ui/views/divinexiuerclg/divinexiuerclgextparallelview.prefab"
	}
end

function DivineXiuErClgExtParallelViewPresentor:buildViews()
	return {
		DivineXiuErClgExtParallelView.New()
	}
end

return DivineXiuErClgExtParallelViewPresentor
