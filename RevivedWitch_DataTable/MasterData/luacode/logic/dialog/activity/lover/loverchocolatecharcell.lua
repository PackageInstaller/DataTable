-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/lover/loverchocolatecharcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CValentineChocolateItem = (BeanManager.GetTableByName)("activity.cvalentinechocolateitem")
local CItemTable = (BeanManager.GetTableByName)("item.citemattr")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CValentineChatConfig = (BeanManager.GetTableByName)("dialog.cvalentinechatconfig")
local Item = require("logic.manager.experimental.types.item")
local LoverChocolateCharCell = class("LoverChocolateCharCell", Dialog)
LoverChocolateCharCell.AssetBundleName = "ui/layouts.activityvalentines"
LoverChocolateCharCell.AssetName = "ActivityValentinesNpcCell"
local RoleUnLockType = {Lock = 0, UnLock = 1}
LoverChocolateCharCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LoverChocolateCharCell
  ((LoverChocolateCharCell.super).Ctor)(self, ...)
  self._needItemId = 0
  self._needNum = 0
end

LoverChocolateCharCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : CValentineChocolateItem, CItemTable, CImagePathTable
  self._clickTxt = self:GetChild("CellBack/Text")
  self._charName = self:GetChild("CellBack/ItemName")
  self._charImg = self:GetChild("CellBack/Char")
  self._itemNum = self:GetChild("CellBack/Price/Num")
  self._itemImg = self:GetChild("CellBack/Price/Image")
  self._lock = self:GetChild("CellBack/Lock")
  self._itemPanel = self:GetChild("CellBack/Price")
  self._lockTxt = self:GetChild("CellBack/Price/Text2")
  self._charRank = self:GetChild("CellBack/Rank")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  local record = CValentineChocolateItem:GetRecorder(1)
  self._needNum = record.itemNum
  self._needItemId = record.itemId
  ;
  (self._itemNum):SetText(record.itemNum)
  local itemRecorder = CItemTable:GetRecorder(record.itemId)
  if itemRecorder then
    local imageRecord = CImagePathTable:GetRecorder(itemRecorder.icon)
    ;
    (self._itemImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
end

LoverChocolateCharCell.OnDestroy = function(self)
  -- function num : 0_2
end

LoverChocolateCharCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item, RoleUnLockType
  (self._charName):SetText((data.role):GetRoleName())
  local icon = (data.role):GetSkillHeadImageRecord()
  ;
  (self._charImg):SetSprite(icon.assetBundle, icon.assetName)
  local item = (Item.Create)((data.role):GetItemId())
  local imageRecord = item:GetShopPinJiBackGroundImage()
  ;
  (self._charRank):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if data.status == RoleUnLockType.Lock then
    (self._lock):SetActive(true)
    ;
    (self._lockTxt):SetActive(true)
    ;
    (self._clickTxt):SetActive(false)
    ;
    (self._itemPanel):SetActive(true)
  else
    if data.status == RoleUnLockType.UnLock then
      (self._lock):SetActive(false)
      ;
      (self._lockTxt):SetActive(false)
      ;
      (self._clickTxt):SetActive(true)
      ;
      (self._itemPanel):SetActive(false)
    end
  end
end

LoverChocolateCharCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : RoleUnLockType, _ENV, CValentineChatConfig
  if (self._cellData).status == RoleUnLockType.Lock then
    local haveNum = ((NekoData.BehaviorManager).BM_Currency):GetLoveCarefullyPreparedGift()
    if self._needNum <= haveNum then
      local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cunlcokroleicon")
      csend.roleId = ((self._cellData).role):GetId()
      csend:Send()
    else
      do
        do
          ;
          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100453)
          if (self._cellData).status == RoleUnLockType.UnLock then
            local allIds = (CValentineChatConfig:GetAllIds())
            local record, chatDialogId = nil, nil
            for _,id in ipairs(allIds) do
              record = CValentineChatConfig:GetRecorder(id)
              if record.roleid == ((self._cellData).role):GetId() then
                chatDialogId = id
                break
              end
            end
            do
              if not chatDialogId then
                LogErrorFormat("LoverChocolateCharCell", "roleid %s dont have config in CValentineChatConfig", ((self._cellData).role):GetId())
                return 
              end
              local dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
              if dialog then
                dialog:SetDialogLibraryId(chatDialogId, false, (dialog.DialogType).Lover)
              end
            end
          end
        end
      end
    end
  end
end

LoverChocolateCharCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5 , upvalues : RoleUnLockType
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  if eventName == "UnlockRoleIdIcon" and ((self._cellData).role):GetId() == arg then
    (self._cellData).status = RoleUnLockType.UnLock
    ;
    (self._lock):SetActive(false)
    ;
    (self._lockTxt):SetActive(false)
    ;
    (self._clickTxt):SetActive(true)
    ;
    (self._itemPanel):SetActive(false)
    self:OnCellClicked()
  end
end

return LoverChocolateCharCell

