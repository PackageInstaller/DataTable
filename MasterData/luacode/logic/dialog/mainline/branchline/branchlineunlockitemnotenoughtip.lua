local CSideStoryChapter = BeanManager.GetTableByName("dungeonselect.csidestorychapter")
local ImageTable = BeanManager.GetTableByName("ui.cimagepath")
local CSecondConfirm = BeanManager.GetTableByName("message.csecondconfirm")
local Item = require("logic.manager.experimental.types.item")
local BranchLineUnlockItemNotEnoughTip = class("BranchLineUnlockItemNotEnoughTip", Dialog)
BranchLineUnlockItemNotEnoughTip.AssetBundleName = "ui/layouts.sidestory"
BranchLineUnlockItemNotEnoughTip.AssetName = "SideStorySecondConfirm2"

function BranchLineUnlockItemNotEnoughTip:Ctor(...)
  BranchLineUnlockItemNotEnoughTip.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function BranchLineUnlockItemNotEnoughTip:OnCreate()
  self._describ = self:GetChild("Text1")
  self._cancelBtn = self:GetChild("CancelButton")
  self._confirmBtn = self:GetChild("ConfirmButton")
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirm, self)
end

function BranchLineUnlockItemNotEnoughTip:OnDestroy()
end

function BranchLineUnlockItemNotEnoughTip:Init(id)
  local item = Item.Create(id)
  local itemName = item:GetName()
  local str = TextManager.GetText(CSecondConfirm:GetRecorder(78).messageTextID)
  str = string.gsub(str, "%$parameter1%$", itemName)
  str = string.gsub(str, "%$parameter2%$", "?????")
  self._describ:SetText(str)
end

function BranchLineUnlockItemNotEnoughTip:OnBackBtnClicked()
  self:Destroy()
end

function BranchLineUnlockItemNotEnoughTip:OnConfirm()
  self:Destroy()
end

return BranchLineUnlockItemNotEnoughTip
