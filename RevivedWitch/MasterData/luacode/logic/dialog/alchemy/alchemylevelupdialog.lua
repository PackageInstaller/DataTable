-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/alchemy/alchemylevelupdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAlchemyLvCfg = (BeanManager.GetTableByName)("courtyard.calchemylv")
local CAlchemyStageCfg = (BeanManager.GetTableByName)("courtyard.calchemystage")
local MaxAlchemyStage = ((NekoData.BehaviorManager).BM_Alchemy):GetMaxAlchemyStage()
local AlchemyLevelUpDialog = class("AlchemyLevelUpDialog", Dialog)
AlchemyLevelUpDialog.AssetBundleName = "ui/layouts.yard"
AlchemyLevelUpDialog.AssetName = "AlchemyLevelUp"
AlchemyLevelUpDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AlchemyLevelUpDialog
  ((AlchemyLevelUpDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

AlchemyLevelUpDialog.OnCreate = function(self)
  -- function num : 0_1
  self._lastLevelTxt = self:GetChild("Level/Num")
  self._curLevelTxt = self:GetChild("Level/Num2")
  self._lastAddRateTxt = self:GetChild("Probability/Num")
  self._curAddRateTxt = self:GetChild("Probability/Num2")
  self._curLvStagePoint = self:GetChild("Stage/LvPoint1")
  self._nextLvStagePoint = self:GetChild("Stage/LvPoint2")
  self._curLvStageTitle = self:GetChild("Stage/Txt")
  self._nextLvStageTitle = self:GetChild("Stage/Txt2")
  self._stageLvUp = self:GetChild("Stage/Arrow")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

AlchemyLevelUpDialog.OnDestroy = function(self)
  -- function num : 0_2
end

AlchemyLevelUpDialog.SetAlchemyLevel = function(self, lastLevel, curLevel)
  -- function num : 0_3 , upvalues : CAlchemyLvCfg, _ENV, MaxAlchemyStage, CAlchemyStageCfg
  self._lastRecord = CAlchemyLvCfg:GetRecorder(lastLevel)
  self._curRecord = CAlchemyLvCfg:GetRecorder(curLevel)
  ;
  (self._lastLevelTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1285, {lastLevel}))
  ;
  (self._curLevelTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1285, {curLevel}))
  ;
  (self._lastAddRateTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1286, {(self._lastRecord).byproductProbability}))
  ;
  (self._curAddRateTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1286, {(self._curRecord).byproductProbability}))
  local curStage = (self._lastRecord).alchemystage - 1
  local nextStage = (self._curRecord).alchemystage - 1
  local pointStr = ""
  for i = 1, MaxAlchemyStage do
    if i <= curStage then
      pointStr = pointStr .. "1"
    else
      pointStr = pointStr .. "0"
    end
  end
  ;
  (self._curLvStagePoint):SetText(pointStr)
  pointStr = ""
  for i = 1, MaxAlchemyStage do
    if i <= nextStage then
      pointStr = pointStr .. "1"
    else
      pointStr = pointStr .. "0"
    end
  end
  ;
  (self._nextLvStagePoint):SetText(pointStr)
  local curStageRecorder = CAlchemyStageCfg:GetRecorder((self._lastRecord).alchemystage)
  local nextStageRecorder = CAlchemyStageCfg:GetRecorder((self._curRecord).alchemystage)
  ;
  (self._curLvStageTitle):SetText((TextManager.GetText)(curStageRecorder.stagenametxtid))
  ;
  (self._nextLvStageTitle):SetText((TextManager.GetText)(nextStageRecorder.stagenametxtid))
  ;
  (self._stageLvUp):SetActive(curStage < nextStage)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

AlchemyLevelUpDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

return AlchemyLevelUpDialog

