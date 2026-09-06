local CStringRes = BeanManager.GetTableByName("message.cstringres")
local InviteUtil = require("logic.dialog.invite.inviteutil")
local InviteAwardCell = class("InviteAwardCell", Dialog)
InviteAwardCell.AssetBundleName = "ui/layouts.invite"
InviteAwardCell.AssetName = "InviteTaskCell"

function InviteAwardCell:Ctor(...)
  InviteAwardCell.super.Ctor(self, ...)
end

function InviteAwardCell:OnCreate()
  self._title = self:GetChild("Back/Title1")
  self._detail = self:GetChild("Back/Detail")
  self._progress = self:GetChild("Back/ProgressBack/Progress")
  self._cur = self:GetChild("Back/ProgressBack/Num/Num")
  self._max = self:GetChild("Back/ProgressBack/Num/NumMax")
  self._itemCell = self:GetChild("Back/ItemCell")
  self._getBtn = self:GetChild("Back/GetBtn")
  self._gotten = self:GetChild("Back/BackDone")
  self._gottenText = self:GetChild("Back/TextDone")
  self._itemCell:Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  self._getBtn:Subscribe_PointerClickEvent(self.GetAward, self)
end

function InviteAwardCell:OnDestroy()
end

function InviteAwardCell:RefreshCell(data)
  self._cellData = data
  if data.rewardState == 2 then
    self._getBtn:SetActive(false)
    self._gotten:SetActive(true)
    self._gottenText:SetActive(true)
  elseif data.rewardState == 0 then
    self._getBtn:SetInteractable(false)
    self._getBtn:SetActive(true)
    self._gotten:SetActive(false)
    self._gottenText:SetActive(false)
  elseif data.rewardState == 1 then
    self._getBtn:SetInteractable(true)
    self._getBtn:SetActive(true)
    self._gotten:SetActive(false)
    self._gottenText:SetActive(false)
  end
  self._progress:SetFillAmount(data.progress / data.maxPlayer)
  local num = data.progress < data.maxPlayer and data.progress or data.maxPlayer
  self._cur:SetText(num)
  self._max:SetText(data.maxPlayer)
  local title = ""
  if data.level == 1 then
    title = TextManager.GetText(CStringRes:GetRecorder(1522).msgTextID)
    title = string.gsub(title, "%$parameter1%$", data.maxPlayer)
  else
    title = TextManager.GetText(CStringRes:GetRecorder(1515).msgTextID)
    title = string.gsub(title, "%$parameter1%$", data.maxPlayer)
    title = string.gsub(title, "%$parameter2%$", data.level)
  end
  self._title:SetText(title)
  InviteUtil.SetItemInfo(self._itemCell, data.item)
end

function InviteAwardCell:OnItemCellClicked()
  local width, height = self._itemCell:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._cellData.item.item
    })
    tipsDialog:SetTipsPosition(width, height, self._itemCell:GetLocalPointInUiRootPanel())
  end
end

function InviteAwardCell:GetAward()
  local cmd = LuaNetManager.CreateProtocol("protocol.activity.creceiveinvitationreward")
  cmd.rewardID = self._cellData.rewardID
  cmd:Send()
end

return InviteAwardCell
