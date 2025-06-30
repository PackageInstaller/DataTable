-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/confirmbox/chestconfirmdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ChestConfirmDialog = class("ChestConfirmDialog", Dialog)
local Item = require("logic.manager.experimental.types.item")
ChestConfirmDialog.AssetBundleName = "ui/layouts.secondconfirm"
ChestConfirmDialog.AssetName = "SecondConfirmChest"
ChestConfirmDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChestConfirmDialog
  ((ChestConfirmDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._messageStacks = {}
  self._currentMessage = nil
  self._cancelBtnClickFunc = nil
  self._cancelBtnClickFuncArgs = nil
  self._confirmBtnClickFunc = nil
  self._confirmBtnClickFuncArgs = nil
  self._confirmId = nil
  self._confirmType = 0
end

ChestConfirmDialog.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("Text")
  self._cancelButton = self:GetChild("CancelButton")
  self._cancelButtonText = self:GetChild("CancelButton/_Text")
  self._confirmButton = self:GetChild("ConfirmButton")
  self._confirmButtonText = self:GetChild("ConfirmButton/_Text")
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._name = self:GetChild("Name")
  self._reqNum = self:GetChild("NumNeed")
  self._curNum = self:GetChild("NumHave")
  ;
  (self._cancelButton):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnClickConfirmBtn, self)
end

ChestConfirmDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

ChestConfirmDialog.Refresh = function(self)
  -- function num : 0_3 , upvalues : _ENV, Item
  if (table.nums)(self._messageStacks) == 0 then
    (DialogManager.DestroySingletonDialog)("confirmbox.chestconfirmdialog")
    return 
  end
  self._currentMessage = (self._messageStacks)[1]
  local item = (Item.Create)((self._currentMessage).id)
  ;
  (self._name):SetText(item:GetName())
  ;
  (self._curNum):SetText(((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById((self._currentMessage).id))
  local image = item:GetIcon()
  ;
  (self._icon):SetSprite(image.assetBundle, image.assetName)
  self._cancelBtnClickFunc = (self._currentMessage).nofunc
  self._cancelBtnClickFuncArgs = (self._currentMessage).noargs
  self._confirmBtnClickFunc = (self._currentMessage).yesfunc
  self._confirmBtnClickFuncArgs = (self._currentMessage).yesargs
end

ChestConfirmDialog.PushDialogSetting = function(self, id, yesfunc, yesargs, nofunc, noargs)
  -- function num : 0_4 , upvalues : _ENV
  local message = {}
  message.id = id
  message.yesfunc = yesfunc
  message.yesargs = yesargs
  message.nofunc = nofunc
  message.noargs = noargs
  ;
  (table.insert)(self._messageStacks, 1, message)
  self:Refresh()
end

ChestConfirmDialog.LoadData = function(self, data)
  -- function num : 0_5
  self._messageStacks = data
  self:Refresh()
end

ChestConfirmDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self._cancelBtnClickFunc then
    (self._cancelBtnClickFunc)(self._cancelBtnClickFuncArgs)
    self._cancelBtnClickFunc = nil
  end
  self._currentMessage = nil
  ;
  (table.remove)(self._messageStacks, 1)
  self:Refresh()
end

ChestConfirmDialog.OnClickConfirmBtn = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self._confirmBtnClickFunc then
    (self._confirmBtnClickFunc)(self._confirmBtnClickFuncArgs)
    self._confirmBtnClickFunc = nil
  end
  self._currentMessage = nil
  ;
  (table.remove)(self._messageStacks, 1)
  self:Refresh()
end

ChestConfirmDialog.GetCurMessageId = function(self)
  -- function num : 0_8
  return self._confirmId
end

return ChestConfirmDialog

