-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/moneycell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local MoneyCell = class("MoneyCell", Dialog)
MoneyCell.AssetBundleName = "ui/layouts.gacha"
MoneyCell.AssetName = "GachaMainMoneyCell"
MoneyCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MoneyCell
  ((MoneyCell.super).Ctor)(self, ...)
  self._item = nil
end

MoneyCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._moneyBoard = self:GetChild("Money")
  self._addBtn = self:GetChild("Money/Add")
  self._moneyIcon = self:GetChild("Money/Icon")
  self._moneyText = self:GetChild("Money/Text")
  ;
  (self._addBtn):Subscribe_PointerClickEvent(self.OnAddBtnClick, self)
  ;
  (self._moneyBoard):Subscribe_PointerClickEvent(self.OnMoneyBoardClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OpenShop, Common.n_SOpenShop, nil)
end

MoneyCell.OnDestroy = function(self)
  -- function num : 0_2
end

MoneyCell.RefreshCell = function(self, data)
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
  (self._addBtn):SetActive(data ~= 30077 and data ~= 30076)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

MoneyCell.OnAddBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("base.basemainui")
  if dialog then
    dialog:OnShopClick()
    self._isClicked = true
  else
    LogError("MoneyCell", "Cannot find basemainui.")
  end
end

MoneyCell.OpenShop = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  do
    if self._isClicked then
      local dialog = notification.userInfo
      if dialog then
        if (self._item):GetID() == DataCommon.DiamodID then
          dialog:OnGroupBtnClicked(4)
        else
          if (self._item):GetID() == DataCommon.SoulDropID then
            dialog:OnGroupBtnClicked(19)
          else
            if (self._item):GetID() == DataCommon.WhiteCoin then
              dialog:OnGroupBtnClicked(7)
            else
              if (self._item):GetID() == DataCommon.GoldCoin then
                dialog:OnGroupBtnClicked(8)
              end
            end
          end
        end
      else
        LogError("MoneyCell", "Cannot find shopmaindialog.")
      end
    end
    self._isClicked = false
  end
end

MoneyCell.OnMoneyBoardClick = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    local width, height = (self._moneyBoard):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self._moneyBoard):GetLocalPointInUiRootPanel())
  end
end

return MoneyCell

