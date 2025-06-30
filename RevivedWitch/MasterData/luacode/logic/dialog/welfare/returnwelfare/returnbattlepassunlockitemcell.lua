-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/returnwelfare/returnbattlepassunlockitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ReturnBattlePassUnlockItemCell = class("ReturnBattlePassUnlockItemCell", Dialog)
ReturnBattlePassUnlockItemCell.AssetBundleName = "ui/layouts.welfare"
ReturnBattlePassUnlockItemCell.AssetName = "ReturnBattlePassBuyItemCell"
ReturnBattlePassUnlockItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ReturnBattlePassUnlockItemCell
  ((ReturnBattlePassUnlockItemCell.super).Ctor)(self, ...)
end

ReturnBattlePassUnlockItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  self._count = self:GetChild("ItemCell/_Count")
  ;
  (self._select):SetActive(false)
  ;
  (self._icon):Subscribe_PointerClickEvent(self.ItemClick, self)
end

ReturnBattlePassUnlockItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

ReturnBattlePassUnlockItemCell.ItemClick = function(self)
  -- function num : 0_3 , upvalues : _ENV, Item
  if (self._data):GetID() == DataCommon.ReturnBattlePass_RoleSelectItemId then
    ((DialogManager.CreateSingletonDialog)("welfare.returnwelfare.roleopstiondialog")):SetData({option = 0}, false)
  else
    local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
    if tipsDialog then
      local d = self._data
      tipsDialog:Init({item = (Item.Create)(d:GetID())})
      local width, height = (self._icon):GetRectSize()
      tipsDialog:SetTipsPosition(width, height, (self._icon):GetLocalPointInUiRootPanel())
    end
  end
end

ReturnBattlePassUnlockItemCell.RefreshCell = function(self, data)
  -- function num : 0_4
  self._data = data
  local imageRecord = data:GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = data:GetPinJiImage()
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._count):SetNumber(data:GetCount())
end

return ReturnBattlePassUnlockItemCell

