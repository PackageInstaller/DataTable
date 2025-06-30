-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/towerv2/towerv2itemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local TowerV2ItemCell = class("TowerV2ItemCell", Dialog)
TowerV2ItemCell.AssetBundleName = "ui/layouts.stair"
TowerV2ItemCell.AssetName = "StairMainItemCell"
TowerV2ItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerV2ItemCell
  ((TowerV2ItemCell.super).Ctor)(self, ...)
end

TowerV2ItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._select = self:GetChild("Panel/ItemCell/_BackGround/Select")
  self._count = self:GetChild("Panel/ItemCell/_Count")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  ;
  (self:GetRootWindow()):SetUserData(self)
  ;
  (self._select):SetActive(false)
end

TowerV2ItemCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

TowerV2ItemCell.RefreshCell = function(self, data)
  -- function num : 0_3
  local imageRecord = (data.item):GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (data.item):GetPinJiImage()
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if data.num then
    (self._count):SetNumber(data.num)
  else
    ;
    (self._count):SetNumber((data.item):GetCount())
  end
end

TowerV2ItemCell.OnCellClicked = function(self, args)
  -- function num : 0_4 , upvalues : ItemTypeEnum, _ENV
  (self._select):SetActive(true)
  local tipsDialog = nil
  local width, height = (self:GetRootWindow()):GetRectSize()
  if ((self._cellData).item):GetItemType() == ItemTypeEnum.EQUIP then
    if ((self._cellData).item):IsGained() then
      tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipsdialog")
      if tipsDialog then
        tipsDialog:Init(((self._cellData).item):GetKey())
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
        tipsDialog:Init(((self._cellData).item):GetID())
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

return TowerV2ItemCell

