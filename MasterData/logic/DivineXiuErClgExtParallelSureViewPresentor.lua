-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/view/DivineXiuErClgExtParallelSureViewPresentor.lua

module("logic.extensions.divinexiuerclg.view.DivineXiuErClgExtParallelSureViewPresentor", package.seeall)

local DivineXiuErClgExtParallelSureViewPresentor = class("DivineXiuErClgExtParallelSureViewPresentor", ViewPresentor)

function DivineXiuErClgExtParallelSureViewPresentor:ctor()
	DivineXiuErClgExtParallelSureViewPresentor.super.ctor(self)
end

function DivineXiuErClgExtParallelSureViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineXiuErClgExtParallelSureViewPresentor:dependWhatResources()
	return {
		"ui/views/divinexiuerclg/divinexiuerclgextparallelsureview.prefab"
	}
end

function DivineXiuErClgExtParallelSureViewPresentor:buildViews()
	return {
		DivineXiuErClgExtParallelSureView.New()
	}
end

return DivineXiuErClgExtParallelSureViewPresentor
