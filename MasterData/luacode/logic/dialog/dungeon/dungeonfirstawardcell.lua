local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local DungeonFirstAwardCell = class("DungeonFirstAwardCell", Dialog)
DungeonFirstAwardCell.AssetBundleName = "ui/layouts.dungeon"
DungeonFirstAwardCell.AssetName = "DungeonFinish1ItemCell"

function DungeonFirstAwardCell:Ctor(...)
  DungeonFirstAwardCell.super.Ctor(self, ...)
end

function DungeonFirstAwardCell:OnCreate()
  self._image = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._count = self:GetChild("ItemCell/_Count")
  self._mark = self:GetChild("Image")
  self._mark:SetActive(false)
  self._count:SetText("")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
  self:GetRootWindow():SetUserData(self)
end

function DungeonFirstAwardCell:OnDestroy()
end

function DungeonFirstAwardCell:RefreshCell(data)
  local image = data.item:GetIcon()
  self._image:SetSprite(image.assetBundle, image.assetName)
  image = data.item:GetPinJiImage()
  self._frame:SetSprite(image.assetBundle, image.assetName)
  if data.num then
    self._count:SetNumber(data.num)
  else
    self._count:SetNumber(data.item:GetCount())
  end
end

function DungeonFirstAwardCell:OnCellClick(args)
  local tipsDialog
  local width, height = self:GetRootWindow():GetRectSize()
  if self._cellData.item:GetItemType() == ItemTypeEnum.EQUIP then
    if self._cellData.item:IsGained() then
      tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipsdialog")
      if tipsDialog then
        tipsDialog:Init(self._cellData.item:GetKey())
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
    else
      tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipspreviewdialog")
      if tipsDialog then
        tipsDialog:Init(self._cellData.item:GetID())
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
  else
    tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init(self._cellData)
      tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
    end
  end
end

function DungeonFirstAwardCell:OnEvent(eventName, arg)
  if eventName == "SetItemSelectedState" then
    DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  end
end

return DungeonFirstAwardCell
