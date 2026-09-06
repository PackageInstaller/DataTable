local CSkinItem = BeanManager.GetTableByName("item.cskinitem")
local CRoleItemTable = BeanManager.GetTableByName("item.croleitem")
local Item = require("logic.manager.experimental.types.item")
local MinDiscountcell = class("MinDiscountcell", Dialog)
MinDiscountcell.AssetBundleName = "ui/layouts.welfare"
MinDiscountcell.AssetName = "MinDiscountCell"

function MinDiscountcell:Ctor(...)
  MinDiscountcell.super.Ctor(self, ...)
end

function MinDiscountcell:OnCreate()
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  self._count = self:GetChild("ItemCell/_Count")
  self._select:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function MinDiscountcell:OnDestroy()
end

function MinDiscountcell:RefreshCell(data)
  self._item = Item.Create(data.itemID)
  local imageRecord = self._item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = self._item:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._count:SetNumber(data.itemCount)
end

function MinDiscountcell:OnCellClicked()
  if self._item:GetItemTypeId() == 91 then
    local cfg = CSkinItem:GetRecorder(self._item:GetID())
    if not cfg then
      LogErrorFormat("MinDiscountcell", "record with id %s is not exist in cskinitem", self._item:GetID())
    end
    local dlg = DialogManager.CreateSingletonDialog("shop.fashionbuydialog")
    local data = {}
    table.insert(data, {
      itemId = cfg.Skinid
    })
    dlg:SetData(dlg.TargetType.OnlyShow, data)
  else
    local cfg = CRoleItemTable:GetRecorder(self._item:GetID())
    if cfg then
      local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
      local roleInfoDialog = DialogManager.CreateSingletonDialog("mainline.bossrush.checkotherroleinfodialog")
      local roleIDList = {
        cfg.roleid
      }
      local cfgIDList = {4}
      roleInfoDialog:Init({
        roleIdList = roleIDList,
        cfgIdList = cfgIDList,
        index = 1
      }, CheckOtherRoleInfoDialog.ShowType.BaseLevelInfo)
    else
      local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
      if tipsDialog then
        tipsDialog:Init({
          item = self._item
        })
        local width, height = self:GetRootWindow():GetRectSize()
        tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
      end
    end
  end
end

return MinDiscountcell
