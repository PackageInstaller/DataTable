-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/data/DomAdvEnum.lua

module("logic.extensions.domainadventure.data.DomAdvEnum", package.seeall)

local DomAdvEnum = {}

DomAdvEnum.EachReqGridMaxCount = 199
DomAdvEnum.Layer_GroundDown = 1
DomAdvEnum.Layer_GroundMid = 2
DomAdvEnum.Layer_GroundTop = 3
DomAdvEnum.Layer_Event = 4
DomAdvEnum.Layer_Fog = 5
DomAdvEnum.TagsInLayer = {}
DomAdvEnum.TagsInLayer[DomAdvEnum.Layer_GroundDown] = UnitTag.SceneElement
DomAdvEnum.TagsInLayer[DomAdvEnum.Layer_GroundMid] = UnitTag.TilingSceneElem
DomAdvEnum.TagsInLayer[DomAdvEnum.Layer_GroundTop] = UnitTag.TilingSceneElem
DomAdvEnum.TagsInLayer[DomAdvEnum.Layer_Event] = UnitTag.TilingSceneElem
DomAdvEnum.TagsInLayer[DomAdvEnum.Layer_Fog] = UnitTag.TilingSceneElem
DomAdvEnum.SortGroups_GroundDown = "SortGroups_GroundDown"
DomAdvEnum.SortGroups_ChunkMask = "SortGroups_ChunkMask"
DomAdvEnum.SortGroups_ChunkMaskTwo = "SortGroups_ChunkMaskTwo"
DomAdvEnum.SortGroups_GroundMid = "SortGroups_GroundMid"
DomAdvEnum.SortGroups_EventBuild = "SortGroups_EventBuild"
DomAdvEnum.SortGroups_GroundTop = "SortGroups_GroundTop"
DomAdvEnum.SortGroups_Tag = "SortGroups_Tag"
DomAdvEnum.SortGroups_EventIcon = "SortGroups_EventIcon"
DomAdvEnum.SortGroupsInLayer = {}
DomAdvEnum.SortGroupsInLayer[DomAdvEnum.Layer_GroundDown] = DomAdvEnum.SortGroups_GroundDown
DomAdvEnum.SortGroupsInLayer[DomAdvEnum.Layer_GroundMid] = DomAdvEnum.SortGroups_GroundMid
DomAdvEnum.SortGroupsInLayer[DomAdvEnum.Layer_GroundTop] = DomAdvEnum.SortGroups_GroundTop
DomAdvEnum.SortGroupsInLayer[DomAdvEnum.Layer_Event] = DomAdvEnum.SortGroups_EventBuild
DomAdvEnum.SortGroupsInLayer[DomAdvEnum.Layer_Fog] = DomAdvEnum.SortGroups_Tag
DomAdvEnum.SortGroupList = {
	DomAdvEnum.SortGroups_GroundDown,
	DomAdvEnum.SortGroups_ChunkMask,
	DomAdvEnum.SortGroups_ChunkMaskTwo,
	DomAdvEnum.SortGroups_GroundMid,
	DomAdvEnum.SortGroups_EventBuild,
	DomAdvEnum.SortGroups_GroundTop,
	DomAdvEnum.SortGroups_Tag,
	DomAdvEnum.SortGroups_EventIcon
}
DomAdvEnum.SortGroupIndexs = {}

for index, v in ipairs(DomAdvEnum.SortGroupList) do
	DomAdvEnum.SortGroupIndexs[v] = index
end

DomAdvEnum.domadv_buff_temp = "scene/domainadventure/domadv_buff_temp.prefab"
DomAdvEnum.ResourceList = {
	DomAdvEnum.domadv_buff_temp
}
DomAdvEnum.EventType_Empty = 0
DomAdvEnum.EventType_Fight = 1
DomAdvEnum.EventType_SolveForm = 2
DomAdvEnum.EventType_Dispatch = 3
DomAdvEnum.EventType_Game = 4
DomAdvEnum.EventType_Boss = 5
DomAdvEnum.EventType_EliteFight = 6
DomAdvEnum.ShowType_Normal = 0
DomAdvEnum.ShowType_Eye = 1
DomAdvEnum.StateFieldsList = {
	"isAdjacentUnlock",
	"isAdjacentFire",
	"isOccupied",
	"isBuff",
	"isRelFatherOcc",
	"isSealFatherOcc",
	"isBossUnlock"
}
DomAdvEnum.RankType_Boss = 1
DomAdvEnum.RankType_Elite = 2
DomAdvEnum.EventFightMode_HAND = 1
DomAdvEnum.EventFightMode_Sweet = 2
DomAdvEnum.BossFightMode_Normal = 1
DomAdvEnum.BossFightMode_Exercise = 2
DomAdvEnum.ResKey_Empty = "Empty"
DomAdvEnum.ResKey_Over = "Over"
DomAdvEnum.ResKey_BuffIcon = "BuffIcon"
DomAdvEnum.ResKey_Skin = "Skin"

return DomAdvEnum
