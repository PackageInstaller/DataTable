-- chunkname: @modules/logic/versionactivity4_0/deleike/define/DeleikeEnum.lua

module("modules.logic.versionactivity4_0.deleike.define.DeleikeEnum", package.seeall)

local DeleikeEnum = _M

DeleikeEnum.GridUnit = 90
DeleikeEnum.GridColumn = 12
DeleikeEnum.GridRow = 10
DeleikeEnum.PlayerSpeed = 300
DeleikeEnum.PlayerSlowSpeed = DeleikeEnum.PlayerSpeed * 0.25
DeleikeEnum.CubeSize = Vector2.New(92, 116)
DeleikeEnum.NormalTileArtOffsetY = -13
DeleikeEnum.TileType = {
	Line = 3,
	Grid = 5,
	Outer = 1,
	Anchor = 2,
	Bg = 4,
	Normal = 0
}
DeleikeEnum.TileTypeToName = {}

for k, v in pairs(DeleikeEnum.TileType) do
	DeleikeEnum.TileTypeToName[v] = k
end

DeleikeEnum.LineLength = 2048
DeleikeEnum.BgWidth = 2592
DeleikeEnum.BgHeight = 1080
DeleikeEnum.GridTileWidth = 1092
DeleikeEnum.GridTileHeight = 912
DeleikeEnum.CircleShowTime = 2
DeleikeEnum.CameraEdgeMargin = 120
DeleikeEnum.TriggerType = {
	Skill2 = "Skill2",
	Door = "Door",
	Skill1 = "Skill1"
}
DeleikeEnum.SkillWidth = 5000
DeleikeEnum.SkilllHeight = 160
DeleikeEnum.Skill2MaxShift = 225
DeleikeEnum.PlayerRadius = 43
DeleikeEnum.JoyStickInnerRadius = 20
DeleikeEnum.JoyStickOuterRadius = 120
DeleikeEnum.JoyStickSmoothSpeed = 7.5
DeleikeEnum.LineStatus = {
	CanCut = 2,
	UnCut = 3,
	PreCut = 1
}
DeleikeEnum.GameScenePath = "ui/viewres/versionactivity_4_0/v4a0_deleike/v4a0_deleike_gamescene.prefab"

return DeleikeEnum
