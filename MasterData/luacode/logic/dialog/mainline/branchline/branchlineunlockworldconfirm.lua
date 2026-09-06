local CSideStoryChapter = BeanManager.GetTableByName("dungeonselect.csidestorychapter")
local ImageTable = BeanManager.GetTableByName("ui.cimagepath")
local CSecondConfirm = BeanManager.GetTableByName("message.csecondconfirm")
local Item = require("logic.manager.experimental.types.item")
local BranchLineUnlockWorldConfirm = class("BranchLineUnlockWorldConfirm", Dialog)
BranchLineUnlockWorldConfirm.AssetBundleName = "ui/layouts.sidestory"
BranchLineUnlockWorldConfirm.AssetName = "SideStorySecondConfirm1"

function BranchLineUnlockWorldConfirm:Ctor(...)
  BranchLineUnlockWorldConfirm.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function BranchLineUnlockWorldConfirm:OnCreate()
  self._describ = self:GetChild("Text1")
  self._cancelBtn = self:GetChild("CancelButton")
  self._confirmBtn = self:GetChild("ConfirmButton")
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirm, self)
end

function BranchLineUnlockWorldConfirm:OnDestroy()
end

function BranchLineUnlockWorldConfirm:Init(id)
  self._id = id
  local recorder = CSideStoryChapter:GetRecorder(id)
  self._itemId = recorder.unlockitem
  local item = Item.Create(self._itemId)
  local itemName = item:GetName()
  local str = TextManager.GetText(CSecondConfirm:GetRecorder(77).messageTextID)
  str = string.gsub(str, "%$parameter1%$", itemName)
  str = string.gsub(str, "%$parameter2%$", TextManager.GetText(recorder.chapternumnametxt))
  str = string.gsub(str, "%$parameter3%$", TextManager.GetText(recorder.sidestorytitletxt))
  self._describ:SetText(str)
end

function BranchLineUnlockWorldConfirm:OnBackBtnClicked()
  self:Destroy()
end

function BranchLineUnlockWorldConfirm:OnConfirm()
  local count = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(self._itemId)
  if 0 < count then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.cunlocknewsidequest")
    csend.unlockDungeonID = self._id
    csend:Send()
    self:Destroy()
  else
    local dialog = DialogManager.CreateSingletonDialog("mainline.branchline.branchlineunlockitemnotenoughtip")
    if dialog then
      dialog:Init(self._itemId)
    end
    self:Destroy()
  end
end

return BranchLineUnlockWorldConfirm
