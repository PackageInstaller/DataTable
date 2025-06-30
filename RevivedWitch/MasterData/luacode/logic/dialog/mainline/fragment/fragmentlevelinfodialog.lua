-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/fragment/fragmentlevelinfodialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CMonsterBookCfg = (BeanManager.GetTableByName)("handbook.cmonster_handbook")
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local CHandBookPropertyImage = (BeanManager.GetTableByName)("handbook.chankbookpropertyimage")
local FragmentLevelInfoDialog = class("FragmentLevelInfoDialog", Dialog)
FragmentLevelInfoDialog.AssetBundleName = "ui/layouts.fragment"
FragmentLevelInfoDialog.AssetName = "fragmentlevelinfo"
FragmentLevelInfoDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FragmentLevelInfoDialog
  ((FragmentLevelInfoDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._mosterInfoRecord = nil
  self._currentIndex = -1
  self._propList = {}
  self._tagList = {}
  self._skillList = {}
end

FragmentLevelInfoDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._icon = self:GetChild("Model/Model")
  self._name = self:GetChild("Back/Frame/Name")
  self._detailText = self:GetChild("Back/Frame/DetailTxt")
  self._propFrameUI = self:GetChild("Back/Frame/PropFrame")
  self._propFrame = (TableFrame.Create)(self._propFrameUI, self, true)
  self._keyFrameUI = self:GetChild("Back/Frame/KeyFrame")
  self._keyFrame = (TableFrame.Create)(self._keyFrameUI, self, true)
  self._skillPanel = self:GetChild("Back/Frame/SkillFrame")
  self._skillFrame = (TableFrame.Create)(self._skillPanel, self, true, true, true)
  ;
  (self._skillFrame):SetMargin(15, 0)
  self._level = self:GetChild("Back/Frame/Lv")
  self._leftArrow = self:GetChild("LeftArrow")
  self._rightArrow = self:GetChild("RightArrow")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  ;
  (self._leftArrow):Subscribe_PointerClickEvent(self.OnLeftBtnPointerClick, self)
  ;
  (self._rightArrow):Subscribe_PointerClickEvent(self.OnRightBtnPointerClick, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

FragmentLevelInfoDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._propFrame):Destroy()
  ;
  (self._keyFrame):Destroy()
  ;
  (self._skillFrame):Destroy()
end

FragmentLevelInfoDialog.SetData = function(self, mosters, lv)
  -- function num : 0_3 , upvalues : CMonsterBookCfg
  self._mosters = mosters
  self._currentIndex = 1
  local firstId = (self._mosters)[self._currentIndex]
  self._mosterInfoRecord = CMonsterBookCfg:GetRecorder(firstId)
  ;
  (self._leftArrow):SetActive(false)
  ;
  (self._level):SetText(lv)
  if #mosters == 1 then
    (self._rightArrow):SetActive(false)
  end
  self:RefrashInfo()
end

local properList = {"hpScore", "adScore", "apScore", "mixScore", "pdScore", "mdScore"}
FragmentLevelInfoDialog.RefrashInfo = function(self)
  -- function num : 0_4 , upvalues : _ENV, CNPCShape, CHandBookPropertyImage, properList
  (self._detailText):SetText((TextManager.GetText)((self._mosterInfoRecord).descriptionTextID))
  ;
  (self._name):SetText((TextManager.GetText)((self._mosterInfoRecord).nameTextID))
  local npcShapeRecorder = CNPCShape:GetRecorder((self._mosterInfoRecord).shapeID)
  if self._handler ~= nil then
    (self._icon):ReleaseModel(self._handler)
    self._handler = nil
  end
  self._handler = (self._icon):AddModelSync(npcShapeRecorder.assetBundleName, npcShapeRecorder.prefabNameUI)
  local list = (string.split)(npcShapeRecorder.position, ",")
  local position = {x = tonumber(list[1]), y = tonumber(list[2])}
  local scale = tonumber(npcShapeRecorder.live2DScale)
  ;
  (self._icon):SetAnchoredPosition(position.x, position.y)
  ;
  (self._icon):SetLocalScale(scale, scale, scale)
  local imgRec = CHandBookPropertyImage:GetRecorder(1)
  local book = self._mosterInfoRecord
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
end

FragmentLevelInfoDialog.OnLeftBtnPointerClick = function(self)
  -- function num : 0_5 , upvalues : CMonsterBookCfg
  if self._currentIndex > 1 then
    self._currentIndex = self._currentIndex - 1
    local id = (self._mosters)[self._currentIndex]
    self._mosterInfoRecord = CMonsterBookCfg:GetRecorder(id)
    self:RefrashInfo()
  end
  do
    if self._currentIndex == 1 then
      (self._leftArrow):SetActive(false)
    else
      if self._currentIndex == #self._mosters - 1 then
        (self._rightArrow):SetActive(true)
      end
    end
  end
end

FragmentLevelInfoDialog.OnRightBtnPointerClick = function(self)
  -- function num : 0_6 , upvalues : CMonsterBookCfg
  if self._currentIndex < #self._mosters then
    self._currentIndex = self._currentIndex + 1
    local id = (self._mosters)[self._currentIndex]
    self._mosterInfoRecord = CMonsterBookCfg:GetRecorder(id)
    self:RefrashInfo()
  end
  do
    if self._currentIndex == 2 then
      (self._leftArrow):SetActive(true)
    else
      if self._currentIndex == #self._mosters then
        (self._rightArrow):SetActive(false)
      end
    end
  end
end

FragmentLevelInfoDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

FragmentLevelInfoDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_8
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

FragmentLevelInfoDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_9
  if frame == self._keyFrame then
    return "mainline.fragment.monstertagcell"
  else
    if frame == self._propFrame then
      return "mainline.fragment.monsterpropcell"
    else
      if frame == self._skillFrame then
        return "mainline.fragment.monsterskillcell"
      end
    end
  end
end

FragmentLevelInfoDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_10
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

FragmentLevelInfoDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_11
  if frame == self._skillFrame then
    local _, height = (self._skillPanel):GetRectSize()
    local total = (self._skillFrame):GetTotalLength()
    frame:SetSlide(height < total)
  elseif frame == self._keyFrame then
    local _, height = (self._keyFrameUI):GetRectSize()
    local total = (self._keyFrame):GetTotalLength()
    frame:SetSlide(height < total)
  elseif frame == self._propFrame then
    local _, height = (self._propFrameUI):GetRectSize()
    local total = (self._propFrame):GetTotalLength()
    frame:SetSlide(height < total)
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

FragmentLevelInfoDialog.ShouldLengthChange = function(self)
  -- function num : 0_12
  return true
end

return FragmentLevelInfoDialog

