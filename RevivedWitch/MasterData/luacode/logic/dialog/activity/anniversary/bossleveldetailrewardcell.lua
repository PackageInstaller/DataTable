-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/anniversary/bossleveldetailrewardcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local Item = require("logic.manager.experimental.types.item")
local BossLevelDetailRewardCell = class("BossLevelDetailRewardCell", Dialog)
BossLevelDetailRewardCell.AssetBundleName = "ui/layouts.activity1yearanniversary"
BossLevelDetailRewardCell.AssetName = "Activity1YearAnniversaryBossDetailItemCell"
BossLevelDetailRewardCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BossLevelDetailRewardCell
  ((BossLevelDetailRewardCell.super).Ctor)(self, ...)
end

BossLevelDetailRewardCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  ;
  (self._select):SetActive(false)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

BossLevelDetailRewardCell.OnDestroy = function(self)
  -- function num : 0_2
end

BossLevelDetailRewardCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item
  self._item = (Item.Create)((data.data).id)
  local image = (self._item):GetIcon()
  ;
  (self._image):SetSprite(image.assetBundle, image.assetName)
  image = (self._item):GetPinJiImage()
  ;
  (self._frame):SetSprite(image.assetBundle, image.assetName)
end

BossLevelDetailRewardCell.OnCellClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local width, height = (self:GetRootWindow()):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

return BossLevelDetailRewardCell

