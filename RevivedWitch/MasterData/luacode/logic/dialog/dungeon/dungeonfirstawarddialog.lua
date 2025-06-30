-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/dungeonfirstawarddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local DungeonFirstAwardDialog = class("DungeonFirstAwardDialog", Dialog)
DungeonFirstAwardDialog.AssetBundleName = "ui/layouts.dungeon"
DungeonFirstAwardDialog.AssetName = "DungeonFinish1"
DungeonFirstAwardDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonFirstAwardDialog
  ((DungeonFirstAwardDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._data = {}
end

DungeonFirstAwardDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._itemField = self:GetChild("Frame/CellPanel")
  self._nextBtn = self:GetChild("Frame/NextImage")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnNextClicked, self)
  self:SetData()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnTipsDestroy, Common.n_DialogWillDestroy, nil)
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnStateExit, self)
end

DungeonFirstAwardDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._itemFrame):Destroy()
  self._data = {}
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
  ;
  (DialogManager.DestroySingletonDialog)("equip.equiptipsdialog")
  ;
  (DialogManager.DestroySingletonDialog)("equip.equiptipspreviewdialog")
end

DungeonFirstAwardDialog.SetData = function(self)
  -- function num : 0_3 , upvalues : _ENV, TableFrame
  local bagList = ((NekoData.BehaviorManager).BM_Game):GetFirstAwardFromDungeon()
  self._data = {}
  for _,v in ipairs(bagList) do
    (table.insert)(self._data, {item = v})
  end
  if #self._data < 5 then
    local cell = (DialogManager.CreateDialog)("dungeon.dungeonfirstawardcell", (self:GetRootWindow())._uiObject)
    ;
    (cell:GetRootWindow()):SetPosition(0, -10000, 0, 0)
    local width, height = (cell:GetRootWindow()):GetRectSize()
    cell:Destroy()
    cell:RootWindowDestroy()
    local cellPanelWidth = width * #self._data
    local cellPanelHeight = height
    ;
    (self._itemField):SetWidth(0, cellPanelWidth)
    ;
    (self._itemField):SetHeight(0, cellPanelHeight)
    local rootWindowAnchoredx, rootWindowAnchoredy = (self:GetRootWindow()):GetAnchoredPosition()
    ;
    (self._itemField):SetAnchoredPosition(rootWindowAnchoredx, rootWindowAnchoredy)
    self._itemFrame = (TableFrame.Create)(self._itemField, self, false, false)
  else
    do
      self._itemFrame = (TableFrame.Create)(self._itemField, self, false, true)
      ;
      (self._itemFrame):SetMargin(20, 0)
      ;
      (self._itemFrame):ReloadAllCell()
    end
  end
end

DungeonFirstAwardDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  if frame == self._itemFrame then
    return #self._data
  end
end

DungeonFirstAwardDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  if frame == self._itemFrame then
    return "dungeon.dungeonfirstawardcell"
  end
end

DungeonFirstAwardDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._itemFrame and #self._data ~= 0 then
    return (self._data)[index]
  end
end

DungeonFirstAwardDialog.OnNextClicked = function(self)
  -- function num : 0_7
  if self._canClose then
    self:Destroy()
  end
end

DungeonFirstAwardDialog.OnTipsDestroy = function(self, notification)
  -- function num : 0_8
  if not ((notification.userInfo)._rootWindow):IsChildOf(self._rootWindow) and (notification.userInfo)._dialogName ~= "clickeffect.clickeffectcell" then
    (self._itemFrame):FireEvent("SetItemSelectedState", nil)
  end
end

DungeonFirstAwardDialog.OnStateExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_9
  if stateName == "DungeonFinishGetItem" then
    self._canClose = true
  end
end

return DungeonFirstAwardDialog

