-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/memorybookdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local TabFrame = require("framework.ui.frame.tab.tabframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CalbumConfig = (BeanManager.GetTableByName)("handbook.calbumconfig")
local HandBookTypeEnum = (LuaNetManager.GetBeanDef)("protocol.user.handbooktype")
local MemoryBookDialog = class("MemoryBookDialog", Dialog)
MemoryBookDialog.AssetBundleName = "ui/layouts.tujianpuzzle"
MemoryBookDialog.AssetName = "TuJianPuzzleMain"
MemoryBookDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MemoryBookDialog
  ((MemoryBookDialog.super).Ctor)(self, ...)
  self._pageindex = 1
end

MemoryBookDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, _ENV
  self._title = self:GetChild("Back/TitleBack/Title")
  self._panel = self:GetChild("Back/Frame")
  self._leftArrowBtn = self:GetChild("Back/LeftArrow")
  self._rightArrowBtn = self:GetChild("Back/RightArrow")
  self._pageTxt = self:GetChild("Back/Page")
  self._frame = (GridFrame.Create)(self._panel, self, true, 2, false)
  ;
  (self._leftArrowBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self
    self:ToPage(self._pageindex - 1)
  end
)
  ;
  (self._rightArrowBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_1 , upvalues : self
    self:ToPage(self._pageindex + 1)
  end
)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshState, Common.n_RefreshAcitivityHandBook, nil)
end

MemoryBookDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._frame then
    (self._frame):Destroy()
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

MemoryBookDialog.Refresh = function(self)
  -- function num : 0_3 , upvalues : _ENV, CalbumConfig
  self._data = {}
  for _,v in ipairs(CalbumConfig:GetAllIds()) do
    local record = CalbumConfig:GetRecorder(v)
    if record then
      (table.insert)(self._data, record)
    end
  end
  self._pageindex = 1
  self:ToPage(1)
end

MemoryBookDialog.ToPage = function(self, index)
  -- function num : 0_4 , upvalues : _ENV
  if index < 1 then
    index = 1
  end
  if (math.ceil)(#self._data / 4) < index then
    index = (math.ceil)(#self._data / 4)
  end
  local start = (index - 1) * 4
  self._shwoData = {}
  for i = 1, 4 do
    if (self._data)[start + i] then
      (table.insert)(self._shwoData, (self._data)[start + i])
    end
  end
  self._pageindex = index
  ;
  (self._pageTxt):SetText(index)
  ;
  (self._frame):ReloadAllCell()
end

MemoryBookDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._shwoData
end

MemoryBookDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "handbook.memorybookcell"
end

MemoryBookDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._shwoData)[index]
end

MemoryBookDialog.RefreshState = function(self)
  -- function num : 0_8
  (self._frame):FireEvent("Refresh", nil)
end

return MemoryBookDialog

