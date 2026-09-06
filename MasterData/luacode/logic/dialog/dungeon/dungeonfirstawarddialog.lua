local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local DungeonFirstAwardDialog = class("DungeonFirstAwardDialog", Dialog)
DungeonFirstAwardDialog.AssetBundleName = "ui/layouts.dungeon"
DungeonFirstAwardDialog.AssetName = "DungeonFinish1"

function DungeonFirstAwardDialog:Ctor(...)
  DungeonFirstAwardDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._data = {}
end

function DungeonFirstAwardDialog:OnCreate()
  self._itemField = self:GetChild("Frame/CellPanel")
  self._nextBtn = self:GetChild("Frame/NextImage")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnNextClicked, self)
  self:SetData()
  LuaNotificationCenter.AddObserver(self, self.OnTipsDestroy, Common.n_DialogWillDestroy, nil)
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnStateExit, self)
end

function DungeonFirstAwardDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._itemFrame:Destroy()
  self._data = {}
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  DialogManager.DestroySingletonDialog("equip.equiptipsdialog")
  DialogManager.DestroySingletonDialog("equip.equiptipspreviewdialog")
end

function DungeonFirstAwardDialog:SetData()
  local bagList = NekoData.BehaviorManager.BM_Game:GetFirstAwardFromDungeon()
  self._data = {}
  for _, v in ipairs(bagList) do
    table.insert(self._data, {item = v})
  end
  if #self._data < 5 then
    local cell = DialogManager.CreateDialog("dungeon.dungeonfirstawardcell", self:GetRootWindow()._uiObject)
    cell:GetRootWindow():SetPosition(0, -10000, 0, 0)
    local width, height = cell:GetRootWindow():GetRectSize()
    cell:Destroy()
    cell:RootWindowDestroy()
    local cellPanelWidth = width * #self._data
    local cellPanelHeight = height
    self._itemField:SetWidth(0, cellPanelWidth)
    self._itemField:SetHeight(0, cellPanelHeight)
    local rootWindowAnchoredx, rootWindowAnchoredy = self:GetRootWindow():GetAnchoredPosition()
    self._itemField:SetAnchoredPosition(rootWindowAnchoredx, rootWindowAnchoredy)
    self._itemFrame = TableFrame.Create(self._itemField, self, false, false)
  else
    self._itemFrame = TableFrame.Create(self._itemField, self, false, true)
    self._itemFrame:SetMargin(20, 0)
  end
  self._itemFrame:ReloadAllCell()
end

function DungeonFirstAwardDialog:NumberOfCell(frame)
  if frame == self._itemFrame then
    return #self._data
  end
end

function DungeonFirstAwardDialog:CellAtIndex(frame, index)
  if frame == self._itemFrame then
    return "dungeon.dungeonfirstawardcell"
  end
end

function DungeonFirstAwardDialog:DataAtIndex(frame, index)
  if frame == self._itemFrame and #self._data ~= 0 then
    return self._data[index]
  end
end

function DungeonFirstAwardDialog:OnNextClicked()
  if self._canClose then
    self:Destroy()
  end
end

function DungeonFirstAwardDialog:OnTipsDestroy(notification)
  if not notification.userInfo._rootWindow:IsChildOf(self._rootWindow) and notification.userInfo._dialogName ~= "clickeffect.clickeffectcell" then
    self._itemFrame:FireEvent("SetItemSelectedState", nil)
  end
end

function DungeonFirstAwardDialog:OnStateExit(handler, stateName, normalizedTime)
  if stateName == "DungeonFinishGetItem" then
    self._canClose = true
  end
end

return DungeonFirstAwardDialog
