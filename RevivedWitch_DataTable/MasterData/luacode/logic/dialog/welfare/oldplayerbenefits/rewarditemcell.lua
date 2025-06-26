-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/oldplayerbenefits/rewarditemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSkinItem = (BeanManager.GetTableByName)("item.cskinitem")
local CRoleItemTable = (BeanManager.GetTableByName)("item.croleitem")
local Item = require("logic.manager.experimental.types.item")
local RewardItemCell = class("RewardItemCell", Dialog)
RewardItemCell.AssetBundleName = "ui/layouts.welfare"
RewardItemCell.AssetName = "WelfareFeedbackCelllItem"
RewardItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RewardItemCell
  ((RewardItemCell.super).Ctor)(self, ...)
end

RewardItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  self._count = self:GetChild("ItemCell/_Count")
  ;
  (self._select):SetActive(false)
  self._gray = self:GetChild("Gray")
  self._lock = self:GetChild("Gray/Image")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

RewardItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

RewardItemCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item
  (self._lock):SetActive(data.isLock)
  self._item = (Item.Create)(data.itemID)
  local imageRecord = (self._item):GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (self._item):GetPinJiImage()
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._count):SetNumber(data.itemCount)
  if not data.isReceived then
    (self._gray):SetActive(data.isLock)
  end
end

RewardItemCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : CSkinItem, _ENV, CRoleItemTable
  if (self._item):GetItemTypeId() == 91 then
    local cfg = CSkinItem:GetRecorder((self._item):GetID())
    if not cfg then
      LogErrorFormat("MonthSignCell", "record with id %s is not exist in cskinitem", (self._item):GetID())
    end
    local dlg = (DialogManager.CreateSingletonDialog)("shop.fashionbuydialog")
    local data = {}
    ;
    (table.insert)(data, {itemId = cfg.Skinid})
    dlg:SetData((dlg.TargetType).OnlyShow, data)
  else
    do
      local cfg = CRoleItemTable:GetRecorder((self._item):GetID())
      if cfg then
        local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
        local roleInfoDialog = (DialogManager.CreateSingletonDialog)("mainline.bossrush.checkotherroleinfodialog")
        local roleIDList = {cfg.roleid}
        local cfgIDList = {4}
        roleInfoDialog:Init({roleIdList = roleIDList, cfgIdList = cfgIDList, index = 1}, (CheckOtherRoleInfoDialog.ShowType).BaseLevelInfo)
      else
        do
          local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
          if tipsDialog then
            tipsDialog:Init({item = self._item})
            local width, height = (self:GetRootWindow()):GetRectSize()
            tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
          end
        end
      end
    end
  end
end

return RewardItemCell

