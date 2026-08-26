-- chunkname: @modules/logic/seasonver/act123/define/SeasonEntryEnum.lua

module("modules.logic.seasonver.act123.define.SeasonEntryEnum", package.seeall)

local SeasonEntryEnum = _M

SeasonEntryEnum.DefaultScenePosX = 0
SeasonEntryEnum.DefaultScenePosY = 0
SeasonEntryEnum.DefaultScenePosZ = 0
SeasonEntryEnum.SceneBoundMinX = -88
SeasonEntryEnum.SceneBoundMaxX = -18
SeasonEntryEnum.SceneBoundMinY = 9
SeasonEntryEnum.SceneBoundMaxY = 25
SeasonEntryEnum.FocusTweenTime = 0.45
SeasonEntryEnum.FocusScale = 0.6
SeasonEntryEnum.CameraSize = 5
SeasonEntryEnum.ResPath = {
	"_m_s15_chess_3",
	"_m_s15_chess_2",
	"_m_s15_chess_1"
}

return SeasonEntryEnum
