-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/undecidedroad/undecidedroadchoosedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local UndecidedRoadChooseDialog = class("UndecidedRoadChooseDialog", Dialog)
UndecidedRoadChooseDialog.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadChooseDialog.AssetName = "ActivityRoadChoose"
UndecidedRoadChooseDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : UndecidedRoadChooseDialog
  ((UndecidedRoadChooseDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._data = {}
end

UndecidedRoadChooseDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._panel = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._panel, self, false, true, false)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.Refresh, Common.n_EnterMianCity, nil)
end

UndecidedRoadChooseDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("mainline.undecidedroad.undecidedroadbossrecorddialog")
  ;
  (DialogManager.DestroySingletonDialog)("mainline.undecidedroad.undecidedroadrecorddialog")
  ;
  (self._frame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

UndecidedRoadChooseDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  while #self._data > 0 do
    (table.remove)(self._data, #self._data)
  end
  local id = 1
  for _,v in pairs(data.trainsInfo) do
    local temp = {id = id, battleId = v.battleId, score = v.score}
    ;
    (table.insert)(self._data, temp)
    id = id + 1
  end
  local lastPos = (self._frame):GetCurrentPosition()
  ;
  (self._frame):ReloadAllCell()
  if lastPos then
    (self._frame):MoveToAssignedPos(lastPos)
  end
end

UndecidedRoadChooseDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._data
end

UndecidedRoadChooseDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "mainline.undecidedroad.undecidedroadchoosecell"
end

UndecidedRoadChooseDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._data)[index]
end

UndecidedRoadChooseDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

UndecidedRoadChooseDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

UndecidedRoadChooseDialog.Refresh = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.activity.copentrain")
  if csend then
    csend:Send()
  end
end

return UndecidedRoadChooseDialog

