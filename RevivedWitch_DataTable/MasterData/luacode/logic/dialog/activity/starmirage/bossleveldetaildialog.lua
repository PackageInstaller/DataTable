-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirage/bossleveldetaildialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local ColumnNum = 2
local Num = 4
local CStarrymirrorlevel = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorlevel")
local CStarryMirrorEnemyBoost = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorenemyboost")
local CStarryMirrorDiffculty = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrordiffculty")
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local LevelStateEnum = (LuaNetManager.GetBeanDef)("protocol.battle.activitybattlenode")
local BossLevelDetailDialog = class("BossLevelDetailDialog", Dialog)
BossLevelDetailDialog.AssetBundleName = "ui/layouts.activitystar"
BossLevelDetailDialog.AssetName = "ActivityStarBossDetail"
BossLevelDetailDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BossLevelDetailDialog
  ((BossLevelDetailDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._rewardList = {}
  self._entryList = {}
end

BossLevelDetailDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, GridFrame, ColumnNum
  self._backImage = self:GetChild("Back/Panel/BackImage")
  self._tips = self:GetChild("Back/Panel/Tips")
  self._model = self:GetChild("Back/Panel/Model/Model")
  self._recommendLevelTxt = self:GetChild("Back/Panel/Level/Txt2")
  self._difficultyTxt = self:GetChild("Back/Panel/DifficultyLevel")
  self._describe = self:GetChild("Back/Panel/Describe")
  self._titleImg = self:GetChild("Back/Panel/TextImg")
  self._effect = self:GetChild("Back/Effect")
  self._power = self:GetChild("Back/Panel/CostBack/Txt2")
  self._powerRed = self:GetChild("Back/Panel/CostBack/Txt2Red")
  self._rewardPanel = self:GetChild("Back/Panel/CellPanel")
  self._goBtn = self:GetChild("Back/Panel/GoBtn")
  self._closeBtn = self:GetChild("Back/Panel/CloseBtn")
  self._rewardFrame = (TableFrame.Create)(self._rewardPanel, self, false, false)
  self._rewardFrame_width = (self._rewardPanel):GetRectSize()
  self._rewardFrame_anchoredx = (self._rewardPanel):GetAnchoredPosition()
  self._strengthenPanel = self:GetChild("Back/Panel/BossBuff")
  self._strengthenPanel_entryIBtn = self:GetChild("Back/Panel/BossBuff/Ibtn")
  self._strengthenPanel_entryPanel = self:GetChild("Back/Panel/BossBuff/Frame")
  self._strengthenPanel_entryFrame = (GridFrame.Create)(self._strengthenPanel_entryPanel, self, true, ColumnNum)
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._strengthenPanel_entryIBtn):Subscribe_PointerClickEvent(self.OnEntryIBtnClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnRootWindowClicked, self)
end

BossLevelDetailDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._strengthenPanel_entryFrame):Destroy()
  ;
  (self._rewardFrame):Destroy()
  ;
  (DialogManager.DestroySingletonDialog)("activity.starmirage.entrydetaildialog")
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
end

BossLevelDetailDialog.Init = function(self, delegate, data)
  -- function num : 0_3 , upvalues : CStarrymirrorlevel, _ENV, CNPCShape, Num, CStarryMirrorEnemyBoost, CStarryMirrorDiffculty, CImagePathTable
  self._delegate = delegate
  self._data = data
  local record = CStarrymirrorlevel:GetRecorder((self._data).levelId)
  ;
  (self._recommendLevelTxt):SetText(data.recommendLevel)
  ;
  (self._describe):SetText((TextManager.GetText)(record.levelinfo))
  local npcShapeRecorder = CNPCShape:GetRecorder(record.monsterformid)
  if self._handler ~= 0 then
    (self._model):ReleaseModel(self._handler)
    self._handler = 0
  end
  self._handler = (self._model):AddModelSync(npcShapeRecorder.assetBundleName, npcShapeRecorder.prefabNameUI)
  local spirit = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SpiritID)
  if spirit < record.spirit then
    (self._power):SetActive(false)
    ;
    (self._powerRed):SetActive(true)
    ;
    (self._powerRed):SetText(record.spirit)
  else
    ;
    (self._power):SetActive(true)
    ;
    (self._powerRed):SetActive(false)
    ;
    (self._power):SetText(record.spirit)
  end
  ;
  (self._difficultyTxt):SetText(((NekoData.BehaviorManager).BM_Game):GetBossRushDifficultyColorStr(data.bossLevel, "StarMirage"))
  while (self._rewardList)[#self._rewardList] do
    (table.remove)(self._rewardList, #self._rewardList)
  end
  for i,v in ipairs(data.firstItems) do
    (table.insert)(self._rewardList, {tag = "First", data = v})
  end
  ;
  (self._rewardFrame):ReloadAllCell()
  local cellPanelWidth = self._rewardFrame_width / Num * #self._rewardList
  local cellPanelHeight = (self._rewardFrame):GetTotalLength()
  ;
  (self._rewardPanel):SetSize(0, cellPanelWidth, 0, cellPanelHeight)
  ;
  (self._rewardPanel):SetAnchoredPosition(self._rewardFrame_anchoredx, self._rewardFrame_anchoredy)
  ;
  (self._rewardFrame):ReloadAllCell()
  if record.difficulty == ((DataCommon.StarMirage).Type).Hard then
    (self._strengthenPanel):SetActive(true)
    while (self._entryList)[#self._entryList] do
      (table.remove)(self._entryList, #self._entryList)
    end
    local record = CStarryMirrorEnemyBoost:GetRecorder((self._data).levelId)
    for i,v in ipairs(record.boostnameid) do
      (table.insert)(self._entryList, {nameId = v, effectId = (record.boosteffectid)[i], img = (record.boosteffectpicid)[i]})
    end
    ;
    (self._strengthenPanel_entryFrame):ReloadAllCell()
  else
    do
      ;
      (self._strengthenPanel):SetActive(false)
      local diffcultyRecord = CStarryMirrorDiffculty:GetRecorder(record.difficulty)
      if not CImagePathTable:GetRecorder(diffcultyRecord.bosspage) then
        local image = DataCommon.DefaultImageAsset
      end
      ;
      (self._backImage):SetSprite(image.assetBundle, image.assetName)
      if not CImagePathTable:GetRecorder(diffcultyRecord.bossdetailtitle) then
        image = DataCommon.DefaultImageAsset
      end
      ;
      (self._titleImg):SetSprite(image.assetBundle, image.assetName)
      ;
      (self._tips):SetText((TextManager.GetText)(diffcultyRecord.bosspagetxt))
      ;
      (self._effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(diffcultyRecord.bossdetaileffect))
    end
  end
end

BossLevelDetailDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_4
  if frame == self._strengthenPanel_entryFrame then
    return #self._entryList
  else
    if frame == self._rewardFrame then
      return #self._rewardList
    end
  end
end

BossLevelDetailDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  if frame == self._strengthenPanel_entryFrame then
    return "activity.starmirage.entrycell"
  else
    if frame == self._rewardFrame then
      return "activity.starmirage.bossleveldetailrewardcell"
    end
  end
end

BossLevelDetailDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._strengthenPanel_entryFrame then
    return (self._entryList)[index]
  else
    if frame == self._rewardFrame then
      return (self._rewardList)[index]
    end
  end
end

BossLevelDetailDialog.OnEntryIBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("activity.starmirage.entrydetaildialog")):Init(self._entryList)
end

BossLevelDetailDialog.OnGoBtnClicked = function(self)
  -- function num : 0_8
  (self._delegate):OnGoBtnClicked()
end

BossLevelDetailDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9
  (self._delegate):SelectLevelById(nil)
end

BossLevelDetailDialog.OnRootWindowClicked = function(self)
  -- function num : 0_10
end

return BossLevelDetailDialog

