local TabFrame = require("framework.ui.frame.tab.tabframe")
local CharacterSkillCell = class("CharacterSkillCell", Dialog)
CharacterSkillCell.AssetBundleName = "ui/layouts.basecharacterinfo"
CharacterSkillCell.AssetName = "BaseCharacterInfoSkillNew"

function CharacterSkillCell:Ctor(...)
  CharacterSkillCell.super.Ctor(self, ...)
  self._buttonList = {}
  self._selectList = {}
  self._textList = {}
  self._text2List = {}
end

function CharacterSkillCell:OnCreate()
  self._page1 = self:GetChild("Page1")
  self._page2 = self:GetChild("Page2")
  self._select1 = self:GetChild("Page1/Select")
  self._select2 = self:GetChild("Page2/Select")
  self._text1 = self:GetChild("Page1/Text")
  self._text21 = self:GetChild("Page1/Text2")
  self._text2 = self:GetChild("Page2/Text")
  self._text22 = self:GetChild("Page2/Text2")
  self._cellFrame = self:GetChild("Back/SkillFrame")
  self._page1:Subscribe_PointerClickEvent(self.OnPage1Click, self)
  self._page2:Subscribe_PointerClickEvent(self.OnPage2Click, self)
  self._frame = TabFrame.Create(self._cellFrame, self)
  table.insert(self._buttonList, self._page1)
  table.insert(self._buttonList, self._page2)
  table.insert(self._selectList, self._select1)
  table.insert(self._selectList, self._select2)
  table.insert(self._textList, self._text1)
  table.insert(self._textList, self._text2)
  table.insert(self._text2List, self._text21)
  table.insert(self._text2List, self._text22)
end

function CharacterSkillCell:OnDestroy()
  self._frame:Destroy()
end

function CharacterSkillCell:RefreshCell(data, tag)
  self._roleData = data
  if self._panel and tag then
    local cell = self._frame:GetCellAtIndex(self._panel)
    cell:RefreshCell(self._roleData)
    self._initCell1 = self._panel == "Page1"
    self._initCell2 = self._panel == "Page2"
  else
    self._panel = "Page1"
    self._frame:ToPage(self._panel)
    if not self._initCell1 then
      local cell = self._frame:GetCellAtIndex(self._panel)
      cell:RefreshCell(self._roleData)
      self._initCell1 = true
    end
  end
end

function CharacterSkillCell:OnInfoChange(userInfo)
  self._frame:GetCellAtIndex("Page1"):OnSkillInfoChange(userInfo)
end

function CharacterSkillCell:DidToPage(window, orderIndex)
  if orderIndex == "Page1" then
    for i, v in ipairs(self._buttonList) do
      if v ~= self._page1 then
        v:SetSelected(false)
      else
        v:SetSelected(true)
      end
    end
    for _, v in pairs(self._selectList) do
      if v ~= self._select1 then
        v:SetActive(false)
      else
        v:SetActive(true)
      end
    end
    for _, v in pairs(self._textList) do
      if v ~= self._text1 then
        v:SetActive(false)
      else
        v:SetActive(true)
      end
    end
    for _, v in pairs(self._text2List) do
      if v ~= self._text21 then
        v:SetActive(true)
      else
        v:SetActive(false)
      end
    end
  elseif orderIndex == "Page2" then
    for i, v in ipairs(self._buttonList) do
      if v ~= self._page2 then
        v:SetSelected(false)
      else
        v:SetSelected(true)
      end
    end
    for _, v in pairs(self._selectList) do
      if v ~= self._select2 then
        v:SetActive(false)
      else
        v:SetActive(true)
      end
    end
    for _, v in pairs(self._textList) do
      if v ~= self._text2 then
        v:SetActive(false)
      else
        v:SetActive(true)
      end
    end
    for _, v in pairs(self._text2List) do
      if v ~= self._text22 then
        v:SetActive(true)
      else
        v:SetActive(false)
      end
    end
  end
end

function CharacterSkillCell:OnPage1Click()
  if self._panel ~= "Page1" then
    self._panel = "Page1"
    self._frame:ToPage(self._panel)
    if not self._initCell1 then
      local cell = self._frame:GetCellAtIndex(self._panel)
      cell:RefreshCell(self._roleData)
      self._initCell1 = true
    end
  end
end

function CharacterSkillCell:OnPage2Click()
  if self._panel ~= "Page2" then
    self._panel = "Page2"
    self._frame:ToPage(self._panel)
    if not self._initCell2 then
      local cell = self._frame:GetCellAtIndex(self._panel)
      cell:RefreshCell(self._roleData)
      self._initCell2 = true
    end
  end
end

function CharacterSkillCell:CellAtIndex(frame, index)
  if index == "Page1" then
    return "character.fightskillcell"
  elseif index == "Page2" then
    return "character.passiveskillcell"
  end
end

return CharacterSkillCell
