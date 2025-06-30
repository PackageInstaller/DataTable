-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/breakitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local BreakItemCell = class("BreakItemCell", Dialog)
BreakItemCell.AssetBundleName = "ui/layouts.basecharacterinfo"
BreakItemCell.AssetName = "BaseCharacterInfoBreakItemCell"
BreakItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BreakItemCell
  ((BreakItemCell.super).Ctor)(self, ...)
end

BreakItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._frame = self:GetChild("_BackGround/Frame")
  self._icon = self:GetChild("_BackGround/Icon")
  self._count = self:GetChild("_Count/Text")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

BreakItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

BreakItemCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item, _ENV
  self._item = (Item.Create)(data.itemId)
  local imageRecord = (self._item):GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (self._item):GetPinJiImage()
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local count = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(data.itemId)
  ;
  (self._item):SetCount(count)
  local str = (NumberManager.GetShowNumber)(count)
  if data.itemNum then
    if count < data.itemNum then
      str = "<color=#ff0000ff>" .. str .. "</color>"
    end
    str = str .. "/" .. (NumberManager.GetShowNumber)(data.itemNum)
    ;
    (self._count):SetText(str)
  else
    str = tostring(0)
    str = "<color=#ff0000ff>" .. str .. "</color>"
    str = str .. "/" .. tostring(1)
    ;
    (self._count):SetText(str)
  end
end

BreakItemCell.OnCellClicked = function(self, args)
  -- function num : 0_4 , upvalues : _ENV
  local data = {}
  data.item = self._item
  local width, height = (self:GetRootWindow()):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init(data)
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

return BreakItemCell

