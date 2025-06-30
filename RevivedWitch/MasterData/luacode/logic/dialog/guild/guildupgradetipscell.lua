-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guildupgradetipscell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local GuildUpGradeTipsCell = class("GuildUpGradeTipsCell", Dialog)
GuildUpGradeTipsCell.AssetBundleName = "ui/layouts.guild"
GuildUpGradeTipsCell.AssetName = "GuildUpgradeTipsItemCell"
GuildUpGradeTipsCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildUpGradeTipsCell
  ((GuildUpGradeTipsCell.super).Ctor)(self, ...)
  self._item = nil
end

GuildUpGradeTipsCell.OnCreate = function(self)
  -- function num : 0_1
  self._back = self:GetChild("ItemCell/_BackGround")
  self._image = self:GetChild("ItemCell/_BackGround/Icon")
  self._imageframe = self:GetChild("ItemCell/_BackGround/Frame")
  self._num = self:GetChild("ItemCell/_Count")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  ;
  (self._num):SetActive(false)
  ;
  (self._select):SetActive(false)
  ;
  (self._back):Subscribe_PointerClickEvent(self.OnItemClicked, self)
end

GuildUpGradeTipsCell.RefreshCell = function(self, itemId)
  -- function num : 0_2 , upvalues : Item
  self._item = (Item.Create)(itemId)
  local imageRecord = (self._item):GetPinJiImage()
  ;
  (self._imageframe):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (self._item):GetIcon()
  ;
  (self._image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

GuildUpGradeTipsCell.OnItemClicked = function(self)
  -- function num : 0_3 , upvalues : ItemTypeEnum, _ENV
  local tipsDialog = nil
  local width, height = (self:GetRootWindow()):GetRectSize()
  if (self._item):GetItemType() == ItemTypeEnum.EQUIP then
    if (self._item):IsGained() then
      tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipsdialog")
      if tipsDialog then
        tipsDialog:Init((self._item):GetKey())
        tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_3_0 , upvalues : self
    local width, height = (self:GetRootWindow()):GetRectSize()
    local pos = (self:GetRootWindow()):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
      end
    else
      tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipspreviewdialog")
      if tipsDialog then
        tipsDialog:Init((self._item):GetID())
        tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_3_1 , upvalues : self
    local width, height = (self:GetRootWindow()):GetRectSize()
    local pos = (self:GetRootWindow()):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
      end
    end
  else
    tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({item = self._item})
      tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
    end
  end
end

return GuildUpGradeTipsCell

