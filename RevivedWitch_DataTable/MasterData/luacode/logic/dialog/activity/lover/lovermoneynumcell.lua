-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/lover/lovermoneynumcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local LoverMoneyNumCell = class("LoverMoneyNumCell", Dialog)
LoverMoneyNumCell.AssetBundleName = "ui/layouts.activityvalentines"
LoverMoneyNumCell.AssetName = "ActivityValentinesNumCell"
LoverMoneyNumCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LoverMoneyNumCell
  ((LoverMoneyNumCell.super).Ctor)(self, ...)
  self._item = nil
end

LoverMoneyNumCell.OnCreate = function(self)
  -- function num : 0_1
  self._moneyBoard = self:GetChild("Back")
  self._addBtn = self:GetChild("Add")
  self._moneyIcon = self:GetChild("Icon")
  self._moneyText = self:GetChild("Text")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnMoneyBoardClick, self)
end

LoverMoneyNumCell.OnDestroy = function(self)
  -- function num : 0_2
end

LoverMoneyNumCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item, _ENV
  self._item = (Item.Create)(data)
  local image = (self._item):GetIcon()
  ;
  (self._moneyIcon):SetSprite(image.assetBundle, image.assetName)
  if ((NekoData.BehaviorManager).BM_Currency):IsCurrency(data) then
    (self._moneyText):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(data))
  else
    ;
    (self._moneyText):SetNumber(((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(data))
  end
  ;
  (self._addBtn):SetActive(false)
end

LoverMoneyNumCell.OnMoneyBoardClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    local width, height = (self._moneyBoard):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self._moneyBoard):GetLocalPointInUiRootPanel())
  end
end

return LoverMoneyNumCell

