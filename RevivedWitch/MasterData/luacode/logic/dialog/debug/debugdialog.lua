-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/debug/debugdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local ResourceLoader = ((CS.PixelNeko).Assets).ResourceLoader
local DebugDialog = class("DebugDialog", Dialog)
DebugDialog.AssetBundleName = "ui/layouts"
DebugDialog.AssetName = "Debug"
DebugDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DebugDialog
  ((DebugDialog.super).Ctor)(self, ...)
  self._groupName = "ClickEffect"
  self._info = nil
  self._task = true
end

DebugDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._btn2 = self:GetChild("Btn2")
  self._btn2Text = self:GetChild("Btn2/_Text")
  self._btn3 = self:GetChild("Btn3")
  self._text = self:GetChild("Text")
  self._text2 = self:GetChild("Text2")
  self._cellFrame = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._cellFrame, self, true, true)
  ;
  (self._btn2Text):SetText("暂停")
  ;
  (self._btn2):Subscribe_PointerClickEvent(self.OnBtn2Click, self)
  ;
  (self._btn3):Subscribe_PointerClickEvent(self.OnBtn3Click, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
  self:Refresh()
end

DebugDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

DebugDialog.LoadLocalData = function(self)
  -- function num : 0_3 , upvalues : ResourceLoader, _ENV
  self._info = {}
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._info).QueueLength = ((ResourceLoader.GetDebugInfo)()).QueueLength
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._info).AssetBundleInfo = {}
  for _,v in pairs(((ResourceLoader.GetDebugInfo)()).AssetBundleInfo) do
    (table.insert)((self._info).AssetBundleInfo, v)
  end
end

DebugDialog.Refresh = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self:LoadLocalData()
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._text2):SetText(tostring("QueueLength: " .. (self._info).QueueLength))
end

DebugDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #(self._info).AssetBundleInfo
end

DebugDialog.CellAtIndex = function(self, frame)
  -- function num : 0_6
  return "debug.debugcell"
end

DebugDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return ((self._info).AssetBundleInfo)[index]
end

DebugDialog.OnBtn2Click = function(self)
  -- function num : 0_8
  if self._task then
    (self._btn2Text):SetText("逐帧刷新")
  else
    ;
    (self._btn2Text):SetText("暂停")
  end
  self._task = not self._task
end

DebugDialog.OnBtn3Click = function(self)
  -- function num : 0_9
  self:Destroy()
end

DebugDialog.OnUpdate = function(self)
  -- function num : 0_10
  if self._task then
    self:Refresh()
  end
end

DebugDialog.OnBackBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  return DataCommon.BackPressed_SkipResponse
end

return DebugDialog

