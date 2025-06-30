-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/halloween/halloweenticketcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CItemPinJiTable = (BeanManager.GetTableByName)("item.citempinji")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local HalloweenTicketCell = class("HalloweenTicketCell", Dialog)
HalloweenTicketCell.AssetBundleName = "ui/layouts.activityhalloween"
HalloweenTicketCell.AssetName = "ActivityHalloweenTicketCellItem"
HalloweenTicketCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : HalloweenTicketCell
  ((HalloweenTicketCell.super).Ctor)(self, ...)
end

HalloweenTicketCell.OnCreate = function(self)
  -- function num : 0_1
  self._num1 = self:GetChild("Num1")
  self._num2 = self:GetChild("Num2")
  self._itemCell = self:GetChild("Panel/ItemCell")
  self._itemIcon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._itemFrame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._itemCount = self:GetChild("Panel/ItemCell/_Count")
  ;
  (self._itemCell):Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
end

HalloweenTicketCell.RefreshCell = function(self, data)
  -- function num : 0_2 , upvalues : _ENV, CStringRes, CItemPinJiTable, CImagePathTable
  self._data = data.data
  self._index = data.index
  self._item = (self._data).item
  self._itemNum = (self._data).itemNum
  self._itemNowNum = (self._data).itemNowNum
  self._itemTotalNum = (self._data).itemTotalNum
  if self._itemNowNum == 0 then
    (self._num1):SetText((TextManager.GetText)((CStringRes:GetRecorder(1631)).msgTextID, 0))
  else
    ;
    (self._num1):SetText(self._itemNowNum)
  end
  ;
  (self._num2):SetText(self._itemTotalNum)
  ;
  (self._itemCount):SetText(self._itemNum)
  ;
  (self._itemIcon):SetSprite(((self._item):GetIcon()).assetBundle, ((self._item):GetIcon()).assetName)
  if self._index == 1 then
    local maxPinJiRecord = CItemPinJiTable:GetRecorder(6)
    if not CImagePathTable:GetRecorder(maxPinJiRecord.imageDir) then
      local maxPinjiImage = DataCommon.DefaultImageAsset
    end
    ;
    (self._itemFrame):SetSprite(maxPinjiImage.assetBundle, maxPinjiImage.assetName)
  else
    do
      ;
      (self._itemFrame):SetSprite(((self._item):GetPinJiImage()).assetBundle, ((self._item):GetPinJiImage()).assetName)
    end
  end
end

HalloweenTicketCell.OnItemCellClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local width, height = (self._itemCell):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    tipsDialog:SetTipsPosition(width, height, (self._itemCell):GetLocalPointInUiRootPanel())
  end
end

return HalloweenTicketCell

