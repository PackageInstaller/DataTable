-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/shoprecommendpagedetailcell2.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local AnimatorStaticFunctions = ((CS.PixelNeko).Lua).AnimatorStaticFunctions
local CFirstRechargeReward = (BeanManager.GetTableByName)("welfare.cfirstrechargereward")
local CRoleItem = (BeanManager.GetTableByName)("item.croleitem")
local Item = require("logic.manager.experimental.types.item")
local ShopRecommendPageDetailCell2 = class("ShopRecommendPageDetailCell2", Dialog)
ShopRecommendPageDetailCell2.AssetBundleName = "ui/layouts.baseshop"
ShopRecommendPageDetailCell2.AssetName = "RecommendShopPage2"
local ItemIdType = {Role = 27, Equip = 299}
ShopRecommendPageDetailCell2.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ShopRecommendPageDetailCell2
  ((ShopRecommendPageDetailCell2.super).Ctor)(self, ...)
end

ShopRecommendPageDetailCell2.OnCreate = function(self)
  -- function num : 0_1
  self._animationPanel = self:GetChild("BackImage")
  self._model = self:GetChild("BackImage/Up/Model")
  ;
  (self._model):Subscribe_PointerClickEvent(self.ModelClick, self)
  self._frame1GetBtn = self:GetChild("BackImage/Frame1/GetBtn")
  self._frame1GetBtnGrey = self:GetChild("BackImage/Frame1/GetBtnGrey")
  self._frame2GetBtn = self:GetChild("BackImage/Frame2/GetBtn")
  self._frame2GetBtnGrey = self:GetChild("BackImage/Frame2/GetBtnGrey")
  self._iBtn = self:GetChild("BackImage/Up/Ibtn")
  self._toActivePageBtn = self:GetChild("BackImage/Up/StopBtn")
  self._itemCells = {}
  self._itemBacks = {}
  self._itemIcons = {}
  self._itemCounts = {}
  for i = 1, 4 do
    do
      -- DECOMPILER ERROR at PC56: Confused about usage of register: R5 in 'UnsetPending'

      (self._itemCells)[i] = self:GetChild("BackImage/Up/Item" .. i .. "/ItemCell/_BackGround")
      -- DECOMPILER ERROR at PC64: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._itemBacks)[i] = self:GetChild("BackImage/Up/Item" .. i .. "/ItemCell/_BackGround/Frame")
      -- DECOMPILER ERROR at PC72: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._itemIcons)[i] = self:GetChild("BackImage/Up/Item" .. i .. "/ItemCell/_BackGround/Icon")
      -- DECOMPILER ERROR at PC80: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._itemCounts)[i] = self:GetChild("BackImage/Up/Item" .. i .. "/ItemCell/_Count")
      ;
      ((self._itemCells)[i]):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnCellClick(i)
  end
, self)
    end
  end
  ;
  (self._iBtn):Subscribe_PointerClickEvent(self.IButtonClick, self)
  ;
  (self._toActivePageBtn):Subscribe_PointerClickEvent(self.ToActivePageButtonClick, self)
end

ShopRecommendPageDetailCell2.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

ShopRecommendPageDetailCell2.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : CFirstRechargeReward, _ENV, Item
  local itemsId = (CFirstRechargeReward:GetRecorder(1)).itemID
  local itemscount = (CFirstRechargeReward:GetRecorder(1)).ItemNum
  self._items = {}
  for _,id in ipairs(itemsId) do
    local itemTemp = (Item.Create)(id)
    ;
    (table.insert)(self._items, itemTemp)
  end
  for i,item in ipairs(self._items) do
    local imageRecord = item:GetPinJiImage()
    ;
    ((self._itemBacks)[i]):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = item:GetIcon()
    ;
    ((self._itemIcons)[i]):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    ((self._itemCounts)[i]):SetText((NumberManager.GetShowNumber)(itemscount[i]))
  end
end

ShopRecommendPageDetailCell2.ModelClick = function(self)
  -- function num : 0_4 , upvalues : AnimatorStaticFunctions
  local animator = (AnimatorStaticFunctions.Get)((self._model)._uiObject)
  animator:SetTrigger("onClick")
end

ShopRecommendPageDetailCell2.IButtonClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("welfare.firtstrechargetip")
end

ShopRecommendPageDetailCell2.ToActivePageButtonClick = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("welfare.fitstrechargedialog")
  if dialog then
    dialog:Init()
  end
  ;
  (DialogManager.DestroySingletonDialog)("shop.shopmaindialog")
end

ShopRecommendPageDetailCell2.OnCellClick = function(self, index)
  -- function num : 0_7 , upvalues : ItemIdType, CRoleItem, _ENV
  local item = (self._items)[index]
  local dialog = nil
  if item:GetItemTypeId() == ItemIdType.Role then
    local roleID = (CRoleItem:GetRecorder(item:GetID())).roleid
    dialog = (DialogManager.CreateSingletonDialog)("mainline.bossrush.checkotherroleinfodialog")
    if dialog then
      dialog:Init({
roleIdList = {roleID}
, 
cfgIdList = {1}
, index = 1}, (dialog.ShowType).BaseLevelInfo)
    end
  else
    do
      if item:GetItemTypeId() == ItemIdType.Equip then
        dialog = (DialogManager.CreateSingletonDialog)("equip.equiptipspreviewdialog")
        if dialog then
          dialog:Init(item:GetID())
          dialog:SetTipsParmFunc(function()
    -- function num : 0_7_0 , upvalues : self, index
    local width, height = ((self._itemBacks)[index]):GetRectSize()
    local pos = ((self._itemBacks)[index]):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
        end
      else
        dialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
        if dialog then
          dialog:Init({item = item})
        end
      end
    end
  end
end

ShopRecommendPageDetailCell2.PlayShowAnimation = function(self)
  -- function num : 0_8
  (self._animationPanel):PlayAnimation("RecommendShopPage2")
end

return ShopRecommendPageDetailCell2

