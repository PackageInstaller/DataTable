-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/growgiftitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local GrowGiftItemCell = class("GrowGiftItemCell", Dialog)
GrowGiftItemCell.AssetBundleName = "ui/layouts.welfare"
GrowGiftItemCell.AssetName = "GrowGiftCellItem"
GrowGiftItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GrowGiftItemCell
  ((GrowGiftItemCell.super).Ctor)(self, ...)
end

GrowGiftItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._panel = self:GetChild("Panel")
  self._icon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._select = self:GetChild("Panel/ItemCell/_BackGround/Select")
  self._count = self:GetChild("Panel/ItemCell/_Count")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

GrowGiftItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

GrowGiftItemCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item, _ENV
  self._item = (Item.Create)(data.id)
  local imageRecord = (self._item):GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (self._item):GetPinJiImage()
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local status = ((self._delegate)._cellData).status
  ;
  (self._select):SetActive(status == (((self._delegate)._delegate).cellStatus).CanNotReceive or status == (((self._delegate)._delegate).cellStatus).Available)
  ;
  (self._count):SetText((NumberManager.GetShowNumber)(data.num))
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

GrowGiftItemCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    local width, height = (self:GetRootWindow()):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

return GrowGiftItemCell

