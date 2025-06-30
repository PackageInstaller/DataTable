-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/resolveroledialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local ResolveRoleDialog = class("ResolveRoleDialog", Dialog)
ResolveRoleDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
ResolveRoleDialog.AssetName = "BaseCharactorCellListResolve"
ResolveRoleDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ResolveRoleDialog
  ((ResolveRoleDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._resolveRoleList = {}
  self._itemList = {}
end

ResolveRoleDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._upPanel = self:GetChild("Back/Frame")
  self._downPanel = self:GetChild("Back/Frame2")
  self._cancelButton = self:GetChild("Back/CancelBtn")
  self._confirmButton = self:GetChild("Back/ConfirmBtn")
  self._upFrame = (TableFrame.Create)(self._upPanel, self, false, true)
  self._downFrame = (TableFrame.Create)(self._downPanel, self, false, true)
  ;
  (self._upFrame):SetMargin(35, 35)
  ;
  (self._downFrame):SetMargin(35, 35)
  ;
  (self._cancelButton):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
end

ResolveRoleDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._upFrame):Destroy()
  ;
  (self._downFrame):Destroy()
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
end

ResolveRoleDialog.SetData = function(self, roleList)
  -- function num : 0_3 , upvalues : _ENV, Item
  local items = {}
  for i,v in ipairs(roleList) do
    (table.insert)(self._resolveRoleList, v)
    local roleItem = (Item.Create)(v:GetItemId())
    local id = roleItem:GetResolveItemId()
    local item = items[id]
    if item then
      item:SetCount(item:GetCount() + roleItem:GetResolveItemNum())
    else
      item = (Item.Create)(id)
      item:SetCount(roleItem:GetResolveItemNum())
      items[id] = item
    end
  end
  for k,v in pairs(items) do
    (table.insert)(self._itemList, v)
  end
  if #self._resolveRoleList > 6 then
    (self._upFrame):SetSlide(true)
  else
    ;
    (self._upFrame):SetSlide(false)
  end
  if #self._itemList > 6 then
    (self._downFrame):SetSlide(true)
  else
    ;
    (self._downFrame):SetSlide(false)
  end
  ;
  (self._upFrame):ReloadAllCell()
  ;
  (self._downFrame):ReloadAllCell()
end

ResolveRoleDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

ResolveRoleDialog.OnClickConfirmBtn = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local list = {}
  for i,v in ipairs(self._resolveRoleList) do
    (table.insert)(list, v:GetRoleId())
  end
  self:Destroy()
end

ResolveRoleDialog.NumberOfCell = function(self, frame)
  -- function num : 0_6
  if frame == self._upFrame then
    return #self._resolveRoleList
  else
    return #self._itemList
  end
end

ResolveRoleDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  if frame == self._upFrame then
    return "character.resolverolecell"
  else
    return "character.resolveitemcell"
  end
end

ResolveRoleDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  if frame == self._upFrame then
    return (self._resolveRoleList)[index]
  else
    return (self._itemList)[index]
  end
end

ResolveRoleDialog.OnBackPressed = function(self)
  -- function num : 0_9
  self:Destroy()
  return true, true
end

return ResolveRoleDialog

