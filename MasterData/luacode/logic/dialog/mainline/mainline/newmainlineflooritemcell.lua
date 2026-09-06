local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local NewMainLineFloorItemCell = class("NewMainLineFloorItemCell", Dialog)
NewMainLineFloorItemCell.AssetBundleName = "ui/layouts.mainline"
NewMainLineFloorItemCell.AssetName = "DungeonSelectItemCell"

function NewMainLineFloorItemCell:Ctor(...)
  NewMainLineFloorItemCell.super.Ctor(self, ...)
end

function NewMainLineFloorItemCell:OnCreate()
  self._image = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  self._select:SetActive(false)
  self._count = self:GetChild("ItemCell/_Count")
  self._count:SetActive(false)
  self._check = self:GetChild("Check")
  self._check:SetActive(false)
  self._firstLable = self:GetChild("First")
  self._normalLable = self:GetChild("Normal")
  self._chanceLable = self:GetChild("Chance")
  self._limitLable = self:GetChild("Limited")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function NewMainLineFloorItemCell:OnDestroy()
end

local function SetActive(self, first, normal, chance, activityLimit)
  self._firstLable:SetActive(first)
  self._normalLable:SetActive(normal)
  self._chanceLable:SetActive(chance)
  self._limitLable:SetActive(activityLimit)
end

function NewMainLineFloorItemCell:RefreshCell(data)
  if data.first then
    SetActive(self, true, false, false, false)
  elseif data.normal then
    SetActive(self, false, true, false, false)
  elseif data.chance then
    SetActive(self, false, false, true, false)
  elseif data.activityLimit then
    SetActive(self, false, false, false, true)
  end
  self._data = data.item
  if data.get then
    self._check:SetActive(true)
  else
    self._check:SetActive(false)
  end
  local image = self._data:GetIcon()
  self._image:SetSprite(image.assetBundle, image.assetName)
  image = self._data:GetPinJiImage()
  self._frame:SetSprite(image.assetBundle, image.assetName)
end

function NewMainLineFloorItemCell:OnCellClick(args)
  if self._cellData.item:GetItemType() == ItemTypeEnum.BASEITEM then
    local width, height = self:GetRootWindow():GetRectSize()
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({
        item = self._data
      })
      tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
    end
  elseif self._cellData.item:GetItemType() == ItemTypeEnum.EQUIP then
    local tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipspreviewdialog")
    local width, height = self:GetRootWindow():GetRectSize()
    if tipsDialog then
      tipsDialog:Init(self._data:GetID())
      tipsDialog:SetTipsParmFunc(function()
        local width, height = self:GetRootWindow():GetRectSize()
        local pos = self:GetRootWindow():GetLocalPointInUiRootPanel()
        return {
          width = width,
          height = height,
          posX = pos.x,
          posY = pos.y
        }
      end)
    end
  end
end

return NewMainLineFloorItemCell
