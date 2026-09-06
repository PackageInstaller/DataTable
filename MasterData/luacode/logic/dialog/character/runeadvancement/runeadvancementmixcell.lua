local AttrTypeEnum = LuaNetManager.GetBeanDef("protocol.login.attrtype")
local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Num = 3
local RuneAdvancementMixCell = class("RuneAdvancementMixCell", Dialog)
RuneAdvancementMixCell.AssetBundleName = "ui/layouts.basecharacterinfo"
RuneAdvancementMixCell.AssetName = "CharUpgradeMixCell"

function RuneAdvancementMixCell:Ctor(...)
  RuneAdvancementMixCell.super.Ctor(self, ...)
end

function RuneAdvancementMixCell:OnCreate()
  self:GetChild("MixBtn/_Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2046))
  self._mixBtn = self:GetChild("MixBtn")
  self._mixBtn:Subscribe_PointerClickEvent(self.OnMixBtnClicked, self)
  self._itemInfo = {}
  for i = 1, 2 do
    self._itemInfo[i] = {
      frame = self:GetChild("Item" .. i .. "/ItemBack"),
      icon = self:GetChild("Item" .. i .. "/Item"),
      num = self:GetChild("Item" .. i .. "/Num"),
      name = self:GetChild("Item" .. i .. "/ItemName")
    }
    self._itemInfo[i].icon:Subscribe_PointerClickEvent(function()
      self:OnCellClicked(i)
    end, self)
  end
end

function RuneAdvancementMixCell:OnDestroy()
end

function RuneAdvancementMixCell:RefreshCell(data)
  self._data = data
  self._itemInfo[1].num:SetText(self._data.itemNum)
  self._itemInfo[2].num:SetText(self._data.exchangeNum)
  self._cellItem = {}
  local item = Item.Create(self._data.nowItem)
  local num = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(self._data.nowItem)
  if num < self._data.itemNum then
    self._itemInfo[1].num:SetText(NekoData.BehaviorManager.BM_Message:GetString(2055, {
      self._data.itemNum
    }))
  end
  self._itemInfo[1].name:SetText(item:GetName())
  self._itemInfo[1].icon:SetSprite(item:GetIconAB())
  self._cellItem[1] = item
  local item = Item.Create(self._data.exchangeItem)
  self._itemInfo[2].name:SetText(item:GetName())
  self._itemInfo[2].icon:SetSprite(item:GetIconAB())
  self._cellItem[2] = item
end

function RuneAdvancementMixCell:OnMixBtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("character.runeadvancement.exchangedialog")
  if dialog then
    dialog:PushDialogSetting(self._data.id)
  end
end

function RuneAdvancementMixCell:OnCellClicked(id)
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._cellItem[id]
    })
  end
end

return RuneAdvancementMixCell
