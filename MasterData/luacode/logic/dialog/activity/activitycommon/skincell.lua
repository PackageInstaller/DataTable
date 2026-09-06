local SkinCell = class("SkinCell", Dialog)
local Item = require("logic.manager.experimental.types.item")
local CSkinItem = BeanManager.GetTableByName("item.cskinitem")
SkinCell.AssetBundleName = "ui/layouts.activitycommon"
SkinCell.AssetName = "ActivityCommon2ShopFashionCell"

function SkinCell:Ctor(...)
  SkinCell.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function SkinCell:OnCreate()
  self:GetChild("GoBack/GoBtn/_Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2069))
  self._goBtn = self:GetChild("GoBack/GoBtn")
  self._nameTxt = self:GetChild("TextFrame/NameTxt")
  self._timeTxt = self:GetChild("TextFrame/TimeTxt")
  self._itemCell = {}
  self._itemCell = {}
  self._itemCell.cell = self:GetChild("ActivityCommonItem/ItemCell")
  self._itemCell.icon = self:GetChild("ActivityCommonItem/ItemCell/_BackGround/Icon")
  self._itemCell.frame = self:GetChild("ActivityCommonItem/ItemCell/_BackGround/Frame")
  self._itemCell.count = self:GetChild("ActivityCommonItem/ItemCell/_Count")
  self._itemCell.icon:Subscribe_PointerClickEvent(self.OnItemClicked, self)
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
end

function SkinCell:OnDestroy()
end

function SkinCell:RefreshCell(data)
  local item = Item.Create(data.cfg.skinID)
  self._itemCell.item = item
  self._itemCell.icon:SetSprite(item:GetIconAB())
  self._itemCell.frame:SetSprite(item:GetPinJiImageAB())
  self._itemCell.count:SetText(item:GetCount())
  self._nameTxt:SetText(item:GetName())
  self._timeTxt:SetText(TextManager.GetText(data.cfg.openTime))
end

function SkinCell:OnGoBtnClicked()
  local cfg = CSkinItem:GetRecorder(self._itemCell.item:GetID())
  local dlg = DialogManager.CreateSingletonDialog("shop.fashionbuydialog")
  local data = {}
  table.insert(data, {
    itemId = cfg.Skinid
  })
  dlg:SetData(dlg.TargetType.OnlyShow, data)
end

function SkinCell:OnItemClicked()
  local width, height = self._itemCell.cell:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._itemCell.item
    })
    tipsDialog:SetTipsPosition(width, height, self._itemCell.cell:GetLocalPointInUiRootPanel())
  end
end

return SkinCell
