-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirage1/bossleveldetaildialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local timeutils = require("logic.utils.timeutils")
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local ColumnNum = 2
local Num = 4
local CBattleInfoTable = (BeanManager.GetTableByName)("battle.cbattleinfo")
local CMonsterConfigTable = (BeanManager.GetTableByName)("npc.cmonsterconfig")
local CStarrymirrorlevel = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorlevel")
local CStarryMirrorDiffculty = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrordiffculty")
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CRoleLevelCfgTable = (BeanManager.GetTableByName)("role.crolelevelcfg")
local LevelStateEnum = (LuaNetManager.GetBeanDef)("protocol.battle.activitybattlenode")
local BossLevelDetailDialog = class("BossLevelDetailDialog", Dialog)
BossLevelDetailDialog.AssetBundleName = "ui/layouts.activitystar2"
BossLevelDetailDialog.AssetName = "ActivityStar2BossDetail2"
BossLevelDetailDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BossLevelDetailDialog
  ((BossLevelDetailDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

BossLevelDetailDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TableFrame
  self._nodes = {
daily = {}
, 
normal = {}
}
  for k,v in pairs(self._nodes) do
    do
      local child = nil
      if k == "daily" then
        child = "Panel"
        v.leftTimeTxt = self:GetChild("Back/" .. child .. "/DifficultyLevel")
        v.costSpirit = self:GetChild("Back/" .. child .. "/CostBack/Txt2")
        v.costSpirit_red = self:GetChild("Back/" .. child .. "/CostBack/Txt2Red")
        v.awardTxt = self:GetChild("Back/" .. child .. "/LineTxt")
        v.anchor_x = (self:GetChild("Back/" .. child)):GetAnchoredPosition()
        ;
        (self:GetChild("Back/" .. child .. "/Title")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2019))
        ;
        (self:GetChild("Back/" .. child .. "/LineTxt")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2021))
        ;
        (self:GetChild("Back/" .. child .. "/CostBack/Txt1")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2023))
      else
        if k == "normal" then
          child = "Panel2"
          v.tips = self:GetChild("Back/" .. child .. "/Tips")
          v.recommendLevel_showLv = self:GetChild("Back/" .. child .. "/Detail/Txt2")
          v.recommendLevel_breakLvNum = self:GetChild("Back/" .. child .. "/Detail/BreakNumTxt")
          v.difficultyTxt = self:GetChild("Back/" .. child .. "/DifficultyLevel")
          ;
          (self:GetChild("Back/" .. child .. "/Title")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2020))
          ;
          (self:GetChild("Back/" .. child .. "/LineTxt")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2022))
          ;
          (self:GetChild("Back/" .. child .. "/Tips")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2024))
        end
      end
      v.panel = self:GetChild("Back/" .. child)
      v.backImage = self:GetChild("Back/" .. child .. "/BackImage")
      v.title = self:GetChild("Back/" .. child .. "/Title")
      v.model = self:GetChild("Back/" .. child .. "/Model/Model")
      v.lineTxt = self:GetChild("Back/" .. child .. "/LineTxt")
      v.effect = self:GetChild("Back/" .. child .. "/Effect")
      v.goBtn = self:GetChild("Back/" .. child .. "/GoBtn")
      v.goBtn_txt = self:GetChild("Back/" .. child .. "/GoBtn/_Text")
      v.rewardPanel = self:GetChild("Back/" .. child .. "/CellPanel")
      v.rewardFrame = (TableFrame.Create)(v.rewardPanel, self, false, false)
      v.rewardFrame_width = (v.rewardPanel):GetRectSize()
      v.rewardFrame_anchoredx = (v.rewardPanel):GetAnchoredPosition()
      ;
      (v.goBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, k
    self:OnGoBtnClicked(k)
  end
)
      v.rewardList = {}
    end
  end
  self._closeBtn = self:GetChild("Back/CloseBtn")
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnRootWindowClicked, self)
end

BossLevelDetailDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  for k,v in pairs(self._nodes) do
    (v.rewardFrame):Destroy()
  end
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
end

BossLevelDetailDialog.Init = function(self, delegate)
  -- function num : 0_3 , upvalues : _ENV, CStarrymirrorlevel, CNPCShape, CStarryMirrorDiffculty, LevelStateEnum, Num, CImagePathTable
  self._delegate = delegate
  for k,v in pairs(self._nodes) do
    while (v.rewardList)[#v.rewardList] do
      (table.remove)(v.rewardList, #v.rewardList)
    end
    local hideNormal, record, npcShapeRecorder, diffcultyRecord = nil, nil, nil, nil
    if k == "daily" then
      v.data = ((NekoData.BehaviorManager).BM_StarMirageCopy):GetBossLevelInfo((self._delegate)._type, 1)
      record = CStarrymirrorlevel:GetRecorder((v.data).levelId)
      npcShapeRecorder = CNPCShape:GetRecorder(record.monsterformid)
      diffcultyRecord = CStarryMirrorDiffculty:GetRecorder(record.difficulty)
      local strId, par = nil, nil
      local lefttime = (v.data).leftTime // 1000
      if lefttime < 3600 then
        strId = 2027
        par = lefttime // 60
      else
        strId = 2026
        par = lefttime // 3600
      end
      ;
      (v.leftTimeTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(strId, {par}))
      ;
      (v.costSpirit):SetText(record.spirit)
      ;
      (v.costSpirit_red):SetText(record.spirit)
      ;
      (v.costSpirit):SetActive(record.spirit <= ((NekoData.BehaviorManager).BM_Currency):GetSpirit())
      ;
      (v.costSpirit_red):SetActive(((NekoData.BehaviorManager).BM_Currency):GetSpirit() < record.spirit)
      if (v.data).status == LevelStateEnum.PASSED then
        (v.goBtn):SetInteractable(false)
        ;
        (v.goBtn_txt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2032))
      else
        (v.goBtn):SetInteractable(true)
        ;
        (v.goBtn_txt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2031))
      end
      if (v.data).firstGet then
        (v.awardTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2021))
        for i,value in ipairs((v.data).normalItems) do
          (table.insert)(v.rewardList, {tag = "Normal", data = value})
        end
      else
        (v.awardTxt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2022))
        for _,itemId in ipairs(record.firstItems) do
          (table.insert)(v.rewardList, {tag = "First", 
data = {id = itemId}
})
        end
      end
    elseif k == "normal" then
      v.data = ((NekoData.BehaviorManager).BM_StarMirageCopy):GetBossLevelInfo((self._delegate)._type, 2)
      hideNormal = not v.data
      if hideNormal then
        (v.panel):SetActive(false)
        ;
        (((self._nodes).daily).panel):SetAnchoredPosition(0, 0)
      else
        record = CStarrymirrorlevel:GetRecorder((v.data).levelId)
        npcShapeRecorder = CNPCShape:GetRecorder(record.monsterformid)
        diffcultyRecord = CStarryMirrorDiffculty:GetRecorder(record.difficulty)
        ;
        (((self._nodes).daily).panel):SetAnchoredPosition(((self._nodes).daily).anchor_x, ((self._nodes).daily).anchor_y)
        ;
        (v.panel):SetActive(true)
        ;
        (v.tips):SetText((TextManager.GetText)(diffcultyRecord.bosspagetxt))
        ;
        (v.difficultyTxt):SetText(((NekoData.BehaviorManager).BM_Game):GetBossRushDifficultyColorStr((v.data).bossLevel, "Anniversary"))
        ;
        (v.goBtn_txt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2031))
        for i,value in ipairs((v.data).firstItems) do
          (table.insert)(v.rewardList, {tag = "First", data = value})
        end
      end
    end
    if not hideNormal then
      (v.rewardFrame):ReloadAllCell()
      local cellPanelWidth = v.rewardFrame_width / Num * #v.rewardList
      local cellPanelHeight = (v.rewardFrame):GetTotalLength()
      ;
      (v.rewardPanel):SetSize(0, cellPanelWidth, 0, cellPanelHeight)
      ;
      (v.rewardPanel):SetAnchoredPosition(v.rewardFrame_anchoredx, v.rewardFrame_anchoredy)
      ;
      (v.rewardFrame):ReloadAllCell()
      if not CImagePathTable:GetRecorder(diffcultyRecord.bosspage) then
        local image = DataCommon.DefaultImageAsset
      end
      ;
      (v.backImage):SetSprite(image.assetBundle, image.assetName)
      if v.handler ~= 0 then
        (v.model):ReleaseModel(v.handler)
        v.handler = 0
      end
      v.handler = (v.model):AddModelSync(npcShapeRecorder.assetBundleName, npcShapeRecorder.prefabNameUI)
    end
  end
  -- DECOMPILER ERROR: 14 unprocessed JMP targets
end

local GetNodes = function(self, frame)
  -- function num : 0_4 , upvalues : _ENV
  for k,v in pairs(self._nodes) do
    if v.rewardFrame == frame then
      return v
    end
  end
end

BossLevelDetailDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_5 , upvalues : GetNodes
  local nodes = GetNodes(self, frame)
  return #nodes.rewardList
end

BossLevelDetailDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "activity.anniversary.bossleveldetailrewardcell"
end

BossLevelDetailDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7 , upvalues : GetNodes
  local nodes = GetNodes(self, frame)
  return (nodes.rewardList)[index]
end

BossLevelDetailDialog.OnGoBtnClicked = function(self, type)
  -- function num : 0_8
  if ((self._nodes)[type]).data then
    (self._delegate):OnGoBtnClicked((((self._nodes)[type]).data).levelId)
  end
end

BossLevelDetailDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9
  (self._delegate):SelectLevelById(nil)
end

BossLevelDetailDialog.OnRootWindowClicked = function(self)
  -- function num : 0_10
end

return BossLevelDetailDialog

