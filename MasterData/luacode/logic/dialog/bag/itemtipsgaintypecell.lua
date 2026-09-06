local CItemAccessType = BeanManager.GetTableByName("item.citemaccesstype")
local ItemTipsGainTypeCell = class("ItemTipsGainTypeCell", Dialog)
ItemTipsGainTypeCell.AssetBundleName = "ui/layouts.bag"
ItemTipsGainTypeCell.AssetName = "ItemTipsNewGet1"

function ItemTipsGainTypeCell:Ctor(...)
  ItemTipsGainTypeCell.super.Ctor(self, ...)
end

function ItemTipsGainTypeCell:OnCreate()
  self._title = self:GetChild("Title")
  self._showBtn = self:GetChild("Add")
  self._hideBtn = self:GetChild("Reduce")
  self._showBtn:Subscribe_PointerClickEvent(self.OnShowGainWays, self)
  self._hideBtn:Subscribe_PointerClickEvent(self.OnShowGainWays, self)
end

function ItemTipsGainTypeCell:OnDestroy()
end

function ItemTipsGainTypeCell:RefreshCell(data)
  self._title:SetText(TextManager.GetText(CItemAccessType:GetRecorder(data.type).type))
  local show = self._delegate._dataMap[data.type]
  self._showBtn:SetActive(not show)
  self._hideBtn:SetActive(show)
end

function ItemTipsGainTypeCell:OnShowGainWays()
  self._delegate:ShowGainWays(self._cellData.type)
end

function ItemTipsGainTypeCell:OnEvent(eventName)
  if eventName == "RefreshOperateBtn" then
    local show = self._delegate._dataMap[self._cellData.type]
    self._showBtn:SetActive(not show)
    self._hideBtn:SetActive(show)
  end
end

return ItemTipsGainTypeCell
