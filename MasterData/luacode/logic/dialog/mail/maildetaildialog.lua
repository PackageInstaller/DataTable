local TableFrame = require("framework.ui.frame.table.tableframe")
local MailDetailDialog = class("MailDetailDialog", Dialog)
MailDetailDialog.AssetBundleName = "ui/layouts.mail"
MailDetailDialog.AssetName = "MailDetail"
local TopToBottom = 3

function MailDetailDialog:Ctor(...)
  MailDetailDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._mailDetail = nil
end

function MailDetailDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._title = self:GetChild("Title/Text")
  self._scrollBar = self:GetChild("MailFrame/Scrollbar")
  self._scrollBar:SetScrollDirection(TopToBottom)
  self._detail = self:GetChild("MailFrame/Detail")
  self._rightImage = self:GetChild("MailFrame/Item/RightImage")
  self._leftImage = self:GetChild("MailFrame/Item/LeftImage")
  self._itemFrame = self:GetChild("MailFrame/Item/Item")
  self._deleteBtn = self:GetChild("MailFrame/DeleteBtn")
  self._getBtn = self:GetChild("MailFrame/GetBtn")
  self._detailFrame = TableFrame.Create(self._detail, self, true)
  self._frame = TableFrame.Create(self._itemFrame, self, false)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._deleteBtn:Subscribe_PointerClickEvent(self.OnClickDeleteBtn, self)
  self._getBtn:Subscribe_PointerClickEvent(self.OnClickGetBtn, self)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_DialogWillDestroy, nil)
end

function MailDetailDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._detailFrame:Destroy()
  self._frame:Destroy()
  if DialogManager.GetDialog("bag.itemtipsdialog") then
    DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  end
  DialogManager.DestroySingletonDialog("equip.equiptipsdialog")
  DialogManager.DestroySingletonDialog("equip.equiptipspreviewdialog")
  DialogManager.DestroySingletonDialog("bag.itemresolvedialog")
end

function MailDetailDialog:SetData(data)
  self._mailDetail = data
  self:Refresh()
end

function MailDetailDialog:OnRefresh()
  self._getBtn:SetActive(false)
  self._deleteBtn:SetActive(true)
end

function MailDetailDialog:GetMailUniqueId()
  return self._mailDetail.uniqueId
end

function MailDetailDialog:Refresh()
  self._getBtn:SetActive(self._mailDetail.status == 0 and 0 < #self._mailDetail.attachmentList)
  self._title:SetText(tostring(self._mailDetail.title))
  self._detailFrame:ReloadAllCell()
  self._frame:ReloadAllCell()
end

function MailDetailDialog:OnCurPosChange(frame, proportion)
  if frame == self._detailFrame then
    local width, height = self._detail:GetRectSize()
    local total = self._detailFrame:GetTotalLength()
    if height < total then
      self._scrollBar:SetActive(true)
      self._scrollBar:SetScrollSize(height / total)
      self._scrollBar:SetScrollValue(proportion)
    else
      self._scrollBar:SetActive(false)
    end
  end
  if frame == self._frame then
    self._leftImage:SetActive(proportion ~= 0)
    self._rightImage:SetActive(proportion ~= 1)
    local width, _ = self._itemFrame:GetRectSize()
    if width >= self._frame:GetTotalLength() then
      self._leftImage:SetActive(false)
      self._rightImage:SetActive(false)
    end
  end
end

function MailDetailDialog:OnBackBtnClicked()
  DialogManager.DestroySingletonDialog("mail.maildetaildialog")
end

function MailDetailDialog:OnClickDeleteBtn()
  local cdeleteOne = LuaNetManager.CreateProtocol("protocol.mail.cdeleteone")
  if cdeleteOne then
    cdeleteOne.uniqueId = self._mailDetail.uniqueId
    cdeleteOne:Send()
  end
end

function MailDetailDialog:OnClickGetBtn()
  local creceiveOne = LuaNetManager.CreateProtocol("protocol.mail.creceiveone")
  if creceiveOne then
    creceiveOne.uniqueId = self._mailDetail.uniqueId
    creceiveOne:Send()
  end
end

function MailDetailDialog:OnGlobalPointerDown(notification)
  if not notification.userInfo._rootWindow:IsChildOf(self._rootWindow) and notification.userInfo._dialogName ~= "clickeffect.clickeffectcell" then
    self._frame:FireEvent("ChangedSelected", nil)
  end
end

function MailDetailDialog:SetSelectedID(args)
  self._selectedID = args
  self._frame:FireEvent("ChangedSelected", self._selectedID)
end

function MailDetailDialog:NumberOfCell(frame)
  if frame == self._frame then
    return #self._mailDetail.attachmentList
  end
  if frame == self._detailFrame then
    return 1
  end
end

function MailDetailDialog:CellAtIndex(frame)
  if frame == self._frame then
    return "bag.bagcell"
  end
  if frame == self._detailFrame then
    return "mail.maildetailcell"
  end
end

function MailDetailDialog:DataAtIndex(frame, index)
  local data = {}
  if frame == self._frame then
    data.id = self._mailDetail.attachmentList[index].id
    data.count = self._mailDetail.attachmentList[index].num
  end
  if frame == self._detailFrame then
    data.name = self._mailDetail.appellation
    data.detail = self._mailDetail.content
    data.signature = self._mailDetail.signature
  end
  return data
end

return MailDetailDialog
