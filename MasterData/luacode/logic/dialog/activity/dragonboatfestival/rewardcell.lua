-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/dragonboatfestival/rewardcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local ReawrdCell = class("ReawrdCell", Dialog)
ReawrdCell.AssetBundleName = "ui/layouts.activityspringouting"
ReawrdCell.AssetName = "ActivitySpringOutingCellItem"
ReawrdCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ReawrdCell
  ((ReawrdCell.super).Ctor)(self, ...)
  self._item = nil
end

ReawrdCell.OnCreate = function(self)
  -- function num : 0_1
  self._haveGetText = self:GetChild("Panel/GetBack/Text")
  self._haveGetBack = self:GetChild("Panel/GetBack")
  self._itemCell = self:GetChild("Panel/ItemCell")
  self._itemIcon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._itemFrame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._itemNum = self:GetChild("Panel/ItemCell/_Count")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self:SetStaticRes()
end

ReawrdCell.SetStaticRes = function(self)
  -- function num : 0_2 , upvalues : _ENV, CStringRes
  (self._haveGetText):SetText((TextManager.GetText)((CStringRes:GetRecorder(1820)).msgTextID))
end

ReawrdCell.OnDestroy = function(self)
  -- function num : 0_3
end

ReawrdCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : Item, _ENV
  self._data = data
  self._item = (Item.Create)((self._data).itemId)
  ;
  (self._itemNum):SetText((NumberManager.GetShowNumber)((self._data).itemNum))
  local imageRecord = (self._item):GetPinJiImage()
  ;
  (self._itemFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (self._item):GetIcon()
  ;
  (self._itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._haveGetBack):SetActive((self._data).isGet)
end

ReawrdCell.OnCellClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local width, height = (self._itemCell):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    tipsDialog:SetTipsPosition(width, height, (self._itemCell):GetLocalPointInUiRootPanel())
  end
end

return ReawrdCell

