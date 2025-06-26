-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/anniversary/currencycell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CurrencyCell = class("CurrencyCell", Dialog)
CurrencyCell.AssetBundleName = "ui/layouts.baseshop"
CurrencyCell.AssetName = "ShopTopGroupCell"
CurrencyCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CurrencyCell
  ((CurrencyCell.super).Ctor)(self, ...)
end

CurrencyCell.OnCreate = function(self)
  -- function num : 0_1
  self._cell = self:GetChild("Num0")
  self._addBtn = self:GetChild("Num0/Add")
  self._icon = self:GetChild("Num0/Icon")
  self._text = self:GetChild("Num0/Text")
  ;
  (self._cell):Subscribe_PointerClickEvent(self.OnCellClick, self)
  ;
  (self._addBtn):Subscribe_PointerClickEvent(self.OnAddBtnClick, self)
end

CurrencyCell.OnDestroy = function(self)
  -- function num : 0_2
end

CurrencyCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, Item
  local haveAddWays = ((NekoData.BehaviorManager).BM_Currency):HaveAddWays(data)
  ;
  (self._addBtn):SetActive(haveAddWays)
  self._item = (Item.Create)(data)
  local imageRecord = (self._item):GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local currencyNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(data)
  if data == DataCommon.SpiritID then
    local limitNum = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).strengthLimit
    ;
    (self._text):SetText((NumberManager.GetShowNumber)(currencyNum) .. "/" .. (NumberManager.GetShowNumber)(limitNum))
  else
    do
      ;
      (self._text):SetText((NumberManager.GetShowNumber)(currencyNum))
    end
  end
end

CurrencyCell.OnCellClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local width, height = (self._cell):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    tipsDialog:SetTipsPosition(width, height, (self._cell):GetLocalPointInUiRootPanel())
  end
end

CurrencyCell.OnAddBtnClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Currency):AddCurrencyById(self._cellData)
end

return CurrencyCell

