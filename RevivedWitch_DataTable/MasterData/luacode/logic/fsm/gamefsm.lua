-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/gamefsm.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GameFSM = strictclass("GameFSM", require("framework.fsm"))
GameFSM.Init = function(self)
  -- function num : 0_0 , upvalues : GameFSM
  ((GameFSM.super).Init)(self)
  self._parameters = {loadedModalBack = false, toLogin = "", toGame = false, toPalyPV = false, loadSceneEnd = false, sceneLoadingId = 0, sceneId = 0, battleId = 0, battleLoadingEnd = false, crossingEnd = false, toBreakOrReconnect = false, selectSummerEchoesEvent = false}
  self._states = {"Init", "PlayPV", "Login", "Game", "BreakOrReconnect", "LoadScene", "SceneLoading", "MainCity", "MainCityBattleLoading", "MainCityBattle", "MainCityBattleCrossing", "DungeonLoading", "TowerLoading", "TowerV2Loading", "TowerV2BattleLoading", "TowerV2Battle", "TowerV2BattleCrossing", "Dungeon", "DungeonBattleLoading", "DungeonBattle", "DungeonBattleCrossing", "FirstScene", "TopDown", "TopDownBattleLoading", "TopDownBattle", "TopDownBattleCrossing", "Scene20006_20009", "Scene20006_20009BattleLoading", "Scene20006_20009Battle", "Scene20006_20009BattleCrossing", "CourtYard", "SwimSuitActivity", "SwimSuitActivityBattleLoading", "SwimSuitActivityBattle", "SwimSuitActivityBattleCrossing", "TestBattle", "Scene30007_30010"}
  self._transGraphs = {
{from = "Init", to = "PlayPV", 
conditions = {
{parameterName = "toPalyPV", op = "eq", value = true}
}
}
, 
{from = "PlayPV", to = "Login", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "Init"}
}
}
, 
{from = "BreakOrReconnect", to = "Login", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "Reconnection"}
}
}
, 
{from = "BreakOrReconnect", to = "Login", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "Disconnection"}
}
}
, 
{from = "BreakOrReconnect", to = "Login", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "ReconnectionFromLoginState"}
}
}
, 
{from = "BreakOrReconnect", to = "Login", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "DisconnectionFromLoginState"}
}
}
, 
{from = "Login", to = "Game", 
conditions = {
{parameterName = "toGame", op = "eq", value = true}
}
}
, 
{from = "Game", to = "LoadScene", 
conditions = {
{parameterName = "sceneLoadingId", op = "ne", value = 0}
}
}
, 
{from = "LoadScene", to = "SceneLoading", 
conditions = {
{parameterName = "sceneLoadingId", op = "ge", value = 20000}
, 
{parameterName = "sceneLoadingId", op = "ne", value = 30005}
, 
{parameterName = "sceneLoadingId", op = "ne", value = 30006}
, 
{parameterName = "sceneLoadingId", op = "ne", value = 30009}
, 
{parameterName = "sceneLoadingId", op = "ne", value = 30012}
, 
{parameterName = "sceneLoadingId", op = "ne", value = 30014}
, 
{parameterName = "sceneLoadingId", op = "lt", value = 40000}
, 
{parameterName = "loadSceneEnd", op = "eq", value = true}
}
}
, 
{from = "LoadScene", to = "DungeonLoading", 
conditions = {
{parameterName = "sceneLoadingId", op = "lt", value = 20000}
, 
{parameterName = "loadSceneEnd", op = "eq", value = true}
}
}
, 
{from = "LoadScene", to = "DungeonLoading", 
conditions = {
{parameterName = "sceneLoadingId", op = "eq", value = 30005}
, 
{parameterName = "loadSceneEnd", op = "eq", value = true}
}
}
, 
{from = "LoadScene", to = "DungeonLoading", 
conditions = {
{parameterName = "sceneLoadingId", op = "eq", value = 30006}
, 
{parameterName = "loadSceneEnd", op = "eq", value = true}
}
}
, 
{from = "LoadScene", to = "DungeonLoading", 
conditions = {
{parameterName = "sceneLoadingId", op = "eq", value = 30012}
, 
{parameterName = "loadSceneEnd", op = "eq", value = true}
}
}
, 
{from = "LoadScene", to = "DungeonLoading", 
conditions = {
{parameterName = "sceneLoadingId", op = "ge", value = 40000}
, 
{parameterName = "loadSceneEnd", op = "eq", value = true}
}
}
, 
{from = "LoadScene", to = "TowerLoading", 
conditions = {
{parameterName = "sceneLoadingId", op = "eq", value = 30009}
, 
{parameterName = "loadSceneEnd", op = "eq", value = true}
}
}
, 
{from = "LoadScene", to = "TowerV2Loading", 
conditions = {
{parameterName = "sceneLoadingId", op = "eq", value = 30014}
, 
{parameterName = "loadSceneEnd", op = "eq", value = true}
}
}
, 
{from = "SceneLoading", to = "LoadScene", 
conditions = {
{parameterName = "sceneLoadingId", op = "ne", value = 0}
, 
{parameterName = "sceneId", op = "ne", value = 0}
}
}
, 
{from = "DungeonLoading", to = "LoadScene", 
conditions = {
{parameterName = "sceneLoadingId", op = "ne", value = 0}
, 
{parameterName = "sceneId", op = "ne", value = 0}
}
}
, 
{from = "TowerLoading", to = "LoadScene", 
conditions = {
{parameterName = "sceneLoadingId", op = "ne", value = 0}
, 
{parameterName = "sceneId", op = "ne", value = 0}
}
}
, 
{from = "TowerV2Loading", to = "LoadScene", 
conditions = {
{parameterName = "sceneLoadingId", op = "ne", value = 0}
, 
{parameterName = "sceneId", op = "ne", value = 0}
}
}
, 
{from = "SceneLoading", to = "MainCity", 
conditions = {
{parameterName = "sceneId", op = "eq", value = 30001}
, 
{parameterName = "sceneLoadingId", op = "eq", value = 0}
}
}
, 
{from = "SceneLoading", to = "FirstScene", 
conditions = {
{parameterName = "sceneId", op = "eq", value = 30002}
, 
{parameterName = "sceneLoadingId", op = "eq", value = 0}
}
}
, 
{from = "SceneLoading", to = "FirstScene", 
conditions = {
{parameterName = "sceneId", op = "eq", value = 30003}
, 
{parameterName = "sceneLoadingId", op = "eq", value = 0}
}
}
, 
{from = "SceneLoading", to = "Scene20006_20009", 
conditions = {
{parameterName = "sceneId", op = "eq", value = 20006}
, 
{parameterName = "sceneLoadingId", op = "eq", value = 0}
}
}
, 
{from = "SceneLoading", to = "Scene20006_20009", 
conditions = {
{parameterName = "sceneId", op = "eq", value = 20009}
, 
{parameterName = "sceneLoadingId", op = "eq", value = 0}
}
}
, 
{from = "SceneLoading", to = "Scene30007_30010", 
conditions = {
{parameterName = "sceneId", op = "eq", value = 30007}
, 
{parameterName = "sceneLoadingId", op = "eq", value = 0}
}
}
, 
{from = "SceneLoading", to = "Scene30007_30010", 
conditions = {
{parameterName = "sceneId", op = "eq", value = 30010}
, 
{parameterName = "sceneLoadingId", op = "eq", value = 0}
}
}
, 
{from = "Scene30007_30010", to = "LoadScene", 
conditions = {
{parameterName = "sceneLoadingId", op = "ne", value = 0}
}
}
, 
{from = "SceneLoading", to = "CourtYard", 
conditions = {
{parameterName = "sceneId", op = "eq", value = 30004}
, 
{parameterName = "sceneLoadingId", op = "eq", value = 0}
}
}
, 
{from = "SceneLoading", to = "SwimSuitActivity", 
conditions = {
{parameterName = "sceneId", op = "eq", value = 30015}
, 
{parameterName = "sceneLoadingId", op = "eq", value = 0}
}
}
, 
{from = "SceneLoading", to = "SwimSuitActivity", 
conditions = {
{parameterName = "sceneId", op = "eq", value = 30017}
, 
{parameterName = "sceneLoadingId", op = "eq", value = 0}
}
}
, 
{from = "DungeonLoading", to = "Dungeon", 
conditions = {
{parameterName = "sceneLoadingId", op = "eq", value = 0}
, 
{parameterName = "sceneId", op = "gt", value = 0}
, 
{parameterName = "sceneId", op = "ne", value = 11000}
, 
{parameterName = "sceneId", op = "lt", value = 20000}
}
}
, 
{from = "DungeonLoading", to = "Dungeon", 
conditions = {
{parameterName = "sceneLoadingId", op = "eq", value = 0}
, 
{parameterName = "sceneId", op = "gt", value = 0}
, 
{parameterName = "sceneId", op = "ne", value = 11000}
, 
{parameterName = "sceneId", op = "eq", value = 30005}
}
}
, 
{from = "DungeonLoading", to = "Dungeon", 
conditions = {
{parameterName = "sceneLoadingId", op = "eq", value = 0}
, 
{parameterName = "sceneId", op = "gt", value = 0}
, 
{parameterName = "sceneId", op = "ne", value = 11000}
, 
{parameterName = "sceneId", op = "eq", value = 30012}
}
}
, 
{from = "DungeonLoading", to = "Dungeon", 
conditions = {
{parameterName = "sceneLoadingId", op = "eq", value = 0}
, 
{parameterName = "sceneId", op = "gt", value = 0}
, 
{parameterName = "sceneId", op = "ne", value = 11000}
, 
{parameterName = "sceneId", op = "ge", value = 40000}
}
}
, 
{from = "DungeonLoading", to = "TopDown", 
conditions = {
{parameterName = "sceneLoadingId", op = "eq", value = 0}
, 
{parameterName = "sceneId", op = "eq", value = 11000}
}
}
, 
{from = "TowerLoading", to = "Dungeon", 
conditions = {
{parameterName = "sceneLoadingId", op = "eq", value = 0}
, 
{parameterName = "sceneId", op = "eq", value = 30009}
}
}
, 
{from = "TowerV2Loading", to = "Dungeon", 
conditions = {
{parameterName = "sceneLoadingId", op = "eq", value = 0}
, 
{parameterName = "sceneId", op = "eq", value = 30014}
}
}
, 
{from = "MainCity", to = "LoadScene", 
conditions = {
{parameterName = "sceneLoadingId", op = "ne", value = 0}
}
}
, 
{from = "MainCity", to = "MainCityBattleLoading", 
conditions = {
{parameterName = "battleId", op = "ne", value = 0}
}
}
, 
{from = "MainCityBattleLoading", to = "MainCityBattle", 
conditions = {
{parameterName = "battleLoadingEnd", op = "eq", value = true}
}
}
, 
{from = "MainCityBattle", to = "MainCityBattleCrossing", 
conditions = {
{parameterName = "battleId", op = "eq", value = 0}
}
}
, 
{from = "MainCityBattleCrossing", to = "MainCity", 
conditions = {
{parameterName = "crossingEnd", op = "eq", value = true}
}
}
, 
{from = "FirstScene", to = "LoadScene", 
conditions = {
{parameterName = "sceneLoadingId", op = "ne", value = 0}
}
}
, 
{from = "Dungeon", to = "LoadScene", 
conditions = {
{parameterName = "sceneLoadingId", op = "ne", value = 0}
}
}
, 
{from = "Dungeon", to = "DungeonBattleLoading", 
conditions = {
{parameterName = "battleId", op = "ne", value = 0}
, 
{parameterName = "sceneId", op = "ne", value = 30014}
}
}
, 
{from = "DungeonBattleLoading", to = "DungeonBattle", 
conditions = {
{parameterName = "battleLoadingEnd", op = "eq", value = true}
}
}
, 
{from = "DungeonBattle", to = "DungeonBattleCrossing", 
conditions = {
{parameterName = "battleId", op = "eq", value = 0}
, 
{parameterName = "sceneLoadingId", op = "eq", value = 0}
}
}
, 
{from = "DungeonBattle", to = "LoadScene", 
conditions = {
{parameterName = "battleId", op = "eq", value = 0}
, 
{parameterName = "sceneLoadingId", op = "ne", value = 0}
}
}
, 
{from = "DungeonBattleCrossing", to = "Dungeon", 
conditions = {
{parameterName = "crossingEnd", op = "eq", value = true}
}
}
, 
{from = "Dungeon", to = "TowerV2BattleLoading", 
conditions = {
{parameterName = "battleId", op = "ne", value = 0}
, 
{parameterName = "sceneId", op = "eq", value = 30014}
}
}
, 
{from = "TowerV2BattleLoading", to = "TowerV2Battle", 
conditions = {
{parameterName = "battleLoadingEnd", op = "eq", value = true}
}
}
, 
{from = "TowerV2Battle", to = "TowerV2BattleCrossing", 
conditions = {
{parameterName = "battleId", op = "eq", value = 0}
}
}
, 
{from = "TowerV2BattleCrossing", to = "Dungeon", 
conditions = {
{parameterName = "crossingEnd", op = "eq", value = true}
}
}
, 
{from = "TopDown", to = "LoadScene", 
conditions = {
{parameterName = "sceneLoadingId", op = "ne", value = 0}
}
}
, 
{from = "TopDown", to = "TopDownBattleLoading", 
conditions = {
{parameterName = "battleId", op = "ne", value = 0}
}
}
, 
{from = "TopDownBattleLoading", to = "TopDownBattle", 
conditions = {
{parameterName = "battleLoadingEnd", op = "eq", value = true}
}
}
, 
{from = "TopDownBattle", to = "TopDownBattleCrossing", 
conditions = {
{parameterName = "battleId", op = "eq", value = 0}
, 
{parameterName = "sceneLoadingId", op = "eq", value = 0}
}
}
, 
{from = "TopDownBattle", to = "LoadScene", 
conditions = {
{parameterName = "battleId", op = "eq", value = 0}
, 
{parameterName = "sceneLoadingId", op = "ne", value = 0}
}
}
, 
{from = "TopDownBattleCrossing", to = "TopDown", 
conditions = {
{parameterName = "crossingEnd", op = "eq", value = true}
}
}
, 
{from = "Scene20006_20009", to = "LoadScene", 
conditions = {
{parameterName = "sceneLoadingId", op = "ne", value = 0}
}
}
, 
{from = "Scene20006_20009", to = "Scene20006_20009BattleLoading", 
conditions = {
{parameterName = "battleId", op = "ne", value = 0}
}
}
, 
{from = "Scene20006_20009BattleLoading", to = "Scene20006_20009Battle", 
conditions = {
{parameterName = "battleLoadingEnd", op = "eq", value = true}
}
}
, 
{from = "Scene20006_20009Battle", to = "Scene20006_20009BattleCrossing", 
conditions = {
{parameterName = "battleId", op = "eq", value = 0}
, 
{parameterName = "sceneLoadingId", op = "eq", value = 0}
}
}
, 
{from = "Scene20006_20009Battle", to = "LoadScene", 
conditions = {
{parameterName = "battleId", op = "eq", value = 0}
, 
{parameterName = "sceneLoadingId", op = "ne", value = 0}
}
}
, 
{from = "Scene20006_20009BattleCrossing", to = "Scene20006_20009", 
conditions = {
{parameterName = "crossingEnd", op = "eq", value = true}
}
}
, 
{from = "CourtYard", to = "LoadScene", 
conditions = {
{parameterName = "sceneLoadingId", op = "ne", value = 0}
}
}
, 
{from = "SwimSuitActivity", to = "LoadScene", 
conditions = {
{parameterName = "sceneLoadingId", op = "ne", value = 0}
}
}
, 
{from = "SwimSuitActivity", to = "SwimSuitActivityBattleLoading", 
conditions = {
{parameterName = "battleId", op = "ne", value = 0}
, 
{parameterName = "sceneId", op = "ne", value = 30014}
}
}
, 
{from = "SwimSuitActivityBattleLoading", to = "SwimSuitActivityBattle", 
conditions = {
{parameterName = "battleLoadingEnd", op = "eq", value = true}
}
}
, 
{from = "SwimSuitActivityBattle", to = "SwimSuitActivityBattleCrossing", 
conditions = {
{parameterName = "battleId", op = "eq", value = 0}
, 
{parameterName = "sceneLoadingId", op = "eq", value = 0}
}
}
, 
{from = "SwimSuitActivityBattle", to = "LoadScene", 
conditions = {
{parameterName = "battleId", op = "eq", value = 0}
, 
{parameterName = "sceneLoadingId", op = "ne", value = 0}
}
}
, 
{from = "SwimSuitActivityBattleCrossing", to = "SwimSuitActivity", 
conditions = {
{parameterName = "crossingEnd", op = "eq", value = true}
}
}
, 
{from = "Login", to = "BreakOrReconnect", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "BreakOrReconnection"}
}
}
, 
{from = "Game", to = "BreakOrReconnect", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "BreakOrReconnection"}
}
}
, 
{from = "LoadScene", to = "BreakOrReconnect", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "BreakOrReconnection"}
}
}
, 
{from = "MainCity", to = "BreakOrReconnect", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "BreakOrReconnection"}
}
}
, 
{from = "MainCityBattleLoading", to = "BreakOrReconnect", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "BreakOrReconnection"}
}
}
, 
{from = "MainCityBattle", to = "BreakOrReconnect", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "BreakOrReconnection"}
, 
{parameterName = "toBreakOrReconnect", op = "eq", value = true}
}
}
, 
{from = "Dungeon", to = "BreakOrReconnect", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "BreakOrReconnection"}
}
}
, 
{from = "DungeonBattleLoading", to = "BreakOrReconnect", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "BreakOrReconnection"}
}
}
, 
{from = "DungeonBattle", to = "BreakOrReconnect", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "BreakOrReconnection"}
, 
{parameterName = "toBreakOrReconnect", op = "eq", value = true}
}
}
, 
{from = "FirstScene", to = "BreakOrReconnect", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "BreakOrReconnection"}
}
}
, 
{from = "Scene30007_30010", to = "BreakOrReconnect", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "BreakOrReconnection"}
}
}
, 
{from = "TopDown", to = "BreakOrReconnect", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "BreakOrReconnection"}
}
}
, 
{from = "TopDownBattleLoading", to = "BreakOrReconnect", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "BreakOrReconnection"}
}
}
, 
{from = "TopDownBattle", to = "BreakOrReconnect", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "BreakOrReconnection"}
, 
{parameterName = "toBreakOrReconnect", op = "eq", value = true}
}
}
, 
{from = "Scene20006_20009", to = "BreakOrReconnect", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "BreakOrReconnection"}
}
}
, 
{from = "Scene20006_20009BattleLoading", to = "BreakOrReconnect", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "BreakOrReconnection"}
}
}
, 
{from = "Scene20006_20009Battle", to = "BreakOrReconnect", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "BreakOrReconnection"}
, 
{parameterName = "toBreakOrReconnect", op = "eq", value = true}
}
}
, 
{from = "TowerV2BattleLoading", to = "BreakOrReconnect", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "BreakOrReconnection"}
}
}
, 
{from = "TowerV2Battle", to = "BreakOrReconnect", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "BreakOrReconnection"}
, 
{parameterName = "toBreakOrReconnect", op = "eq", value = true}
}
}
, 
{from = "CourtYard", to = "BreakOrReconnect", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "BreakOrReconnection"}
}
}
, 
{from = "SwimSuitActivity", to = "BreakOrReconnect", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "BreakOrReconnection"}
}
}
, 
{from = "SwimSuitActivityBattle", to = "BreakOrReconnect", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "BreakOrReconnection"}
, 
{parameterName = "toBreakOrReconnect", op = "eq", value = true}
}
}
, 
{from = "BreakOrReconnect", to = "BreakOrReconnect", 
conditions = {
{parameterName = "toLogin", op = "eq", value = "BreakOrReconnection"}
}
}
}
  self._initialState = "Init"
  self:CheckError()
end

return GameFSM

