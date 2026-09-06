-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/view/fmt/KingArenaShowFmtViewPresentor.lua

module("logic.extensions.kingarena.view.fmt.ArenaDefFmtViewPresentor", package.seeall)

local ArenaDefFmtViewPresentor = class("ArenaDefFmtViewPresentor", MissionViewPresentor)

function ArenaDefFmtViewPresentor:ctor()
	ArenaDefFmtViewPresentor.super.ctor(self)
end

function ArenaDefFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ArenaDefFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/kingarena/kingarenashowfmtview.prefab",
		self:_addCommonRes()
	}
end

function ArenaDefFmtViewPresentor:buildViews()
	return {
		KingArenaShowFmtView.New(),
		KingArenaShowMissionFmtView.New()
	}
end

return ArenaDefFmtViewPresentor
