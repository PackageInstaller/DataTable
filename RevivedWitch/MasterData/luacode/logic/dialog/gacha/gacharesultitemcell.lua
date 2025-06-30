-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/gacharesultitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local AnimationHelper = ((CS.PixelNeko).Animation).AnimationHelper
local GachaResultItemCell = class("GachaResultItemCell", Dialog)
GachaResultItemCell.AssetBundleName = "ui/layouts.gacha"
GachaResultItemCell.AssetName = "GachaResultEquipCell"
GachaResultItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GachaResultItemCell
  ((GachaResultItemCell.super).Ctor)(self, ...)
end

GachaResultItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._equipCell = self:GetChild("Equip")
  self._equipCell_frame = self:GetChild("Equip/Frame/Frame")
  self._equipCell_icon = self:GetChild("Equip/Frame/Icon")
  self._equipCell_strengthenLvNum = self:GetChild("Equip/Frame/Level/Num")
  self._equipCell_specialFMImage = self:GetChild("Equip/Frame/FuMo")
  self._equipCell_pinjiStar = self:GetChild("Equip/Frame/BreakPoint")
  ;
  (self:GetChild("Equip/Frame/Level/NumMax")):SetActive(false)
  ;
  (self:GetChild("Equip/Frame/Select")):SetActive(false)
  ;
  (self:GetChild("Equip/Frame/LockBtn")):SetActive(false)
  self._uniqueEquipCell = self:GetChild("ExclusiveEquip")
  self._uniqueEquipCell_frame = self:GetChild("ExclusiveEquip/Frame/Frame")
  self._uniqueEquipCell_icon = self:GetChild("ExclusiveEquip/Frame/Icon")
  ;
  (self:GetChild("ExclusiveEquip/Frame/Select")):SetActive(false)
  ;
  (self:GetChild("ExclusiveEquip/Frame/Level")):SetActive(false)
  self._itemCell = self:GetChild("Item")
  self._itemCell_frame = self:GetChild("Item/ItemCell/_BackGround/Frame")
  self._itemCell_icon = self:GetChild("Item/ItemCell/_BackGround/Icon")
  self._itemCell_count = self:GetChild("Item/ItemCell/_Count")
  ;
  (self:GetChild("Item/ItemCell/_BackGround/Select")):SetActive(false)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

GachaResultItemCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

GachaResultItemCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : AnimationHelper
  self._type = data.type
  self._item = data.item
  self._num = data.num
  if self._type == "UniqueEquip" then
    (self._uniqueEquipCell):SetActive(true)
    ;
    (self._equipCell):SetActive(false)
    ;
    (self._itemCell):SetActive(false)
    ;
    (AnimationHelper.SetAnimatorInteger2)((self._rootWindow):GetUIObject(), "par", 0)
    local imageRecord = (self._item):GetIcon()
    ;
    (self._uniqueEquipCell_icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = (self._item):GetPinJiImage()
    ;
    (self._uniqueEquipCell_frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    do
      if self._type == "Equip" then
        (self._uniqueEquipCell):SetActive(false)
        ;
        (self._equipCell):SetActive(true)
        ;
        (self._itemCell):SetActive(false)
        local imageRecord = (self._item):GetPinJiImage()
        ;
        (self._equipCell_frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        imageRecord = (self._item):GetIcon()
        ;
        (self._equipCell_icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        ;
        (self._equipCell_strengthenLvNum):SetText((self._item):GetStrengthenLevel())
        if (self._item):GetFinalRandomEntry() then
          (self._equipCell_specialFMImage):SetActive(true)
          ;
          (AnimationHelper.SetAnimatorInteger2)((self._rootWindow):GetUIObject(), "par", 1)
        else
          ;
          (self._equipCell_specialFMImage):SetActive(false)
          ;
          (AnimationHelper.SetAnimatorInteger2)((self._rootWindow):GetUIObject(), "par", 0)
        end
        ;
        (self._equipCell_pinjiStar):SetText((self._item):GetEquipStarStr())
      else
        do
          if self._type == "Item" then
            (self._uniqueEquipCell):SetActive(false)
            ;
            (self._equipCell):SetActive(false)
            ;
            (self._itemCell):SetActive(true)
            ;
            (AnimationHelper.SetAnimatorInteger2)((self._rootWindow):GetUIObject(), "par", 0)
            local imageRecord = (self._item):GetIcon()
            ;
            (self._itemCell_icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
            imageRecord = (self._item):GetPinJiImage()
            ;
            (self._itemCell_frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
            ;
            (self._itemCell_count):SetNumber(self._num)
          end
        end
      end
    end
  end
end

GachaResultItemCell.OnCellClicked = function(self, args)
  -- function num : 0_4 , upvalues : _ENV
  local tipsDialog = nil
  local width, height = (self:GetRootWindow()):GetRectSize()
  if self._type == "Equip" then
    if (self._item):IsGained() then
      tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipsdialog")
      if tipsDialog then
        tipsDialog:Init((self._item):GetKey())
        tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_4_0 , upvalues : self
    local width, height = (self:GetRootWindow()):GetRectSize()
    local pos = (self:GetRootWindow()):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
      end
    else
      tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipspreviewdialog")
      if tipsDialog then
        tipsDialog:Init((self._item):GetID())
        tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_4_1 , upvalues : self
    local width, height = (self:GetRootWindow()):GetRectSize()
    local pos = (self:GetRootWindow()):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
      end
    end
  else
    tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init(self._cellData)
      tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
    end
  end
end

return GachaResultItemCell

