-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/aprilfoolsday/aprilfoolsmoneynumcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local AprilFoolsMoneyNumCell = class("AprilFoolsMoneyNumCell", Dialog)
AprilFoolsMoneyNumCell.AssetBundleName = "ui/layouts.activityaprilfools"
AprilFoolsMoneyNumCell.AssetName = "MoneyCell"
AprilFoolsMoneyNumCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AprilFoolsMoneyNumCell
  ((AprilFoolsMoneyNumCell.super).Ctor)(self, ...)
  self._item = nil
end

AprilFoolsMoneyNumCell.OnCreate = function(self)
  -- function num : 0_1
  self._addBtn = self:GetChild("Add")
  self._moneyIcon = self:GetChild("Icon")
  self._moneyText = self:GetChild("Text")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnMoneyBoardClick, self)
end

AprilFoolsMoneyNumCell.OnDestroy = function(self)
  -- function num : 0_2
end

AprilFoolsMoneyNumCell.RefreshCell = function(self, data)
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

AprilFoolsMoneyNumCell.OnMoneyBoardClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    local width, height = (self._moneyIcon):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self._moneyIcon):GetLocalPointInUiRootPanel())
  end
end

return AprilFoolsMoneyNumCell

