-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/order/orderdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local CSApplication = (CS.UnityEngine).Application
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local CVarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
local OrderDialog = class("OrderDialog", Dialog)
OrderDialog.AssetBundleName = "ui/layouts.guide"
OrderDialog.AssetName = "OrderGuide"
OrderDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : OrderDialog
  ((OrderDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._delegate = nil
  self._itemId = nil
  self._itemNum = nil
  self._item = nil
end

OrderDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, Item
  self._itemCell = self:GetChild("BackImage/ItemCell")
  self._itemIcon = self:GetChild("BackImage/ItemCell/_BackGround/Icon")
  self._itemFrame = self:GetChild("BackImage/ItemCell/_BackGround/Frame")
  self._itemCount = self:GetChild("BackImage/ItemCell/_Count")
  self._btn = self:GetChild("BackImage/Btn")
  self._closeBtn = self:GetChild("BackImage/CloseBtn")
  ;
  (self._itemCell):Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  ;
  (self._btn):Subscribe_PointerClickEvent(self.OnBtnClicked, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  local bookActivity = ((NekoData.BehaviorManager).BM_Game):GetBookActivity()
  self._itemId = bookActivity.itemId
  self._itemNum = bookActivity.itemNum
  self._item = (Item.Create)(self._itemId)
  ;
  (self._itemCount):SetText((NumberManager.GetShowNumber)(self._itemNum))
  ;
  (self._itemIcon):SetSprite(((self._item):GetIcon()).assetBundle, ((self._item):GetIcon()).assetName)
  ;
  (self._itemFrame):SetSprite(((self._item):GetPinJiImage()).assetBundle, ((self._item):GetPinJiImage()).assetName)
end

OrderDialog.OnDestroy = function(self)
  -- function num : 0_2
end

OrderDialog.OnItemCellClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if dialog then
    dialog:Init({item = self._item})
  end
end

OrderDialog.OnBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV, CVarConfig, ItemTypeEnum
  (self._delegate):OnOrderGainClick()
  ;
  ((((CS.PixelNeko).Tools).ShareHelper).OpenURL)((CVarConfig:GetRecorder(60)).Value)
  ;
  ((LuaNetManager.CreateProtocol)("protocol.activity.cbookactivity")):Send()
  ;
  ((NekoData.DataManager).DM_ItemAccountShow):AddShowDialogData({tag = (DataCommon.ShowDialogType).ItemAccount, 
data = {
items = {
{gain = 0, itemtype = ItemTypeEnum.BASEITEM, number = self._itemNum, id = self._itemId}
}
}
})
  self:OnBackBtnClicked()
end

OrderDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("order.orderdialog")
end

OrderDialog.SetDelegate = function(self, delegate)
  -- function num : 0_6
  self._delegate = delegate
end

return OrderDialog

