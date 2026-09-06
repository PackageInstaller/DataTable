-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenyaozhengli/view/ShenyaozhenglimainViewPresentor.lua

module("logic.extensions.shenyaozhengli.view.ShenyaozhenglimainViewPresentor", package.seeall)

local ShenyaozhenglimainViewPresentor = class("ShenyaozhenglimainViewPresentor", ViewPresentor)

function ShenyaozhenglimainViewPresentor:ctor()
	ShenyaozhenglimainViewPresentor.super.ctor(self)
end

function ShenyaozhenglimainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShenyaozhenglimainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/shenyaozhengli/shenyaozhenglimainview.prefab"
	}
end

function ShenyaozhenglimainViewPresentor:buildViews()
	return {
		ShenyaozhenglimainView.New()
	}
end

return ShenyaozhenglimainViewPresentor
