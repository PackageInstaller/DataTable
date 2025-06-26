-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/swimsuitbattleitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local SwimSuitBattleItemCell = class("SwimSuitBattleItemCell", Dialog)
SwimSuitBattleItemCell.AssetBundleName = "ui/layouts.activitysummer"
SwimSuitBattleItemCell.AssetName = "ActivitySummerCellItem"
SwimSuitBattleItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SwimSuitBattleItemCell
  ((SwimSuitBattleItemCell.super).Ctor)(self, ...)
end

SwimSuitBattleItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("text")
  self._count = self:GetChild("Panel/ItemCell/_Count")
  self._icon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._select = self:GetChild("Panel/ItemCell/_BackGround/Select")
  ;
  (self._select):SetActive(false)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

SwimSuitBattleItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

SwimSuitBattleItemCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, Item
  (self._text):SetActive(data.tag == "first" or data.tag == "may")
  if data.tag == "first" then
    (self._text):SetText((TextManager.GetText)(701418))
  elseif data.tag == "may" then
    (self._text):SetText((TextManager.GetText)(701419))
  end
  ;
  (self._count):SetActive(false)
  ;
  (self._count):SetText(data.count)
  self._item = (Item.Create)(data.itemID)
  local imageRecord = (self._item):GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (self._item):GetPinJiImage()
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

SwimSuitBattleItemCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    local width, height = (self:GetRootWindow()):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

return SwimSuitBattleItemCell

