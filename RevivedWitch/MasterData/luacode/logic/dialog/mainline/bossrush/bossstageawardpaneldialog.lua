-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/bossrush/bossstageawardpaneldialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CBossRushStageReward = (BeanManager.GetTableByName)("dungeonselect.cbossrushstagereward")
local BossStageAwardPanelDialog = class("BossStageAwardPanelDialog", Dialog)
BossStageAwardPanelDialog.AssetBundleName = "ui/layouts.mainline"
BossStageAwardPanelDialog.AssetName = "BossRushReward"
local TableFrame = require("framework.ui.frame.table.tableframe")
BossStageAwardPanelDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BossStageAwardPanelDialog
  ((BossStageAwardPanelDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

BossStageAwardPanelDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._title = self:GetChild("Back2/Title")
  self._frame = self:GetChild("Back2/Frame")
  self._difficultyTxt = self:GetChild("Back2/Difficulty/Txt2")
  self._bossRushWeekTxt = self:GetChild("Back2/BossRushWeekTxt")
  self._helper = (TableFrame.Create)(self._frame, self, true, true, true)
  ;
  (self:GetChild("Back2/CloseBtn")):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

BossStageAwardPanelDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._helper):Destroy()
end

BossStageAwardPanelDialog.Refresh = function(self, stagelist, awardGetList, totalPassStage, bossRushId, difficultyLv, name, isWeekBoss)
  -- function num : 0_3 , upvalues : _ENV
  self._isWeekBoss = isWeekBoss
  if isWeekBoss then
    (self._bossRushWeekTxt):SetActive(true)
    ;
    (self._bossRushWeekTxt):SetText((TextManager.GetText)(1901577))
  else
    ;
    (self._bossRushWeekTxt):SetActive(false)
  end
  ;
  (self._title):SetText(name)
  ;
  (self._difficultyTxt):SetText(((NekoData.BehaviorManager).BM_Game):GetBossRushDifficultyStr(difficultyLv, isWeekBoss))
  self._bossRushId = bossRushId
  local getAwardStage = {}
  for _,stageid in pairs(awardGetList) do
    getAwardStage[stageid] = true
  end
  self._awardData = {}
  for index,stageid in pairs(stagelist) do
    local data = {}
    data.stageId = stageid
    if getAwardStage[stageid] then
      data.awardStatus = 2
    else
      if index <= totalPassStage then
        data.awardStatus = 1
      else
        data.awardStatus = 0
      end
    end
    ;
    (table.insert)(self._awardData, data)
  end
  ;
  (self._helper):ReloadAllCell()
  ;
  (self._helper):MoveToTop()
end

BossStageAwardPanelDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

BossStageAwardPanelDialog.NumberOfCell = function(self, helper)
  -- function num : 0_5
  return #self._awardData
end

BossStageAwardPanelDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_6
  return "mainline.bossrush.bossstageawardcell"
end

BossStageAwardPanelDialog.DataAtIndex = function(self, helper, index)
  -- function num : 0_7
  return (self._awardData)[index]
end

return BossStageAwardPanelDialog

