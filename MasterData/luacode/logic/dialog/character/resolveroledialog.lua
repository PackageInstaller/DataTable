local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local ResolveRoleDialog = class("ResolveRoleDialog", Dialog)
ResolveRoleDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
ResolveRoleDialog.AssetName = "BaseCharactorCellListResolve"

function ResolveRoleDialog:Ctor(...)
  ResolveRoleDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._resolveRoleList = {}
  self._itemList = {}
end

function ResolveRoleDialog:OnCreate()
  self._upPanel = self:GetChild("Back/Frame")
  self._downPanel = self:GetChild("Back/Frame2")
  self._cancelButton = self:GetChild("Back/CancelBtn")
  self._confirmButton = self:GetChild("Back/ConfirmBtn")
  self._upFrame = TableFrame.Create(self._upPanel, self, false, true)
  self._downFrame = TableFrame.Create(self._downPanel, self, false, true)
  self._upFrame:SetMargin(35, 35)
  self._downFrame:SetMargin(35, 35)
  self._cancelButton:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmButton:Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
end

function ResolveRoleDialog:OnDestroy()
  self._upFrame:Destroy()
  self._downFrame:Destroy()
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
end

function ResolveRoleDialog:SetData(roleList)
  local items = {}
  for i, v in ipairs(roleList) do
    table.insert(self._resolveRoleList, v)
    local roleItem = Item.Create(v:GetItemId())
    local id = roleItem:GetResolveItemId()
    local item = items[id]
    if item then
      item:SetCount(item:GetCount() + roleItem:GetResolveItemNum())
    else
      item = Item.Create(id)
      item:SetCount(roleItem:GetResolveItemNum())
      items[id] = item
    end
  end
  for k, v in pairs(items) do
    table.insert(self._itemList, v)
  end
  if #self._resolveRoleList > 6 then
    self._upFrame:SetSlide(true)
  else
    self._upFrame:SetSlide(false)
  end
  if #self._itemList > 6 then
    self._downFrame:SetSlide(true)
  else
    self._downFrame:SetSlide(false)
  end
  self._upFrame:ReloadAllCell()
  self._downFrame:ReloadAllCell()
end

function ResolveRoleDialog:OnBackBtnClicked()
  self:Destroy()
end

function ResolveRoleDialog:OnClickConfirmBtn()
  local list = {}
  for i, v in ipairs(self._resolveRoleList) do
    table.insert(list, v:GetRoleId())
  end
  self:Destroy()
end

function ResolveRoleDialog:NumberOfCell(frame)
  if frame == self._upFrame then
    return #self._resolveRoleList
  else
    return #self._itemList
  end
end

function ResolveRoleDialog:CellAtIndex(frame, index)
  if frame == self._upFrame then
    return "character.resolverolecell"
  else
    return "character.resolveitemcell"
  end
end

function ResolveRoleDialog:DataAtIndex(frame, index)
  if frame == self._upFrame then
    return self._resolveRoleList[index]
  else
    return self._itemList[index]
  end
end

function ResolveRoleDialog:OnBackPressed()
  self:Destroy()
  return true, true
end

return ResolveRoleDialog
