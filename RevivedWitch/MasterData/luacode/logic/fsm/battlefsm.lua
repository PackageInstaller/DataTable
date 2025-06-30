-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/battlefsm.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleFSM = strictclass("BattleFSM", require("framework.fsm"))
BattleFSM.Init = function(self)
  -- function num : 0_0 , upvalues : BattleFSM, _ENV
  ((BattleFSM.super).Init)(self)
  local BattleEndType = (BattleClientProtocolManager.GetBeanDef)("data.battleendtype")
  self._parameters = {toBattle = false, battleLogicEnd = false, battleResult = 0, toSoul = false, soulNum = 0, toAccounts = false, toBattleEnd = false, victoryEnd = false, loseEnd = false, retreatEnd = false, pasue = false, toTimeline = false, toUnloadTimeline = false, chatDialogEnd = false, chatDialogId = 0, timelineObjectName = "", pauseType = 0, toBreak = true, battleType = 0}
  self._states = {"Init", "Battle", "BattleEnding", "TimeLine", "Soul", "Victory", "Lose", "Retreat", "Accounts", "BattleEnd", "LoadTimeLine", "UnloadTimeLine", "LoadStory"}
  self._transGraphs = {
{from = "Init", to = "Battle", 
conditions = {
{parameterName = "toBattle", op = "eq", value = true}
}
}
, 
{from = "Battle", to = "LoadTimeLine", 
conditions = {
{parameterName = "pasue", op = "eq", value = true}
}
}
, 
{from = "LoadTimeLine", to = "TimeLine", 
conditions = {
{parameterName = "toTimeline", op = "eq", value = true}
}
}
, 
{from = "Battle", to = "BattleEnding", 
conditions = {
{parameterName = "battleLogicEnd", op = "eq", value = true}
}
}
, 
{from = "BattleEnding", to = "Soul", 
conditions = {
{parameterName = "toSoul", op = "eq", value = true}
, 
{parameterName = "battleLogicEnd", op = "eq", value = true}
, 
{parameterName = "toBreak", op = "eq", value = false}
}
}
, 
{from = "BattleEnding", to = "Victory", 
conditions = {
{parameterName = "battleLogicEnd", op = "eq", value = true}
, 
{parameterName = "battleResult", op = "eq", value = BattleEndType.LeftWin}
, 
{parameterName = "toBreak", op = "eq", value = false}
}
}
, 
{from = "BattleEnding", to = "Lose", 
conditions = {
{parameterName = "battleLogicEnd", op = "eq", value = true}
, 
{parameterName = "battleResult", op = "eq", value = BattleEndType.RightWin}
, 
{parameterName = "toBreak", op = "eq", value = false}
}
}
, 
{from = "BattleEnding", to = "Retreat", 
conditions = {
{parameterName = "battleLogicEnd", op = "eq", value = true}
, 
{parameterName = "battleResult", op = "eq", value = BattleEndType.Retreat}
, 
{parameterName = "toBreak", op = "eq", value = false}
}
}
, 
{from = "BattleEnding", to = "Victory", 
conditions = {
{parameterName = "battleLogicEnd", op = "eq", value = true}
, 
{parameterName = "battleResult", op = "eq", value = BattleEndType.LeftWinCBattleKill}
, 
{parameterName = "toBreak", op = "eq", value = false}
}
}
, 
{from = "BattleEnding", to = "Victory", 
conditions = {
{parameterName = "battleLogicEnd", op = "eq", value = true}
, 
{parameterName = "battleResult", op = "eq", value = BattleEndType.SkipWin}
, 
{parameterName = "toBreak", op = "eq", value = false}
}
}
, 
{from = "BattleEnding", to = "Lose", 
conditions = {
{parameterName = "battleLogicEnd", op = "eq", value = true}
, 
{parameterName = "battleResult", op = "eq", value = BattleEndType.RightWinCBattleKill}
, 
{parameterName = "toBreak", op = "eq", value = false}
}
}
, 
{from = "BattleEnding", to = "Lose", 
conditions = {
{parameterName = "battleLogicEnd", op = "eq", value = true}
, 
{parameterName = "battleResult", op = "eq", value = BattleEndType.RightWinOverTime}
, 
{parameterName = "toBreak", op = "eq", value = false}
}
}
, 
{from = "BattleEnding", to = "Victory", 
conditions = {
{parameterName = "battleLogicEnd", op = "eq", value = true}
, 
{parameterName = "battleResult", op = "eq", value = BattleEndType.LeftWinOverTime}
, 
{parameterName = "toBreak", op = "eq", value = false}
}
}
, 
{from = "BattleEnding", to = "Victory", 
conditions = {
{parameterName = "battleLogicEnd", op = "eq", value = true}
, 
{parameterName = "battleResult", op = "eq", value = BattleEndType.LoseSettle}
, 
{parameterName = "toBreak", op = "eq", value = false}
}
}
, 
{from = "TimeLine", to = "UnloadTimeLine", 
conditions = {
{parameterName = "toUnloadTimeline", op = "eq", value = true}
, 
{parameterName = "chatDialogEnd", op = "eq", value = true}
}
}
, 
{from = "UnloadTimeLine", to = "Battle", 
conditions = {
{parameterName = "pasue", op = "eq", value = false}
}
}
, 
{from = "Soul", to = "Victory", 
conditions = {
{parameterName = "soulNum", op = "eq", value = 0}
}
}
, 
{from = "Victory", to = "Accounts", 
conditions = {
{parameterName = "toAccounts", op = "eq", value = true}
, 
{parameterName = "victoryEnd", op = "eq", value = true}
}
}
, 
{from = "Lose", to = "Accounts", 
conditions = {
{parameterName = "toAccounts", op = "eq", value = true}
, 
{parameterName = "loseEnd", op = "eq", value = true}
}
}
, 
{from = "Retreat", to = "Accounts", 
conditions = {
{parameterName = "toAccounts", op = "eq", value = true}
, 
{parameterName = "retreatEnd", op = "eq", value = true}
}
}
, 
{from = "Accounts", to = "LoadStory", 
conditions = {
{parameterName = "battleType", op = "ne", value = 0}
, 
{parameterName = "toBattleEnd", op = "eq", value = true}
}
}
, 
{from = "LoadStory", to = "BattleEnd", 
conditions = {
{parameterName = "battleType", op = "eq", value = 0}
, 
{parameterName = "toBattleEnd", op = "eq", value = true}
}
}
}
  self._initialState = "Init"
  self:CheckError()
end

return BattleFSM

