-- chunkname: @modules/logic/scene/SceneMacro.lua

module("modules.logic.scene.SceneMacro", package.seeall)

local SceneMacro = class()

SceneType.Summon = 4
SceneType.SelectFb = 5
SceneType.Adventure = 8
SceneType.Newbie = 9
SceneType.Room = 10
SceneType.Explore = 11
SceneType.PushBox = 12
SceneType.Cachot = 13
SceneType.Rouge = 14
SceneType.Survival = 15
SceneType.SurvivalShelter = 16
SceneType.SurvivalSummaryAct = 17
SceneType.Rouge2 = 18
SceneType.Udimo = 19
SceneType.PartyGame = 20
SceneType.PartyGameLobby = 21
SceneType.ChatRoom = 22
SceneType.SurvivalCollectionRoom = 23
SceneType.RacingCar = 24
SceneType.NameDict = {}

for k, v in pairs(SceneType) do
	SceneType.NameDict[v] = k
end

SceneTag.UnitCamera = "UnitCamera"
SceneTag.UICamera = "UICamera"
SceneTag.UnitPlayer = "UnitPlayer"
SceneTag.UnitMonster = "UnitMonster"
SceneTag.UnitNpc = "UnitNpc"
SceneTag.FightStartTrigger = "FightStartTrigger"
SceneTag.NPCTrigger = "NPCTrigger"
SceneTag.RoomMapBlock = "RoomMapBlock"
SceneTag.RoomEmptyBlock = "RoomEmptyBlock"
SceneTag.RoomInventoryBlock = "RoomInventoryBlock"
SceneTag.RoomFakeBlock = "RoomFakeBlock"
SceneTag.RoomBuilding = "RoomBuilding"
SceneTag.RoomCharacter = "RoomCharacter"
SceneTag.RoomResource = "RoomResource"
SceneTag.RoomInitBuilding = "RoomInitBuilding"
SceneTag.RoomPartBuilding = "RoomPartBuilding"
SceneTag.RoomLand = "RoomLand"
SceneLayer.UI3D = "UI3D"
SceneLayer.Unit = "Unit"
SceneLayer.Scene = "Scene"
SceneLayer.SceneEffect = "SceneEffect"
SceneLayer.Nothing = "Nothing"
SceneLayer.Monster = "Monster"
SceneLayer.Ignore = "Ignore"
SceneLayer.UI3DAfterPostProcess = "UI3DAfterPostProcess"

return SceneMacro
