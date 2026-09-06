local UIManager = CS.PixelNeko.UI.UIManager
local ItemTable = BeanManager.GetTableByName("item.citemattr")
local PinJiTable = BeanManager.GetTableByName("item.citempinji")
local ImageTable = BeanManager.GetTableByName("ui.cimagepath")
local CardCellTipsDialog = class("CardCellTipsDialog", Dialog)
CardCellTipsDialog.AssetBundleName = "ui/layouts.bag"
CardCellTipsDialog.AssetName = "ItemTips"

function CardCellTipsDialog:Ctor(...)
  CardCellTipsDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function CardCellTipsDialog:OnCreate()
  self._image = self:GetChild("Back/ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("Back/ItemCell/_BackGround/Frame")
  self._select = self:GetChild("Back/ItemCell/_BackGround/Select")
  self._select:SetActive(false)
  self._count = self:GetChild("Back/ItemCell/_Count")
  self._count:SetText("1")
  self._itemName = self:GetChild("Back/ItemName")
  self._itemTips = self:GetChild("Back/Itemtips")
  LuaNotificationCenter.AddObserver(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

function CardCellTipsDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function CardCellTipsDialog:SetData(data, delegate)
  self._data = data
  self._delegate = delegate
  self:Refresh()
end

function CardCellTipsDialog:Refresh()
  local data = self._data
  local item = ItemTable:GetRecorder(data)
  local image = ImageTable:GetRecorder(item.icon) or DataCommon.DefaultImageAsset
  self._image:SetSprite(image.assetBundle, image.assetName)
  local pinji = PinJiTable:GetRecorder(item.pinJi)
  image = ImageTable:GetRecorder(pinji.imageDir) or DataCommon.DefaultImageAsset
  self._frame:SetSprite(image.assetBundle, image.assetName)
  self._itemName:SetText(TextManager.GetText(item.nameTextID))
  self._itemTips:SetText(TextManager.GetText(item.destribeTextID))
end

function CardCellTipsDialog:OnEveryWhereClick(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function CardCellTipsDialog:OnBackBtnClicked()
  self._delegate:SetSelect(false)
  self:Destroy()
end

return CardCellTipsDialog
