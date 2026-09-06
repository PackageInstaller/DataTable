local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Role = require("logic.manager.experimental.types.role")
local CSelectRoleCfg = BeanManager.GetTableByName("item.cselectrolecfg")
local GridColNum = 6
local BottomToTop = 3
local MailRoleOptionalDialog = class("MailRoleOptionalDialog", Dialog)
MailRoleOptionalDialog.AssetBundleName = "ui/layouts.mail"
MailRoleOptionalDialog.AssetName = "MailRoleOptional"

function MailRoleOptionalDialog:Ctor(...)
  MailRoleOptionalDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._selectIndex = 0
  self._roleList = {}
end

function MailRoleOptionalDialog:OnCreate()
  self._titleText = self:GetChild("Title/Text")
  self._recordPanel = self:GetChild("RecordFrame")
  self._buttomTxt = self:GetChild("Back/TopTxt")
  self._scrollBar = self:GetChild("Scrollbar")
  self._cancelButton = self:GetChild("CancelButton")
  self._confirmButton = self:GetChild("ConfirmButton")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._recordFrame = GridFrame.Create(self._recordPanel, self, true, GridColNum, true)
  self._cancelButton:Subscribe_PointerClickEvent(self.OnCancelBtnClick, self)
  self._confirmButton:Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
  self:SetStaticRes()
end

function MailRoleOptionalDialog:SetStaticRes()
  self._titleText:SetText(TextManager.GetText(CStringRes:GetRecorder(1624).msgTextID))
  self._buttomTxt:SetText(TextManager.GetText(CStringRes:GetRecorder(1625).msgTextID))
end

function MailRoleOptionalDialog:OnDestroy()
  self._recordFrame:Destroy()
end

function MailRoleOptionalDialog:SetData(mailID, mailUniqueID)
  self._mailID = mailID
  self._mailUniqueID = mailUniqueID
  self._selectIndex = 0
  for key, _ in pairs(self._roleList) do
    self._roleList[key] = nil
  end
  local record = CSelectRoleCfg:GetRecorder(1)
  for _, value in ipairs(record.role) do
    table.insert(self._roleList, Role.Create(value))
  end
  self._recordFrame:ReloadAllCell()
end

function MailRoleOptionalDialog:NumberOfCell(frame)
  return #self._roleList
end

function MailRoleOptionalDialog:CellAtIndex(frame)
  return "mail.mailroleoptionalcell"
end

function MailRoleOptionalDialog:DataAtIndex(frame, index)
  return {
    role = self._roleList[index],
    index = index
  }
end

function MailRoleOptionalDialog:OnCancelBtnClick()
  self:Destroy()
end

function MailRoleOptionalDialog:OnConfirmBtnClick()
  if self._selectIndex > 0 then
    local role = self._roleList[self._selectIndex]
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(123, {
      role:GetRoleName()
    }, function()
      local protocol = LuaNetManager.CreateProtocol("protocol.mail.cselfselectrole")
      if protocol then
        protocol.mailKey = self._mailUniqueID
        protocol.select = role:GetId()
        protocol:Send()
      end
      self:Destroy()
    end, {}, nil, {})
  end
end

function MailRoleOptionalDialog:OnCellClick(index)
  self._selectIndex = index
  self._recordFrame:FireEvent("ChangeSelected", index)
end

function MailRoleOptionalDialog:OnCellLongPress(index)
  local role = self._roleList[index]
  local dialog = DialogManager.CreateSingletonDialog("mainline.bossrush.checkotherroleinfodialog")
  if dialog then
    dialog:Init({
      roleIdList = {
        role:GetId()
      },
      cfgIdList = {3},
      index = 1
    }, CheckOtherRoleInfoDialog.ShowType.BaseLevelInfo)
  end
end

function MailRoleOptionalDialog:OnCurPosChange(frame, proportion)
  local width, height = self._recordPanel:GetRectSize()
  local total = self._recordFrame:GetTotalLength()
  if height < total then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

return MailRoleOptionalDialog
