-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/cardcelltipsdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local ItemTable = (BeanManager.GetTableByName)("item.citemattr")
local PinJiTable = (BeanManager.GetTableByName)("item.citempinji")
local ImageTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CardCellTipsDialog = class("CardCellTipsDialog", Dialog)
CardCellTipsDialog.AssetBundleName = "ui/layouts.bag"
CardCellTipsDialog.AssetName = "ItemTips"
CardCellTipsDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CardCellTipsDialog
  ((CardCellTipsDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

CardCellTipsDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._image = self:GetChild("Back/ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("Back/ItemCell/_BackGround/Frame")
  self._select = self:GetChild("Back/ItemCell/_BackGround/Select")
  ;
  (self._select):SetActive(false)
  self._count = self:GetChild("Back/ItemCell/_Count")
  ;
  (self._count):SetText("1")
  self._itemName = self:GetChild("Back/ItemName")
  self._itemTips = self:GetChild("Back/Itemtips")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

CardCellTipsDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

CardCellTipsDialog.SetData = function(self, data, delegate)
  -- function num : 0_3
  self._data = data
  self._delegate = delegate
  self:Refresh()
end

CardCellTipsDialog.Refresh = function(self)
  -- function num : 0_4 , upvalues : ItemTable, ImageTable, _ENV, PinJiTable
  local data = self._data
  local item = ItemTable:GetRecorder(data)
  if not ImageTable:GetRecorder(item.icon) then
    local image = DataCommon.DefaultImageAsset
  end
  ;
  (self._image):SetSprite(image.assetBundle, image.assetName)
  local pinji = PinJiTable:GetRecorder(item.pinJi)
  if not ImageTable:GetRecorder(pinji.imageDir) then
    image = DataCommon.DefaultImageAsset
  end
  ;
  (self._frame):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._itemName):SetText((TextManager.GetText)(item.nameTextID))
  ;
  (self._itemTips):SetText((TextManager.GetText)(item.destribeTextID))
end

CardCellTipsDialog.OnEveryWhereClick = function(self, args)
  -- function num : 0_5 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

CardCellTipsDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6
  (self._delegate):SetSelect(false)
  self:Destroy()
end

return CardCellTipsDialog

