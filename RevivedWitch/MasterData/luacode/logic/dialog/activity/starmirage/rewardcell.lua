-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirage/rewardcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local Item = require("logic.manager.experimental.types.item")
local RewardCell = class("RewardCell", Dialog)
RewardCell.AssetBundleName = "ui/layouts.mainline"
RewardCell.AssetName = "DungeonSelectItemCell"
RewardCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RewardCell
  ((RewardCell.super).Ctor)(self, ...)
end

RewardCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  ;
  (self._select):SetActive(false)
  self._count = self:GetChild("ItemCell/_Count")
  ;
  (self._count):SetActive(false)
  self._check = self:GetChild("Check")
  ;
  (self._check):SetActive(false)
  self._firstLable = self:GetChild("First")
  self._normalLable = self:GetChild("Normal")
  self._chanceLable = self:GetChild("Chance")
  ;
  (self:GetChild("Limited")):SetActive(false)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

RewardCell.OnDestroy = function(self)
  -- function num : 0_2
end

local RefreshShow = function(self, first, random, normal)
  -- function num : 0_3
  (self._firstLable):SetActive(first)
  ;
  (self._normalLable):SetActive(normal)
  ;
  (self._chanceLable):SetActive(random)
end

RewardCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : Item, RefreshShow
  self._item = (Item.Create)((data.data).id)
  local image = (self._item):GetIcon()
  ;
  (self._image):SetSprite(image.assetBundle, image.assetName)
  image = (self._item):GetPinJiImage()
  ;
  (self._frame):SetSprite(image.assetBundle, image.assetName)
  if data.tag == "First" then
    RefreshShow(self, true, false, false)
  else
    if data.tag == "Random" then
      RefreshShow(self, false, true, false)
    else
      if data.tag == "Normal" then
        RefreshShow(self, false, false, true)
      end
    end
  end
end

RewardCell.OnCellClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local width, height = (self:GetRootWindow()):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

return RewardCell

