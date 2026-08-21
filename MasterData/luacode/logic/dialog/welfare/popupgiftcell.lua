-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/popupgiftcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local PopUpGiftCell = class("PopUpGiftCell", Dialog)
PopUpGiftCell.AssetBundleName = "ui/layouts.welfare"
PopUpGiftCell.AssetName = "PromotionsItem"
PopUpGiftCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : PopUpGiftCell
  ((PopUpGiftCell.super).Ctor)(self, ...)
end

PopUpGiftCell.OnCreate = function(self)
  -- function num : 0_1
  self._back = self:GetChild("ItemCell/_BackGround")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  self._img = self:GetChild("ItemCell/_BackGround/Icon")
  self._num = self:GetChild("ItemCell/_Count")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

PopUpGiftCell.OnDestroy = function(self)
  -- function num : 0_2
end

PopUpGiftCell.RefreshCell = function(self, data)
  -- function num : 0_3
  local imageRecord = data:GetIcon()
  ;
  (self._img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._num):SetText(data:GetCount())
  local pinjiRecord = data:GetPinJiImage()
  ;
  (self._frame):SetSprite(pinjiRecord.assetBundle, pinjiRecord.assetName)
end

PopUpGiftCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local width, height = (self._rootWindow):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._cellData})
    tipsDialog:SetTipsPosition(width, height, (self._rootWindow):GetLocalPointInUiRootPanel())
  end
end

return PopUpGiftCell

