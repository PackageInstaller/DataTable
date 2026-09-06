local TableFrame = require("framework.ui.frame.table.tableframe")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local Equip = require("logic.manager.experimental.types.equip")
local Skill = require("logic.manager.experimental.types.skill")
local Item = require("logic.manager.experimental.types.item")
local Status = LuaNetManager.GetBeanDef("protocol.login.favorawardinfo")
local RelationAwardDialog = class("RelationAwardDialog", Dialog)
RelationAwardDialog.AssetBundleName = "ui/layouts.tujian"
RelationAwardDialog.AssetName = "TuJianCharInfoRelationItemAccount"

function RelationAwardDialog:Ctor(...)
  RelationAwardDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._data = nil
  self._selectedID = nil
end

function RelationAwardDialog:OnCreate()
  self._title = self:GetChild("Title")
  self._cellPanel = self:GetChild("CellPanel/CellPanel")
  self._confirmBtn = self:GetChild("ConfirmBtn")
  self._getBtn = self:GetChild("GetBtn")
  self._frame = TableFrame.Create(self._cellPanel, self, false)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnBackPressed, self)
  self._getBtn:Subscribe_PointerClickEvent(self.OnGetBtnClick, self)
end

function RelationAwardDialog:OnDestroy()
  self._frame:Destroy()
  if DialogManager.GetDialog("bag.itemtipsdialog") then
    DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  end
  DialogManager.DestroySingletonDialog("equip.equiptipsdialog")
  DialogManager.DestroySingletonDialog("equip.equiptipspreviewdialog")
  DialogManager.DestroySingletonDialog("bag.itemresolvedialog")
end

function RelationAwardDialog:Refresh(userInfo)
  for i, v in pairs(userInfo.favorAwardStatus) do
    if self._data.awardId == i and v == Status.STATUS_ALREADY then
      self._confirmBtn:SetActive(true)
      self._getBtn:SetActive(false)
      break
    end
  end
end

function RelationAwardDialog:RefreshCell(data)
  self._data = data
  if data.status == Status.STATUS_CANT then
    local str = TextManager.GetText(BeanManager.GetTableByName("message.cstringres"):GetRecorder(1223).msgTextID)
    self._title:SetText(str)
    self._confirmBtn:SetActive(true)
    self._getBtn:SetActive(false)
  elseif data.status == Status.STATUS_ABLE then
    local str = TextManager.GetText(BeanManager.GetTableByName("message.cstringres"):GetRecorder(1224).msgTextID)
    self._title:SetText(str)
    self._confirmBtn:SetActive(false)
    self._getBtn:SetActive(true)
  elseif data.status == Status.STATUS_ALREADY then
    local str = TextManager.GetText(BeanManager.GetTableByName("message.cstringres"):GetRecorder(1224).msgTextID)
    self._title:SetText(str)
    self._confirmBtn:SetActive(true)
    self._getBtn:SetActive(false)
  end
  self._frame:ReloadAllCell()
end

function RelationAwardDialog:NumberOfCell(frame)
  return #self._data.awards
end

function RelationAwardDialog:CellAtIndex(frame)
  return "bag.bagcell"
end

function RelationAwardDialog:DataAtIndex(frame, index)
  local data = {}
  local info = self._data.awards[index]
  local item
  if info.gain == 1 then
    if info.itemtype == ItemTypeEnum.BASEITEM then
      item = NekoData.BehaviorManager.BM_BagInfo:GetItem(info.id)
    elseif info.itemtype == ItemTypeEnum.EQUIP then
      item = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(info.id)
    end
  else
    if info.itemtype == ItemTypeEnum.BASEITEM then
      item = Item.Create(info.id)
    elseif info.itemtype == ItemTypeEnum.EQUIP then
      item = Equip.Create(info.id)
    elseif info.itemtype == ItemTypeEnum.SKILL then
      item = Skill.Create(info.id)
    end
    item:InitWithItemInfo(info)
  end
  data.item = item
  return data
end

function RelationAwardDialog:SetSelectedID(args)
  self._selectedID = args
  self._frame:FireEvent("ChangedSelected", self._selectedID)
end

function RelationAwardDialog:SetNotSelect()
  self._selectedID = nil
  self._frame:FireEvent("ChangedSelected", self._selectedID)
end

function RelationAwardDialog:OnGetBtnClick()
  local cSend = LuaNetManager.CreateProtocol("protocol.login.crolegetfavoraward")
  cSend.id = self._data.awardId
  cSend:Send()
  self:OnBackPressed()
end

function RelationAwardDialog:OnBackPressed()
  self:Destroy()
  return true, true
end

return RelationAwardDialog
