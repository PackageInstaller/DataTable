-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/monsterbookdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CMonsterBookCfg = (BeanManager.GetTableByName)("handbook.cmonster_handbook")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local CForceHandBookCfg = (BeanManager.GetTableByName)("handbook.caffiliation_handbook")
local CHandBookPropertyImage = (BeanManager.GetTableByName)("handbook.chankbookpropertyimage")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CScreeningConditions = (BeanManager.GetTableByName)("handbook.cmonster_handbookscreeningconditions")
local HandBookTypeEnum = (LuaNetManager.GetBeanDef)("protocol.user.handbooktype")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local MonsterBookDialog = class("MonsterBookDialog", Dialog)
MonsterBookDialog.AssetBundleName = "ui/layouts.tujian"
MonsterBookDialog.AssetName = "MonsterBook"
MonsterBookDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MonsterBookDialog
  ((MonsterBookDialog.super).Ctor)(self, ...)
  self._selectId = 0
  self._monsterList = {}
  self._downDataList = {}
  self._screeningConditions = {}
  self._propList = {}
  self._tagList = {}
  self._skillList = {}
end

MonsterBookDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, TableFrame, _ENV
  self._detailBack = self:GetChild("Detail")
  self._icon = self:GetChild("Detail/MonsterImg")
  self._monsterBack = self:GetChild("Detail/MonsterBack")
  self._name = self:GetChild("Detail/Name")
  self._area = self:GetChild("Detail/Txt2")
  self._areaIcon = self:GetChild("Detail/Txt1")
  self._campIcon = self:GetChild("Detail/GroupImg")
  self._lockIcon = self:GetChild("Detail/Lock")
  self._lockText = self:GetChild("Detail/LockTxt")
  self._detailText = self:GetChild("Detail/DetailTxt")
  self._propText = self:GetChild("Detail/Txt3")
  self._propText_Tiele = self:GetChild("Detail/Txt4")
  self._propFrameUI = self:GetChild("Detail/PropFrame")
  self._propFrame = (GridFrame.Create)(self._propFrameUI, self, true, 1)
  self._keyFrameUI = self:GetChild("Detail/KeyFrame")
  self._keyFrame = (GridFrame.Create)(self._keyFrameUI, self, true, 1)
  self._monsterPanel = self:GetChild("Frame")
  self._monsterFrame = (GridFrame.Create)(self._monsterPanel, self, true, 4)
  ;
  (self._monsterFrame):SetMargin(15, 0)
  self._scrollBar = self:GetChild("Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(3)
  self._filterBtn = self:GetChild("FliterBtn")
  ;
  (self._filterBtn):Subscribe_PointerClickEvent(self.OnFilterBtnClick, self)
  self._skillBack = self:GetChild("Detail/SkillBack")
  self._skillPanel = self:GetChild("Detail/SkillFrame")
  self._skillFrame = (TableFrame.Create)(self._skillPanel, self, true, true, true)
  ;
  (self._skillFrame):SetMargin(15, 0)
  self._skillScrollBar = self:GetChild("Detail/SkillScrollbar")
  ;
  (self._skillScrollBar):SetScrollDirection(2)
  self._filterPanel = self:GetChild("BaseCharacterListFliterNew")
  self._filterDlg = ((require("logic.dialog.common.filterdialog")).Create)(self._filterPanel)
end

MonsterBookDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._monsterFrame):Destroy()
  ;
  (self._propFrame):Destroy()
  ;
  (self._keyFrame):Destroy()
  ;
  (self._skillFrame):Destroy()
  if self._filterDlg then
    (self._filterDlg):Destroy()
    self._filterDlg = nil
  end
end

MonsterBookDialog.Refresh = function(self)
  -- function num : 0_3 , upvalues : _ENV, CMonsterBookCfg, HandBookTypeEnum
  local typeList = {}
  local select = false
  for k,v in pairs(self._screeningConditions) do
    for index,value in ipairs(v) do
      if value.nameid == 1300012 then
        select = true
        typeList[0] = true
      end
      if value.nameid == 1300013 then
        select = true
        typeList[1] = true
      end
    end
  end
  self._monsterList = {}
  local firstUnlockRecord = nil
  local firstUnLockIndex = 0
  for _,v in ipairs(CMonsterBookCfg:GetAllIds()) do
    local record = CMonsterBookCfg:GetRecorder(R12_PC37)
    if (not select or typeList[record.monsterType]) and record.isShow == 1 then
      (table.insert)(R12_PC37, record)
      -- DECOMPILER ERROR at PC57: Overwrote pending register: R12 in 'AssignReg'

      if not firstUnlockRecord and ((NekoData.BehaviorManager).BM_HandBook):IsBookUnLock(R13_PC60, HandBookTypeEnum.MONSTER) then
        firstUnlockRecord = record
        firstUnLockIndex = #self._monsterList
      end
    end
  end
  ;
  (self._monsterFrame):ReloadAllCell()
  if not firstUnlockRecord then
    firstUnlockRecord = (self._monsterList)[1]
    firstUnLockIndex = 1
  end
  if firstUnlockRecord then
    (self._monsterFrame):FireEvent("ChooseMonster", firstUnlockRecord.id)
    self:OnSelectMonster(firstUnlockRecord)
    ;
    (self._monsterFrame):MoveDownToIndex(firstUnLockIndex, false)
  else
    ;
    (self._detailBack):SetActive(false)
  end
end

local properList = {"hpScore", "adScore", "apScore", "mixScore", "pdScore", "mdScore"}
MonsterBookDialog.OnSelectMonster = function(self, monsterBookInfo)
  -- function num : 0_4 , upvalues : _ENV, HandBookTypeEnum, CNPCShape, CForceHandBookCfg, CImagePathTable, CHandBookPropertyImage, properList
  self._selectId = monsterBookInfo.id
  ;
  (self._detailBack):SetActive(true)
  if not ((NekoData.BehaviorManager).BM_HandBook):IsBookUnLock(monsterBookInfo.id, HandBookTypeEnum.MONSTER) then
    (self._lockIcon):SetActive(true)
    ;
    (self._monsterBack):SetActive(false)
    ;
    (self._icon):SetActive(false)
    ;
    (self._campIcon):SetActive(false)
    ;
    (self._name):SetText("")
    ;
    (self._area):SetText("")
    ;
    (self._areaIcon):SetActive(false)
    ;
    (self._lockText):SetActive(true)
    ;
    (self._detailText):SetActive(false)
    ;
    (self._propText):SetActive(false)
    ;
    (self._propText_Tiele):SetActive(false)
    ;
    (self._keyFrameUI):SetActive(false)
    ;
    (self._propFrameUI):SetActive(false)
    ;
    (self._skillPanel):SetActive(false)
    ;
    (self._skillBack):SetActive(false)
    local str = (TextManager.GetText)(501674)
    ;
    (self._lockText):SetText(str)
    ;
    (self._monsterFrame):FireEvent("ChooseMonster", monsterBookInfo.id)
    return 
  end
  do
    ;
    (self._icon):SetActive(true)
    ;
    (self._campIcon):SetActive(true)
    ;
    (self._lockIcon):SetActive(false)
    ;
    (self._monsterBack):SetActive(true)
    ;
    (self._lockText):SetActive(false)
    ;
    (self._detailText):SetActive(true)
    ;
    (self._detailText):SetText((TextManager.GetText)(monsterBookInfo.descriptionTextID))
    ;
    (self._propText):SetActive(true)
    ;
    (self._areaIcon):SetActive(true)
    ;
    (self._area):SetText((TextManager.GetText)(monsterBookInfo.areaTextID))
    ;
    (self._name):SetText((TextManager.GetText)(monsterBookInfo.nameTextID))
    local npcShapeRecorder = CNPCShape:GetRecorder(monsterBookInfo.shapeID)
    if self._handler ~= 0 then
      (self._icon):ReleaseModel(self._handler)
      self._handler = 0
    end
    self._handler = (self._icon):AddModelSync(npcShapeRecorder.assetBundleName, npcShapeRecorder.prefabNameUI)
    local scale = tonumber(npcShapeRecorder.live2DScale)
    ;
    (self._icon):SetLocalScale(scale, scale, scale)
    ;
    (self._campIcon):SetActive(monsterBookInfo.affiliation > 0)
    if monsterBookInfo.affiliation > 0 then
      local worldPowerCfg = CForceHandBookCfg:GetRecorder(monsterBookInfo.affiliation)
      local imageRecord = CImagePathTable:GetRecorder(worldPowerCfg.icon)
      ;
      (self._campIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    end
    ;
    (self._keyFrameUI):SetActive(true)
    ;
    (self._propFrameUI):SetActive(true)
    ;
    (self._skillPanel):SetActive(true)
    local imgRec = CHandBookPropertyImage:GetRecorder(1)
    local book = monsterBookInfo
    self._propList = {}
    for _,v in ipairs(properList) do
      if book[v] > 0 then
        (table.insert)(self._propList, {num = book[v], icon = imgRec[v .. "Image"]})
      end
    end
    self._tagList = book.tag
    self._skillList = book.skillid
    ;
    (self._skillFrame):ReloadAllCell()
    ;
    (self._skillFrame):MoveToTop()
    ;
    (self._propFrame):ReloadAllCell()
    ;
    (self._keyFrame):ReloadAllCell()
    ;
    (self._monsterFrame):FireEvent("ChooseMonster", monsterBookInfo.id)
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

MonsterBookDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_5
  if frame == self._monsterFrame then
    return #self._monsterList
  else
    if frame == self._propFrame then
      return #self._propList
    else
      if frame == self._keyFrame then
        return #self._tagList
      else
        if frame == self._skillFrame then
          return #self._skillList
        end
      end
    end
  end
end

MonsterBookDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._monsterFrame then
    return "handbook.monsterbookcell"
  else
    if frame == self._keyFrame then
      return "handbook.monsterbooktagcell"
    else
      if frame == self._propFrame then
        return "handbook.monsterbookpropcell"
      else
        if frame == self._skillFrame then
          return "handbook.monsterskillcell"
        end
      end
    end
  end
end

MonsterBookDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  if frame == self._monsterFrame then
    return (self._monsterList)[index]
  else
    if frame == self._keyFrame then
      return (self._tagList)[index]
    else
      if frame == self._propFrame then
        return (self._propList)[index]
      else
        if frame == self._skillFrame then
          return (self._skillList)[index]
        end
      end
    end
  end
end

MonsterBookDialog.SetScreeningConditions = function(self, screeningConditions)
  -- function num : 0_8
  self._screeningConditions = screeningConditions
  self:Refresh()
end

MonsterBookDialog.OnFilterBtnClick = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return 
  end
  ;
  (self._filterDlg):SetData(self, 1, "Monster", self._screeningConditions)
end

MonsterBookDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_10
  if frame == self._monsterFrame then
    local _, height = (self._monsterPanel):GetRectSize()
    local total = (self._monsterFrame):GetTotalLength()
    frame:SetSlide(height < total)
    if height < total then
      (self._scrollBar):SetActive(true)
      ;
      (self._scrollBar):SetScrollSize(height / total)
      ;
      (self._scrollBar):SetScrollValue(proportion)
    else
      (self._scrollBar):SetActive(false)
    end
  elseif frame == self._skillFrame then
    local _, height = (self._skillPanel):GetRectSize()
    local total = (self._skillFrame):GetTotalLength()
    frame:SetSlide(height < total)
    if height < total then
      (self._skillScrollBar):SetActive(true)
      ;
      (self._skillScrollBar):SetScrollSize(height / total)
      ;
      (self._skillScrollBar):SetScrollValue(proportion)
    else
      (self._skillScrollBar):SetActive(false)
    end
  elseif frame == self._keyFrame then
    local _, height = (self._keyFrameUI):GetRectSize()
    local total = (self._keyFrame):GetTotalLength()
    frame:SetSlide(height < total)
  elseif frame == self._propFrame then
    local _, height = (self._propFrameUI):GetRectSize()
    local total = (self._propFrame):GetTotalLength()
    frame:SetSlide(height < total)
  end
  -- DECOMPILER ERROR: 10 unprocessed JMP targets
end

MonsterBookDialog.ShouldLengthChange = function(self)
  -- function num : 0_11
  return true
end

return MonsterBookDialog

