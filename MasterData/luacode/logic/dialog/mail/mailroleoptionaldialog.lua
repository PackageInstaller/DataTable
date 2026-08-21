-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mail/mailroleoptionaldialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Role = require("logic.manager.experimental.types.role")
local CSelectRoleCfg = (BeanManager.GetTableByName)("item.cselectrolecfg")
local GridColNum = 6
local BottomToTop = 3
local MailRoleOptionalDialog = class("MailRoleOptionalDialog", Dialog)
MailRoleOptionalDialog.AssetBundleName = "ui/layouts.mail"
MailRoleOptionalDialog.AssetName = "MailRoleOptional"
MailRoleOptionalDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MailRoleOptionalDialog
  ((MailRoleOptionalDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._selectIndex = 0
  self._roleList = {}
end

MailRoleOptionalDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, GridFrame, GridColNum
  self._titleText = self:GetChild("Title/Text")
  self._recordPanel = self:GetChild("RecordFrame")
  self._buttomTxt = self:GetChild("Back/TopTxt")
  self._scrollBar = self:GetChild("Scrollbar")
  self._cancelButton = self:GetChild("CancelButton")
  self._confirmButton = self:GetChild("ConfirmButton")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._recordFrame = (GridFrame.Create)(self._recordPanel, self, true, GridColNum, true)
  ;
  (self._cancelButton):Subscribe_PointerClickEvent(self.OnCancelBtnClick, self)
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
  self:SetStaticRes()
end

MailRoleOptionalDialog.SetStaticRes = function(self)
  -- function num : 0_2 , upvalues : _ENV, CStringRes
  (self._titleText):SetText((TextManager.GetText)((CStringRes:GetRecorder(1624)).msgTextID))
  ;
  (self._buttomTxt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1625)).msgTextID))
end

MailRoleOptionalDialog.OnDestroy = function(self)
  -- function num : 0_3
  (self._recordFrame):Destroy()
end

MailRoleOptionalDialog.SetData = function(self, mailID, mailUniqueID)
  -- function num : 0_4 , upvalues : _ENV, CSelectRoleCfg, Role
  self._mailID = mailID
  self._mailUniqueID = mailUniqueID
  self._selectIndex = 0
  for key,_ in pairs(self._roleList) do
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R8 in 'UnsetPending'

    (self._roleList)[key] = nil
  end
  local record = CSelectRoleCfg:GetRecorder(1)
  for _,value in ipairs(record.role) do
    (table.insert)(self._roleList, (Role.Create)(value))
  end
  ;
  (self._recordFrame):ReloadAllCell()
end

MailRoleOptionalDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._roleList
end

MailRoleOptionalDialog.CellAtIndex = function(self, frame)
  -- function num : 0_6
  return "mail.mailroleoptionalcell"
end

MailRoleOptionalDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return {role = (self._roleList)[index], index = index}
end

MailRoleOptionalDialog.OnCancelBtnClick = function(self)
  -- function num : 0_8
  self:Destroy()
end

MailRoleOptionalDialog.OnConfirmBtnClick = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if self._selectIndex > 0 then
    local role = (self._roleList)[self._selectIndex]
    do
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(123, {role:GetRoleName()}, function()
    -- function num : 0_9_0 , upvalues : _ENV, self, role
    local protocol = (LuaNetManager.CreateProtocol)("protocol.mail.cselfselectrole")
    if protocol then
      protocol.mailKey = self._mailUniqueID
      protocol.select = role:GetId()
      protocol:Send()
    end
    self:Destroy()
  end
, {}, nil, {})
    end
  end
end

MailRoleOptionalDialog.OnCellClick = function(self, index)
  -- function num : 0_10
  self._selectIndex = index
  ;
  (self._recordFrame):FireEvent("ChangeSelected", index)
end

MailRoleOptionalDialog.OnCellLongPress = function(self, index)
  -- function num : 0_11 , upvalues : _ENV, CheckOtherRoleInfoDialog
  local role = (self._roleList)[index]
  local dialog = (DialogManager.CreateSingletonDialog)("mainline.bossrush.checkotherroleinfodialog")
  if dialog then
    dialog:Init({
roleIdList = {role:GetId()}
, 
cfgIdList = {3}
, index = 1}, (CheckOtherRoleInfoDialog.ShowType).BaseLevelInfo)
  end
end

MailRoleOptionalDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_12
  local width, height = (self._recordPanel):GetRectSize()
  local total = (self._recordFrame):GetTotalLength()
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

return MailRoleOptionalDialog

