-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/monthcarddailyawardcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local MonthCardDailyAwardCell = class("MonthCardDailyAwardCell", Dialog)
MonthCardDailyAwardCell.AssetBundleName = "ui/layouts.baseshop"
MonthCardDailyAwardCell.AssetName = "MonthCardItemAccountCell"
MonthCardDailyAwardCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MonthCardDailyAwardCell
  ((MonthCardDailyAwardCell.super).Ctor)(self, ...)
end

MonthCardDailyAwardCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  self._count = self:GetChild("ItemCell/_Count")
  self._name = self:GetChild("Text")
  ;
  (self._select):SetActive(false)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

MonthCardDailyAwardCell.OnDestroy = function(self)
  -- function num : 0_2
end

MonthCardDailyAwardCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item
  self._itemid = data.itemid
  local item = (Item.Create)(data.itemid)
  local imageRecord = item:GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetPinJiImage()
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if data.itemnum > 1 then
    (self._count):SetActive(true)
    ;
    (self._count):SetNumber(data.itemnum)
  else
    ;
    (self._count):SetActive(false)
  end
  ;
  (self._name):SetActive(true)
  ;
  (self._name):SetText(item:GetName())
end

MonthCardDailyAwardCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV, Item
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (Item.Create)(self._itemid)})
    local width, height = (self:GetRootWindow()):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

return MonthCardDailyAwardCell

