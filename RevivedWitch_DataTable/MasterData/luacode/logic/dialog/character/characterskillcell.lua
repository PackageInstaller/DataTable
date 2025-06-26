-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/characterskillcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TabFrame = require("framework.ui.frame.tab.tabframe")
local CharacterSkillCell = class("CharacterSkillCell", Dialog)
CharacterSkillCell.AssetBundleName = "ui/layouts.basecharacterinfo"
CharacterSkillCell.AssetName = "BaseCharacterInfoSkillNew"
CharacterSkillCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CharacterSkillCell
  ((CharacterSkillCell.super).Ctor)(self, ...)
  self._buttonList = {}
  self._selectList = {}
  self._textList = {}
  self._text2List = {}
end

CharacterSkillCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TabFrame, _ENV
  self._page1 = self:GetChild("Page1")
  self._page2 = self:GetChild("Page2")
  self._select1 = self:GetChild("Page1/Select")
  self._select2 = self:GetChild("Page2/Select")
  self._text1 = self:GetChild("Page1/Text")
  self._text21 = self:GetChild("Page1/Text2")
  self._text2 = self:GetChild("Page2/Text")
  self._text22 = self:GetChild("Page2/Text2")
  self._cellFrame = self:GetChild("Back/SkillFrame")
  ;
  (self._page1):Subscribe_PointerClickEvent(self.OnPage1Click, self)
  ;
  (self._page2):Subscribe_PointerClickEvent(self.OnPage2Click, self)
  self._frame = (TabFrame.Create)(self._cellFrame, self)
  ;
  (table.insert)(self._buttonList, self._page1)
  ;
  (table.insert)(self._buttonList, self._page2)
  ;
  (table.insert)(self._selectList, self._select1)
  ;
  (table.insert)(self._selectList, self._select2)
  ;
  (table.insert)(self._textList, self._text1)
  ;
  (table.insert)(self._textList, self._text2)
  ;
  (table.insert)(self._text2List, self._text21)
  ;
  (table.insert)(self._text2List, self._text22)
end

CharacterSkillCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

CharacterSkillCell.RefreshCell = function(self, data, tag)
  -- function num : 0_3
  self._roleData = data
  if self._panel and tag then
    local cell = (self._frame):GetCellAtIndex(self._panel)
    cell:RefreshCell(self._roleData)
    self._initCell1 = self._panel == "Page1"
    self._initCell2 = self._panel == "Page2"
  else
    self._panel = "Page1"
    ;
    (self._frame):ToPage(self._panel)
    if not self._initCell1 then
      local cell = (self._frame):GetCellAtIndex(self._panel)
      cell:RefreshCell(self._roleData)
      self._initCell1 = true
    end
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

CharacterSkillCell.OnInfoChange = function(self, userInfo)
  -- function num : 0_4
  ((self._frame):GetCellAtIndex("Page1")):OnSkillInfoChange(userInfo)
end

CharacterSkillCell.DidToPage = function(self, window, orderIndex)
  -- function num : 0_5 , upvalues : _ENV
  if orderIndex == "Page1" then
    for i,v in ipairs(self._buttonList) do
      if v ~= self._page1 then
        v:SetSelected(false)
      else
        v:SetSelected(true)
      end
    end
    for _,v in pairs(self._selectList) do
      if v ~= self._select1 then
        v:SetActive(false)
      else
        v:SetActive(true)
      end
    end
    for _,v in pairs(self._textList) do
      if v ~= self._text1 then
        v:SetActive(false)
      else
        v:SetActive(true)
      end
    end
    for _,v in pairs(self._text2List) do
      if v ~= self._text21 then
        v:SetActive(true)
      else
        v:SetActive(false)
      end
    end
  else
    do
      if orderIndex == "Page2" then
        for i,v in ipairs(self._buttonList) do
          if v ~= self._page2 then
            v:SetSelected(false)
          else
            v:SetSelected(true)
          end
        end
        for _,v in pairs(self._selectList) do
          if v ~= self._select2 then
            v:SetActive(false)
          else
            v:SetActive(true)
          end
        end
        for _,v in pairs(self._textList) do
          if v ~= self._text2 then
            v:SetActive(false)
          else
            v:SetActive(true)
          end
        end
        for _,v in pairs(self._text2List) do
          if v ~= self._text22 then
            v:SetActive(true)
          else
            v:SetActive(false)
          end
        end
      end
    end
  end
end

CharacterSkillCell.OnPage1Click = function(self)
  -- function num : 0_6
  if self._panel ~= "Page1" then
    self._panel = "Page1"
    ;
    (self._frame):ToPage(self._panel)
    if not self._initCell1 then
      local cell = (self._frame):GetCellAtIndex(self._panel)
      cell:RefreshCell(self._roleData)
      self._initCell1 = true
    end
  end
end

CharacterSkillCell.OnPage2Click = function(self)
  -- function num : 0_7
  if self._panel ~= "Page2" then
    self._panel = "Page2"
    ;
    (self._frame):ToPage(self._panel)
    if not self._initCell2 then
      local cell = (self._frame):GetCellAtIndex(self._panel)
      cell:RefreshCell(self._roleData)
      self._initCell2 = true
    end
  end
end

CharacterSkillCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  if index == "Page1" then
    return "character.fightskillcell"
  else
    if index == "Page2" then
      return "character.passiveskillcell"
    end
  end
end

return CharacterSkillCell

