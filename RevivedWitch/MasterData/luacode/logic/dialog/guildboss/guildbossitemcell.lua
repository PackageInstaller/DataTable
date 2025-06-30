-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guildboss/guildbossitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CMonsterConfigTable = (BeanManager.GetTableByName)("npc.cmonsterconfig")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local CRoleItem = (BeanManager.GetTableByName)("item.croleitem")
local ItemIdType = {Role = 27, Equip = 299}
local GuildBossItemCell = class("GuildBossItemCell", Dialog)
GuildBossItemCell.AssetBundleName = "ui/layouts.guild"
GuildBossItemCell.AssetName = "GuildBossPrepareItemCell"
GuildBossItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildBossItemCell
  ((GuildBossItemCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

GuildBossItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._itemCell = {back = self:GetChild("ItemCell/_BackGround"), mask = self:GetChild("ItemCell/_BackGround/Mask"), frame = self:GetChild("ItemCell/_BackGround/Frame"), icon = self:GetChild("ItemCell/_BackGround/Icon"), count = self:GetChild("ItemCell/_Count"), first = self:GetChild("First"), normal = self:GetChild("Normal"), chance = self:GetChild("Chance"), limit = self:GetChild("Limited")}
  ;
  ((self._itemCell).back):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self
    self:OnCellClick()
  end
, self)
  ;
  ((self._itemCell).first):SetActive(false)
  ;
  ((self._itemCell).normal):SetActive(false)
  ;
  ((self._itemCell).chance):SetActive(false)
  ;
  ((self._itemCell).limit):SetActive(false)
end

GuildBossItemCell.OnCellClick = function(self, index)
  -- function num : 0_2 , upvalues : ItemIdType, CRoleItem, _ENV
  local item = self.item
  local dialog = nil
  if item:GetItemTypeId() == ItemIdType.Role then
    local roleID = (CRoleItem:GetRecorder(item:GetID())).roleid
    dialog = (DialogManager.CreateSingletonDialog)("mainline.bossrush.checkotherroleinfodialog")
    if dialog then
      dialog:Init({
roleIdList = {roleID}
, 
cfgIdList = {4}
, index = 1}, (dialog.ShowType).BaseLevelInfo)
    end
  else
    do
      if item:GetItemTypeId() == ItemIdType.Equip then
        dialog = (DialogManager.CreateSingletonDialog)("equip.equiptipspreviewdialog")
        if dialog then
          dialog:Init(item:GetID())
          dialog:SetTipsParmFunc(function()
    -- function num : 0_2_0 , upvalues : self, index
    local width, height = ((self._itemBacks)[index]):GetRectSize()
    local pos = ((self._itemBacks)[index]):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
        end
      else
        dialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
        if dialog then
          dialog:Init({item = item})
        end
      end
    end
  end
end

GuildBossItemCell.OnDestroy = function(self)
  -- function num : 0_3
end

GuildBossItemCell.RefreshCell = function(self)
  -- function num : 0_4 , upvalues : Item, _ENV
  ((self._itemCell).first):SetActive(false)
  ;
  ((self._itemCell).normal):SetActive(false)
  ;
  ((self._itemCell).chance):SetActive(false)
  ;
  ((self._itemCell).limit):SetActive(false)
  local itemId = (self._cellData).itemid
  local itemNum = (self._cellData).itemnum
  self.item = (Item.Create)(itemId)
  ;
  ((self._itemCell).icon):SetSprite((self.item):GetIconAB())
  ;
  ((self._itemCell).frame):SetSprite((self.item):GetPinJiImageAB())
  ;
  ((self._itemCell).count):SetText((NumberManager.GetNumber)(itemNum))
  ;
  ((self._itemCell).limit):SetText((NumberManager.GetNumber)(itemNum))
  if (self._cellData).itemtype == 0 then
    ((self._itemCell).normal):SetActive(true)
  else
    if (self._cellData).itemtype == 1 then
      ((self._itemCell).chance):SetActive(true)
    end
  end
end

GuildBossItemCell.OnBattleBtnClicked = function(self)
  -- function num : 0_5
end

return GuildBossItemCell

