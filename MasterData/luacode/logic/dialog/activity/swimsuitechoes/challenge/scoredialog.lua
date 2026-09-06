local TableFrame = require("framework.ui.frame.table.tableframe")
local ScoreDialog = class("ScoreDialog", Dialog)
ScoreDialog.AssetBundleName = "ui/layouts.activitysummer2"
ScoreDialog.AssetName = "ActivitySummer2ChallengeBattleNum"

function ScoreDialog:Ctor(...)
  ScoreDialog.super.Ctor(self, ...)
end

function ScoreDialog:OnCreate()
  self._allNum = self:GetChild("AllNum")
  self._curNum = self:GetChild("GotNum")
end

function ScoreDialog:Init()
  local data = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityEchoesManagerID):GetBattleResult()
  self._allNum:SetText(NekoData.BehaviorManager.BM_Message:GetString(2163, {
    data.score
  }))
  self._curNum:SetText(NekoData.BehaviorManager.BM_Message:GetString(2164, {
    data.totalScore
  }))
end

function ScoreDialog:OnDestroy()
end

return ScoreDialog
