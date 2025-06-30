-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/branchline/branchlineunlockitemnotenoughtip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSideStoryChapter = (BeanManager.GetTableByName)("dungeonselect.csidestorychapter")
local ImageTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CSecondConfirm = (BeanManager.GetTableByName)("message.csecondconfirm")
local Item = require("logic.manager.experimental.types.item")
local BranchLineUnlockItemNotEnoughTip = class("BranchLineUnlockItemNotEnoughTip", Dialog)
BranchLineUnlockItemNotEnoughTip.AssetBundleName = "ui/layouts.sidestory"
BranchLineUnlockItemNotEnoughTip.AssetName = "SideStorySecondConfirm2"
BranchLineUnlockItemNotEnoughTip.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BranchLineUnlockItemNotEnoughTip
  ((BranchLineUnlockItemNotEnoughTip.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

BranchLineUnlockItemNotEnoughTip.OnCreate = function(self)
  -- function num : 0_1
  self._describ = self:GetChild("Text1")
  self._cancelBtn = self:GetChild("CancelButton")
  self._confirmBtn = self:GetChild("ConfirmButton")
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirm, self)
end

BranchLineUnlockItemNotEnoughTip.OnDestroy = function(self)
  -- function num : 0_2
end

BranchLineUnlockItemNotEnoughTip.Init = function(self, id)
  -- function num : 0_3 , upvalues : Item, _ENV, CSecondConfirm
  local item = (Item.Create)(id)
  local itemName = item:GetName()
  local str = (TextManager.GetText)((CSecondConfirm:GetRecorder(78)).messageTextID)
  str = (string.gsub)(str, "%$parameter1%$", itemName)
  str = (string.gsub)(str, "%$parameter2%$", "?????")
  ;
  (self._describ):SetText(str)
end

BranchLineUnlockItemNotEnoughTip.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

BranchLineUnlockItemNotEnoughTip.OnConfirm = function(self)
  -- function num : 0_5
  self:Destroy()
end

return BranchLineUnlockItemNotEnoughTip

