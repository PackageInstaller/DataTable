local TabFrame = require("framework.ui.frame.tab.tabframe")
local TuJianCharacterInfoPageCell = class("TuJianCharacterInfoPageCell", Dialog)
TuJianCharacterInfoPageCell.AssetBundleName = "ui/layouts.tujian"
TuJianCharacterInfoPageCell.AssetName = "TuJianCharInfoPage"

function TuJianCharacterInfoPageCell:Ctor(...)
  TuJianCharacterInfoPageCell.super.Ctor(self, ...)
  self._data = nil
  self._buttonList = {}
  self._selectList = {}
  self._noSelectList = {}
end

function TuJianCharacterInfoPageCell:OnCreate()
  self._page1 = self:GetChild("Page1")
  self._page2 = self:GetChild("Page2")
  self._tabFrame = self:GetChild("Frame")
  self._text11 = self:GetChild("Page1/Text")
  self._text12 = self:GetChild("Page1/Text2")
  self._text21 = self:GetChild("Page2/Text")
  self._text22 = self:GetChild("Page2/Text2")
  table.insert(self._buttonList, self._page1)
  table.insert(self._buttonList, self._page2)
  table.insert(self._selectList, self._text11)
  table.insert(self._selectList, self._text21)
  table.insert(self._noSelectList, self._text12)
  table.insert(self._noSelectList, self._text22)
  self._frame = TabFrame.Create(self._tabFrame, self)
  self._page1:Subscribe_PointerClickEvent(self.OnPage1PointerClick, self)
  self._page2:Subscribe_PointerClickEvent(self.OnPage2PointerClick, self)
  UIBackManager.SwitchToNext()
end

function TuJianCharacterInfoPageCell:OnDestroy()
  self._frame:Destroy()
end

function TuJianCharacterInfoPageCell:RefreshCell(data)
  self._data = data
  self._panel = "Page1"
  self._frame:ToPage(self._panel)
  if not self._initCell1 then
    local cell = self._frame:GetCellAtIndex(self._panel)
    cell:RefreshCell(self._data)
    self._initCell1 = true
  end
end

function TuJianCharacterInfoPageCell:DidToPage(window, orderIndex)
  if orderIndex == "Page1" then
    for i, v in ipairs(self._buttonList) do
      if v ~= self._page1 then
        v:SetSelected(false)
      else
        v:SetSelected(true)
      end
    end
    for _, v in pairs(self._selectList) do
      if v ~= self._text11 then
        v:SetActive(false)
      else
        v:SetActive(true)
      end
    end
    for _, v in pairs(self._noSelectList) do
      if v ~= self._text12 then
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
      if v ~= self._text21 then
        v:SetActive(false)
      else
        v:SetActive(true)
      end
    end
    for _, v in pairs(self._noSelectList) do
      if v ~= self._text22 then
        v:SetActive(true)
      else
        v:SetActive(false)
      end
    end
  end
end

function TuJianCharacterInfoPageCell:OnPage1PointerClick()
  if self._panel ~= "Page1" then
    self._panel = "Page1"
    UIBackManager.SwitchToNext()
    self._frame:ToPage(self._panel)
    if not self._initCell0 then
      local cell = self._frame:GetCellAtIndex(self._panel)
      cell:RefreshCell(self._data)
      self._initCell0 = true
    end
  end
end

function TuJianCharacterInfoPageCell:OnPage2PointerClick()
  if self._panel ~= "Page2" then
    self._panel = "Page2"
    UIBackManager.SwitchToNext()
    self._frame:ToPage(self._panel)
    if not self._initCell0 then
      local cell = self._frame:GetCellAtIndex(self._panel)
      cell:RefreshCell(self._data)
      self._initCell0 = true
    end
  end
end

function TuJianCharacterInfoPageCell:CellAtIndex(frame, index)
  if index == "Page1" then
    return "tujian.tujiancharacterinfoprofilecell"
  elseif index == "Page2" then
    return "tujian.tujiancharacterinfostorycell"
  end
end

function TuJianCharacterInfoPageCell:DataAtIndex(frame, index)
  return self._data
end

return TuJianCharacterInfoPageCell
