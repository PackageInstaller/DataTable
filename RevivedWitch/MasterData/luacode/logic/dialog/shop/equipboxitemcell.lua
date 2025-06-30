-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/equipboxitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local EquipBoxItemCell = class("EquipBoxItemCell", Dialog)
EquipBoxItemCell.AssetBundleName = "ui/layouts.baseshop"
EquipBoxItemCell.AssetName = "TowerLegendBoxCell"
EquipBoxItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipBoxItemCell
  ((EquipBoxItemCell.super).Ctor)(self, ...)
end

EquipBoxItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._select = self:GetChild("Panel/ItemCell/_BackGround/Select")
  self._count = self:GetChild("Panel/ItemCell/_Count")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  ;
  (self._select):SetActive(false)
  ;
  (self._count):SetActive(false)
end

EquipBoxItemCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

EquipBoxItemCell.RefreshCell = function(self, id)
  -- function num : 0_3 , upvalues : Item
  local item = (Item.Create)(id)
  local imageRecord = item:GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetPinJiImage()
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

EquipBoxItemCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local tipsDialog = nil
  local width, height = (self:GetRootWindow()):GetRectSize()
  tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipspreviewdialog")
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
end

return EquipBoxItemCell

