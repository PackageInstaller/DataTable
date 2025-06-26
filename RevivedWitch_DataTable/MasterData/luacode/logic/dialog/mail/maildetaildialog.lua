-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mail/maildetaildialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local MailDetailDialog = class("MailDetailDialog", Dialog)
MailDetailDialog.AssetBundleName = "ui/layouts.mail"
MailDetailDialog.AssetName = "MailDetail"
local TopToBottom = 3
MailDetailDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MailDetailDialog
  ((MailDetailDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._mailDetail = nil
end

MailDetailDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TopToBottom, TableFrame, _ENV
  self._backBtn = self:GetChild("BackBtn")
  self._title = self:GetChild("Title/Text")
  self._scrollBar = self:GetChild("MailFrame/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(TopToBottom)
  self._detail = self:GetChild("MailFrame/Detail")
  self._rightImage = self:GetChild("MailFrame/Item/RightImage")
  self._leftImage = self:GetChild("MailFrame/Item/LeftImage")
  self._itemFrame = self:GetChild("MailFrame/Item/Item")
  self._deleteBtn = self:GetChild("MailFrame/DeleteBtn")
  self._getBtn = self:GetChild("MailFrame/GetBtn")
  self._detailFrame = (TableFrame.Create)(self._detail, self, true)
  self._frame = (TableFrame.Create)(self._itemFrame, self, false)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._deleteBtn):Subscribe_PointerClickEvent(self.OnClickDeleteBtn, self)
  ;
  (self._getBtn):Subscribe_PointerClickEvent(self.OnClickGetBtn, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_DialogWillDestroy, nil)
end

MailDetailDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._detailFrame):Destroy()
  ;
  (self._frame):Destroy()
  if (DialogManager.GetDialog)("bag.itemtipsdialog") then
    (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
  end
  ;
  (DialogManager.DestroySingletonDialog)("equip.equiptipsdialog")
  ;
  (DialogManager.DestroySingletonDialog)("equip.equiptipspreviewdialog")
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemresolvedialog")
end

MailDetailDialog.SetData = function(self, data)
  -- function num : 0_3
  self._mailDetail = data
  self:Refresh()
end

MailDetailDialog.OnRefresh = function(self)
  -- function num : 0_4
  (self._getBtn):SetActive(false)
  ;
  (self._deleteBtn):SetActive(true)
end

MailDetailDialog.GetMailUniqueId = function(self)
  -- function num : 0_5
  return (self._mailDetail).uniqueId
end

MailDetailDialog.Refresh = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ;
  (self._getBtn):SetActive((self._mailDetail).status == 0 and #(self._mailDetail).attachmentList > 0)
  ;
  (self._title):SetText(tostring((self._mailDetail).title))
  ;
  (self._detailFrame):ReloadAllCell()
  ;
  (self._frame):ReloadAllCell()
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

MailDetailDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_7
  if frame == self._detailFrame then
    local width, height = (self._detail):GetRectSize()
    local total = (self._detailFrame):GetTotalLength()
    if height < total then
      (self._scrollBar):SetActive(true)
      ;
      (self._scrollBar):SetScrollSize(height / total)
      ;
      (self._scrollBar):SetScrollValue(proportion)
    else
      ;
      (self._scrollBar):SetActive(false)
    end
  end
  do
    if proportion == 0 then
      (self._leftImage):SetActive(frame ~= self._frame)
      ;
      (self._rightImage):SetActive(proportion ~= 1)
      do
        local width, _ = (self._itemFrame):GetRectSize()
        if (self._frame):GetTotalLength() <= width then
          (self._leftImage):SetActive(false)
          ;
          (self._rightImage):SetActive(false)
        end
        -- DECOMPILER ERROR: 3 unprocessed JMP targets
      end
    end
  end
end

MailDetailDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("mail.maildetaildialog")
end

MailDetailDialog.OnClickDeleteBtn = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local cdeleteOne = (LuaNetManager.CreateProtocol)("protocol.mail.cdeleteone")
  if cdeleteOne then
    cdeleteOne.uniqueId = (self._mailDetail).uniqueId
    cdeleteOne:Send()
  end
end

MailDetailDialog.OnClickGetBtn = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local creceiveOne = (LuaNetManager.CreateProtocol)("protocol.mail.creceiveone")
  if creceiveOne then
    creceiveOne.uniqueId = (self._mailDetail).uniqueId
    creceiveOne:Send()
  end
end

MailDetailDialog.OnGlobalPointerDown = function(self, notification)
  -- function num : 0_11
  if not ((notification.userInfo)._rootWindow):IsChildOf(self._rootWindow) and (notification.userInfo)._dialogName ~= "clickeffect.clickeffectcell" then
    (self._frame):FireEvent("ChangedSelected", nil)
  end
end

MailDetailDialog.SetSelectedID = function(self, args)
  -- function num : 0_12
  self._selectedID = args
  ;
  (self._frame):FireEvent("ChangedSelected", self._selectedID)
end

MailDetailDialog.NumberOfCell = function(self, frame)
  -- function num : 0_13
  if frame == self._frame then
    return #(self._mailDetail).attachmentList
  end
  if frame == self._detailFrame then
    return 1
  end
end

MailDetailDialog.CellAtIndex = function(self, frame)
  -- function num : 0_14
  if frame == self._frame then
    return "bag.bagcell"
  end
  if frame == self._detailFrame then
    return "mail.maildetailcell"
  end
end

MailDetailDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_15
  local data = {}
  if frame == self._frame then
    data.id = (((self._mailDetail).attachmentList)[index]).id
    data.count = (((self._mailDetail).attachmentList)[index]).num
  end
  if frame == self._detailFrame then
    data.name = (self._mailDetail).appellation
    data.detail = (self._mailDetail).content
    data.signature = (self._mailDetail).signature
  end
  return data
end

return MailDetailDialog

