-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/springfestival/rewardcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local Item = require("logic.manager.experimental.types.item")
local stageToText = {[-1] = 701680, [1] = 701664, [2] = 701665, [3] = 701666, [4] = 701667, [5] = 701668, [6] = 701669}
local RewardCell = class("RewardCell", Dialog)
RewardCell.AssetBundleName = "ui/layouts.activitynewyear"
RewardCell.AssetName = "ActivityNewYearCellItem"
RewardCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RewardCell
  ((RewardCell.super).Ctor)(self, ...)
end

RewardCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._select = self:GetChild("Panel/ItemCell/_BackGround/Select")
  ;
  (self._select):SetActive(false)
  self._count = self:GetChild("Panel/ItemCell/_Count")
  self._text = self:GetChild("Text")
  self._textBack = self:GetChild("Image")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

RewardCell.OnDestroy = function(self)
  -- function num : 0_2
end

RewardCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item, _ENV, stageToText
  self._item = (Item.Create)(data.id)
  local image = (self._item):GetIcon()
  ;
  (self._image):SetSprite(image.assetBundle, image.assetName)
  image = (self._item):GetPinJiImage()
  ;
  (self._frame):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._count):SetText((NumberManager.GetShowNumber)(data.num))
  ;
  (self._text):SetActive(data.stage ~= -1)
  ;
  (self._textBack):SetActive(data.stage ~= -1)
  ;
  (self._text):SetText((TextManager.GetText)(stageToText[data.stage]))
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

RewardCell.OnCellClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local width, height = (self:GetRootWindow()):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

return RewardCell

