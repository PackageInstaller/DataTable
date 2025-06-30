-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/equip/gachaequiprateitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local CItemNum = (BeanManager.GetTableByName)("item.citemnum")
local GachaEquipRateItemCell = class("GachaEquipRateItemCell", Dialog)
GachaEquipRateItemCell.AssetBundleName = "ui/layouts.baseshop"
GachaEquipRateItemCell.AssetName = "TowerLegendBoxCell"
GachaEquipRateItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GachaEquipRateItemCell
  ((GachaEquipRateItemCell.super).Ctor)(self, ...)
end

GachaEquipRateItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._select = self:GetChild("Panel/ItemCell/_BackGround/Select")
  self._count = self:GetChild("Panel/ItemCell/_Count")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  ;
  (self._select):SetActive(false)
end

GachaEquipRateItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

GachaEquipRateItemCell.RefreshCell = function(self, id)
  -- function num : 0_3 , upvalues : Item, CItemNum
  local item = (Item.Create)(id)
  self._item = item
  local imageRecord = item:GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetPinJiImage()
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local recorder = CItemNum:GetRecorder(id)
  if recorder then
    (self._count):SetActive(true)
    ;
    (self._count):SetText(recorder.Num)
  else
    ;
    (self._count):SetActive(false)
  end
end

GachaEquipRateItemCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : ItemTypeEnum, _ENV
  local itemType = (self._item):GetItemType()
  if itemType == ItemTypeEnum.EQUIP then
    local width, height = (self:GetRootWindow()):GetRectSize()
    local tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipspreviewdialog")
    if tipsDialog then
      tipsDialog:Init(self._cellData, (self._delegate)._showEquipMaxLevel)
      tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_4_0 , upvalues : self
    local width, height = (self:GetRootWindow()):GetRectSize()
    local pos = (self:GetRootWindow()):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
    end
  else
    do
      tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
      if tipsDialog then
        tipsDialog:Init({item = self._item})
        tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
      end
    end
  end
end

return GachaEquipRateItemCell

