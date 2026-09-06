local CRoleItem = BeanManager.GetTableByName("item.croleitem")
local CSkinItem = BeanManager.GetTableByName("item.cskinitem")
local PopUpGift7DayItemCell = class("PopUpGift7DayItemCell", Dialog)
PopUpGift7DayItemCell.AssetBundleName = "ui/layouts.welfare"
PopUpGift7DayItemCell.AssetName = "Promotions7DaysItem"

function PopUpGift7DayItemCell:Ctor(...)
  PopUpGift7DayItemCell.super.Ctor(self, ...)
end

function PopUpGift7DayItemCell:OnCreate()
  self._frame = self:GetChild("Item/ItemCell/_BackGround/Frame")
  self._img = self:GetChild("Item/ItemCell/_BackGround/Icon")
  self._num = self:GetChild("Item/ItemCell/_Count")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function PopUpGift7DayItemCell:OnDestroy()
end

function PopUpGift7DayItemCell:RefreshCell(data)
  local imageRecord = data.item:GetIcon()
  self._img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._num:SetText(data.num)
  local pinjiRecord = data.item:GetPinJiImage()
  self._frame:SetSprite(pinjiRecord.assetBundle, pinjiRecord.assetName)
end

function PopUpGift7DayItemCell:OnCellClicked()
  local itemType = self._cellData.item:GetItemTypeId()
  local itemId = self._cellData.item:GetID()
  if itemType == 27 then
    local cfg = CRoleItem:GetRecorder(itemId)
    local dlg = DialogManager.CreateSingletonDialog("mainline.bossrush.checkotherroleinfodialog")
    dlg:Init({
      roleIdList = {
        cfg.roleid
      },
      cfgIdList = {2},
      index = 1
    }, 3)
  elseif itemType == 91 then
    local cfg = CSkinItem:GetRecorder(itemId)
    local dlg = DialogManager.CreateSingletonDialog("shop.fashionbuydialog")
    local data = {}
    table.insert(data, {
      itemId = cfg.Skinid
    })
    dlg:SetData(dlg.TargetType.OnlyShow, data)
  elseif itemType == 299 then
    local dialog = DialogManager.CreateSingletonDialog("equip.equiptipspreviewdialog")
    if dialog then
      dialog:Init(itemId)
      dialog:SetTipsParmFunc(function()
        local width, height = self._rootWindow:GetRectSize()
        local pos = self._rootWindow:GetLocalPointInUiRootPanel()
        return {
          width = width,
          height = height,
          posX = pos.x,
          posY = pos.y
        }
      end)
    end
  else
    local width, height = self._rootWindow:GetRectSize()
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({
        item = self._cellData.item
      })
      tipsDialog:SetTipsPosition(width, height, self._rootWindow:GetLocalPointInUiRootPanel())
    end
  end
end

return PopUpGift7DayItemCell
