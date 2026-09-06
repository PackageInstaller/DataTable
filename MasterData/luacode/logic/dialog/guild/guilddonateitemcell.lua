local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local GuildDonateItemCell = class("GuildDonateItemCell", Dialog)
GuildDonateItemCell.AssetBundleName = "ui/layouts.guild"
GuildDonateItemCell.AssetName = "GuildDonateItemCell"

function GuildDonateItemCell:Ctor(...)
  GuildDonateItemCell.super.Ctor(self, ...)
end

function GuildDonateItemCell:OnCreate()
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  self._count = self:GetChild("ItemCell/_Count")
  self._selectCountBack = self:GetChild("Grey")
  self._selectCountText = self:GetChild("Grey/Text")
  self._select:SetActive(false)
  self._selectCountBack:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function GuildDonateItemCell:OnDestroy()
end

function GuildDonateItemCell:RefreshCell(data)
  local imageRecord = data.item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = data.item:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._count:SetNumber(data.item:GetCount())
  self._select:SetActive(self._cellData.isSelect)
  if self._cellData.selectCount == 0 then
    self._selectCountBack:SetActive(false)
  else
    self._selectCountBack:SetActive(true)
    self._selectCountText:SetText(self._cellData.selectCount)
  end
end

function GuildDonateItemCell:OnCellClicked(args)
  local data = {
    key = self._cellData.item:GetKey(),
    selectCount = self._cellData.selectCount,
    maxCount = self._cellData.item:GetCount()
  }
  self._delegate:SetSelectedItemData(data)
end

function GuildDonateItemCell:OnEvent(eventName, arg)
  if eventName == "SetItemSelectedState" then
    local flg = self._cellData.item:GetKey() == arg
    self._cellData.isSelect = flg
    self._select:SetActive(self._cellData.isSelect)
    if self._cellData.isSelect then
      self._selectCountBack:SetActive(true)
      self._selectCountText:SetText(self._cellData.selectCount)
    elseif self._cellData.selectCount == 0 then
      self._selectCountBack:SetActive(false)
    end
  elseif eventName == "ChangeItemSelectCount" then
    if self._cellData.item:GetKey() == arg.key then
      self._cellData.selectCount = arg.count
      self._selectCountText:SetText(self._cellData.selectCount)
    end
  elseif eventName == "ClearSelectData" then
    self._cellData.selectCount = 0
    self._cellData.isSelect = false
    self._select:SetActive(false)
    self._selectCountBack:SetActive(false)
  end
end

return GuildDonateItemCell
