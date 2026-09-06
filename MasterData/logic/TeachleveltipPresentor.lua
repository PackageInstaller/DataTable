-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teachingdungeon/view/TeachleveltipPresentor.lua

module("logic.extensions.teachingdungeon.view.TeachleveltipPresentor", package.seeall)

local TeachleveltipPresentor = class("TeachleveltipPresentor", ViewPresentor)

function TeachleveltipPresentor:ctor()
	TeachleveltipPresentor.super.ctor(self)
end

function TeachleveltipPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TeachleveltipPresentor:dependWhatResources()
	return {
		"ui/views/teachingdungeon/teachleveltip.prefab"
	}
end

function TeachleveltipPresentor:buildViews()
	return {
		TeachleveltipView.New()
	}
end

return TeachleveltipPresentor
