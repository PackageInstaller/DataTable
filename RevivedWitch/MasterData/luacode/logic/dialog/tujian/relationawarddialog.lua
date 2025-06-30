-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tujian/relationawarddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local Equip = require("logic.manager.experimental.types.equip")
local Skill = require("logic.manager.experimental.types.skill")
local Item = require("logic.manager.experimental.types.item")
local Status = (LuaNetManager.GetBeanDef)("protocol.login.favorawardinfo")
local RelationAwardDialog = class("RelationAwardDialog", Dialog)
RelationAwardDialog.AssetBundleName = "ui/layouts.tujian"
RelationAwardDialog.AssetName = "TuJianCharInfoRelationItemAccount"
RelationAwardDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RelationAwardDialog
  ((RelationAwardDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._data = nil
  self._selectedID = nil
end

RelationAwardDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._title = self:GetChild("Title")
  self._cellPanel = self:GetChild("CellPanel/CellPanel")
  self._confirmBtn = self:GetChild("ConfirmBtn")
  self._getBtn = self:GetChild("GetBtn")
  self._frame = (TableFrame.Create)(self._cellPanel, self, false)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnBackPressed, self)
  ;
  (self._getBtn):Subscribe_PointerClickEvent(self.OnGetBtnClick, self)
end

RelationAwardDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
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

RelationAwardDialog.Refresh = function(self, userInfo)
  -- function num : 0_3 , upvalues : _ENV, Status
  for i,v in pairs(userInfo.favorAwardStatus) do
    if (self._data).awardId == i and v == Status.STATUS_ALREADY then
      (self._confirmBtn):SetActive(true)
      ;
      (self._getBtn):SetActive(false)
      break
    end
  end
end

RelationAwardDialog.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : Status, _ENV
  self._data = data
  if data.status == Status.STATUS_CANT then
    local str = (TextManager.GetText)((((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1223)).msgTextID)
    ;
    (self._title):SetText(str)
    ;
    (self._confirmBtn):SetActive(true)
    ;
    (self._getBtn):SetActive(false)
  else
    do
      if data.status == Status.STATUS_ABLE then
        local str = (TextManager.GetText)((((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1224)).msgTextID)
        ;
        (self._title):SetText(str)
        ;
        (self._confirmBtn):SetActive(false)
        ;
        (self._getBtn):SetActive(true)
      else
        do
          do
            if data.status == Status.STATUS_ALREADY then
              local str = (TextManager.GetText)((((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1224)).msgTextID)
              ;
              (self._title):SetText(str)
              ;
              (self._confirmBtn):SetActive(true)
              ;
              (self._getBtn):SetActive(false)
            end
            ;
            (self._frame):ReloadAllCell()
          end
        end
      end
    end
  end
end

RelationAwardDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #(self._data).awards
end

RelationAwardDialog.CellAtIndex = function(self, frame)
  -- function num : 0_6
  return "bag.bagcell"
end

RelationAwardDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7 , upvalues : ItemTypeEnum, _ENV, Item, Equip, Skill
  local data = {}
  local info = ((self._data).awards)[index]
  local item = nil
  if info.gain == 1 then
    if info.itemtype == ItemTypeEnum.BASEITEM then
      item = ((NekoData.BehaviorManager).BM_BagInfo):GetItem(info.id)
    else
      if info.itemtype == ItemTypeEnum.EQUIP then
        item = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(info.id)
      end
    end
  else
    if info.itemtype == ItemTypeEnum.BASEITEM then
      item = (Item.Create)(info.id)
    else
      if info.itemtype == ItemTypeEnum.EQUIP then
        item = (Equip.Create)(info.id)
      else
        if info.itemtype == ItemTypeEnum.SKILL then
          item = (Skill.Create)(info.id)
        end
      end
    end
    item:InitWithItemInfo(info)
  end
  data.item = item
  return data
end

RelationAwardDialog.SetSelectedID = function(self, args)
  -- function num : 0_8
  self._selectedID = args
  ;
  (self._frame):FireEvent("ChangedSelected", self._selectedID)
end

RelationAwardDialog.SetNotSelect = function(self)
  -- function num : 0_9
  self._selectedID = nil
  ;
  (self._frame):FireEvent("ChangedSelected", self._selectedID)
end

RelationAwardDialog.OnGetBtnClick = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local cSend = (LuaNetManager.CreateProtocol)("protocol.login.crolegetfavoraward")
  cSend.id = (self._data).awardId
  cSend:Send()
  self:OnBackPressed()
end

RelationAwardDialog.OnBackPressed = function(self)
  -- function num : 0_11
  self:Destroy()
  return true, true
end

return RelationAwardDialog

