-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tower/towerchallengedetailcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local TowerChallengeDetailCell = class("TowerChallengeDetailCell", Dialog)
TowerChallengeDetailCell.AssetBundleName = "ui/layouts.mainline"
TowerChallengeDetailCell.AssetName = "TowerDetailItemCell"
TowerChallengeDetailCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerChallengeDetailCell
  ((TowerChallengeDetailCell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

TowerChallengeDetailCell.OnCreate = function(self)
  -- function num : 0_1
  self._itemCell = self:GetChild("ItemCell")
  self._itemFrame = self:GetChild("ItemCell/_BackGround/Frame")
  self._itemImg = self:GetChild("ItemCell/_BackGround/Icon")
  self._itemSelect = self:GetChild("ItemCell/_BackGround/Select")
  self._itemNum = self:GetChild("ItemCell/_Count")
  ;
  (self._itemNum):SetActive(false)
  ;
  (self._itemCell):Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
end

TowerChallengeDetailCell.OnDestroy = function(self)
  -- function num : 0_2
end

TowerChallengeDetailCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item
  self._id = data.id
  local item = (Item.Create)(data.id)
  local imageRecord = item:GetIcon()
  ;
  (self._itemImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

TowerChallengeDetailCell.OnItemCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV, Item
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (Item.Create)(self._id)})
    local width, height = (self._itemCell):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self._itemCell):GetLocalPointInUiRootPanel())
  end
  do
    if (self._delegate).AssetName ~= "TowerEventBattle" then
      (self._delegate):OnItemCellClick()
    end
  end
end

TowerChallengeDetailCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if eventName == "ChangeSelectItem" then
    if self._id == arg then
      (self._itemSelect):SetActive(true)
    else
      ;
      (self._itemSelect):SetActive(false)
    end
  end
end

return TowerChallengeDetailCell

