-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuitechoes/challenge/scoredialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local ScoreDialog = class("ScoreDialog", Dialog)
ScoreDialog.AssetBundleName = "ui/layouts.activitysummer2"
ScoreDialog.AssetName = "ActivitySummer2ChallengeBattleNum"
ScoreDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ScoreDialog
  ((ScoreDialog.super).Ctor)(self, ...)
end

ScoreDialog.OnCreate = function(self)
  -- function num : 0_1
  self._allNum = self:GetChild("AllNum")
  self._curNum = self:GetChild("GotNum")
end

ScoreDialog.Init = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local data = (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)):GetBattleResult()
  ;
  (self._allNum):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2163, {data.score}))
  ;
  (self._curNum):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2164, {data.totalScore}))
end

ScoreDialog.OnDestroy = function(self)
  -- function num : 0_3
end

return ScoreDialog

