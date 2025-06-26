-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/runeadvancement/runeadvancementmixcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AttrTypeEnum = (LuaNetManager.GetBeanDef)("protocol.login.attrtype")
local CAttrNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Num = 3
local RuneAdvancementMixCell = class("RuneAdvancementMixCell", Dialog)
RuneAdvancementMixCell.AssetBundleName = "ui/layouts.basecharacterinfo"
RuneAdvancementMixCell.AssetName = "CharUpgradeMixCell"
RuneAdvancementMixCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RuneAdvancementMixCell
  ((RuneAdvancementMixCell.super).Ctor)(self, ...)
end

RuneAdvancementMixCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (self:GetChild("MixBtn/_Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2046))
  self._mixBtn = self:GetChild("MixBtn")
  ;
  (self._mixBtn):Subscribe_PointerClickEvent(self.OnMixBtnClicked, self)
  self._itemInfo = {}
  for i = 1, 2 do
    do
      -- DECOMPILER ERROR at PC56: Confused about usage of register: R5 in 'UnsetPending'

      (self._itemInfo)[i] = {frame = self:GetChild("Item" .. i .. "/ItemBack"), icon = self:GetChild("Item" .. i .. "/Item"), num = self:GetChild("Item" .. i .. "/Num"), name = self:GetChild("Item" .. i .. "/ItemName")}
      ;
      (((self._itemInfo)[i]).icon):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnCellClicked(i)
  end
, self)
    end
  end
end

RuneAdvancementMixCell.OnDestroy = function(self)
  -- function num : 0_2
end

RuneAdvancementMixCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item, _ENV
  self._data = data
  ;
  (((self._itemInfo)[1]).num):SetText((self._data).itemNum)
  ;
  (((self._itemInfo)[2]).num):SetText((self._data).exchangeNum)
  self._cellItem = {}
  local item = (Item.Create)((self._data).nowItem)
  local num = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById((self._data).nowItem)
  if num < (self._data).itemNum then
    (((self._itemInfo)[1]).num):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2055, {(self._data).itemNum}))
  end
  ;
  (((self._itemInfo)[1]).name):SetText(item:GetName())
  ;
  (((self._itemInfo)[1]).icon):SetSprite(item:GetIconAB())
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._cellItem)[1] = item
  local item = (Item.Create)((self._data).exchangeItem)
  ;
  (((self._itemInfo)[2]).name):SetText(item:GetName())
  ;
  (((self._itemInfo)[2]).icon):SetSprite(item:GetIconAB())
  -- DECOMPILER ERROR at PC82: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._cellItem)[2] = item
end

RuneAdvancementMixCell.OnMixBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("character.runeadvancement.exchangedialog")
  if dialog then
    dialog:PushDialogSetting((self._data).id)
  end
end

RuneAdvancementMixCell.OnCellClicked = function(self, id)
  -- function num : 0_5 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (self._cellItem)[id]})
  end
end

return RuneAdvancementMixCell

