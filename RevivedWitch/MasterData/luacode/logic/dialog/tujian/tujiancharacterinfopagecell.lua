-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tujian/tujiancharacterinfopagecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TabFrame = require("framework.ui.frame.tab.tabframe")
local TuJianCharacterInfoPageCell = class("TuJianCharacterInfoPageCell", Dialog)
TuJianCharacterInfoPageCell.AssetBundleName = "ui/layouts.tujian"
TuJianCharacterInfoPageCell.AssetName = "TuJianCharInfoPage"
TuJianCharacterInfoPageCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TuJianCharacterInfoPageCell
  ((TuJianCharacterInfoPageCell.super).Ctor)(self, ...)
  self._data = nil
  self._buttonList = {}
  self._selectList = {}
  self._noSelectList = {}
end

TuJianCharacterInfoPageCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TabFrame
  self._page1 = self:GetChild("Page1")
  self._page2 = self:GetChild("Page2")
  self._tabFrame = self:GetChild("Frame")
  self._text11 = self:GetChild("Page1/Text")
  self._text12 = self:GetChild("Page1/Text2")
  self._text21 = self:GetChild("Page2/Text")
  self._text22 = self:GetChild("Page2/Text2")
  ;
  (table.insert)(self._buttonList, self._page1)
  ;
  (table.insert)(self._buttonList, self._page2)
  ;
  (table.insert)(self._selectList, self._text11)
  ;
  (table.insert)(self._selectList, self._text21)
  ;
  (table.insert)(self._noSelectList, self._text12)
  ;
  (table.insert)(self._noSelectList, self._text22)
  self._frame = (TabFrame.Create)(self._tabFrame, self)
  ;
  (self._page1):Subscribe_PointerClickEvent(self.OnPage1PointerClick, self)
  ;
  (self._page2):Subscribe_PointerClickEvent(self.OnPage2PointerClick, self)
  ;
  (UIBackManager.SwitchToNext)()
end

TuJianCharacterInfoPageCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

TuJianCharacterInfoPageCell.RefreshCell = function(self, data)
  -- function num : 0_3
  self._data = data
  self._panel = "Page1"
  ;
  (self._frame):ToPage(self._panel)
  if not self._initCell1 then
    local cell = (self._frame):GetCellAtIndex(self._panel)
    cell:RefreshCell(self._data)
    self._initCell1 = true
  end
end

TuJianCharacterInfoPageCell.DidToPage = function(self, window, orderIndex)
  -- function num : 0_4 , upvalues : _ENV
  if orderIndex == "Page1" then
    for i,v in ipairs(self._buttonList) do
      if v ~= self._page1 then
        v:SetSelected(false)
      else
        v:SetSelected(true)
      end
    end
    for _,v in pairs(self._selectList) do
      if v ~= self._text11 then
        v:SetActive(false)
      else
        v:SetActive(true)
      end
    end
    for _,v in pairs(self._noSelectList) do
      if v ~= self._text12 then
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
          if v ~= self._text21 then
            v:SetActive(false)
          else
            v:SetActive(true)
          end
        end
        for _,v in pairs(self._noSelectList) do
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

TuJianCharacterInfoPageCell.OnPage1PointerClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self._panel ~= "Page1" then
    self._panel = "Page1"
    ;
    (UIBackManager.SwitchToNext)()
    ;
    (self._frame):ToPage(self._panel)
    if not self._initCell0 then
      local cell = (self._frame):GetCellAtIndex(self._panel)
      cell:RefreshCell(self._data)
      self._initCell0 = true
    end
  end
end

TuJianCharacterInfoPageCell.OnPage2PointerClick = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self._panel ~= "Page2" then
    self._panel = "Page2"
    ;
    (UIBackManager.SwitchToNext)()
    ;
    (self._frame):ToPage(self._panel)
    if not self._initCell0 then
      local cell = (self._frame):GetCellAtIndex(self._panel)
      cell:RefreshCell(self._data)
      self._initCell0 = true
    end
  end
end

TuJianCharacterInfoPageCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  if index == "Page1" then
    return "tujian.tujiancharacterinfoprofilecell"
  else
    if index == "Page2" then
      return "tujian.tujiancharacterinfostorycell"
    end
  end
end

TuJianCharacterInfoPageCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  return self._data
end

return TuJianCharacterInfoPageCell

