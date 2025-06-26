-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/alchemy/alchemystagedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CAlchemyStageCfg = (BeanManager.GetTableByName)("courtyard.calchemystage")
local BottomToTop = 2
local AlchemyStageDialog = class("AlchemyStageDialog", Dialog)
AlchemyStageDialog.AssetBundleName = "ui/layouts.yard"
AlchemyStageDialog.AssetName = "AlchemyStage"
AlchemyStageDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AlchemyStageDialog
  ((AlchemyStageDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

AlchemyStageDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, TableFrame, _ENV
  self._title = self:GetChild("Panel/Title")
  self._closeBtn = self:GetChild("Panel/CloseBtn")
  self._scrollBar = self:GetChild("Panel/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._panel = self:GetChild("Panel/Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  self._width = (self._panel):GetRectSize()
  ;
  (self._title):SetText((TextManager.GetText)(800111))
  self:Init()
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

AlchemyStageDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

AlchemyStageDialog.Init = function(self)
  -- function num : 0_3 , upvalues : CAlchemyStageCfg, _ENV
  self._data = {}
  local allIds = CAlchemyStageCfg:GetAllIds()
  for i = 1, #allIds do
    local recorder = CAlchemyStageCfg:GetRecorder(allIds[i])
    ;
    (table.insert)(self._data, recorder)
  end
  ;
  (table.remove)(self._data, 1)
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

AlchemyStageDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_4
  local total = (self._frame):GetTotalLength()
  if self._height < total then
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollSize(self._height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetActive(false)
  end
end

AlchemyStageDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._data
end

AlchemyStageDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "alchemy.alchemystagecell"
end

AlchemyStageDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._data)[index]
end

AlchemyStageDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

return AlchemyStageDialog

