local Item = require("logic.manager.experimental.types.item")
local BreakItemCell = class("BreakItemCell", Dialog)
BreakItemCell.AssetBundleName = "ui/layouts.basecharacterinfo"
BreakItemCell.AssetName = "BaseCharacterInfoBreakItemCell"

function BreakItemCell:Ctor(...)
  BreakItemCell.super.Ctor(self, ...)
end

function BreakItemCell:OnCreate()
  self._frame = self:GetChild("_BackGround/Frame")
  self._icon = self:GetChild("_BackGround/Icon")
  self._count = self:GetChild("_Count/Text")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function BreakItemCell:OnDestroy()
end

function BreakItemCell:RefreshCell(data)
  self._item = Item.Create(data.itemId)
  local imageRecord = self._item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = self._item:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local count = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(data.itemId)
  self._item:SetCount(count)
  local str = NumberManager.GetShowNumber(count)
  if data.itemNum then
    if count < data.itemNum then
      str = "<color=#ff0000ff>" .. str .. "</color>"
    end
    str = str .. "/" .. NumberManager.GetShowNumber(data.itemNum)
    self._count:SetText(str)
  else
    str = tostring(0)
    str = "<color=#ff0000ff>" .. str .. "</color>"
    str = str .. "/" .. tostring(1)
    self._count:SetText(str)
  end
end

function BreakItemCell:OnCellClicked(args)
  local data = {}
  data.item = self._item
  local width, height = self:GetRootWindow():GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init(data)
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return BreakItemCell
