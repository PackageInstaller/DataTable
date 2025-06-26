-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/mainline/newmainlinefloorchestrewardcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NewMainlineFloorWorldRewardCell = class("NewMainlineFloorWorldRewardCell", Dialog)
NewMainlineFloorWorldRewardCell.AssetBundleName = "ui/layouts.mainline"
NewMainlineFloorWorldRewardCell.AssetName = "DungeonSelectChestRewardItemCell"
NewMainlineFloorWorldRewardCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NewMainlineFloorWorldRewardCell
  ((NewMainlineFloorWorldRewardCell.super).Ctor)(self, ...)
end

NewMainlineFloorWorldRewardCell.OnCreate = function(self)
  -- function num : 0_1
  self._img = self:GetChild("_BackGround/Icon")
  self._frame = self:GetChild("_BackGround/Frame")
  self._select = self:GetChild("_BackGround/Select")
  ;
  (self._select):SetActive(false)
  self._count = self:GetChild("_Count")
  ;
  (self._count):SetActive(false)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

NewMainlineFloorWorldRewardCell.OnDestroy = function(self)
  -- function num : 0_2
end

NewMainlineFloorWorldRewardCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  self._data = data.item
  local image = (self._data):GetIcon()
  ;
  (self._img):SetSprite(image.assetBundle, image.assetName)
  image = (self._data):GetPinJiImage()
  ;
  (self._frame):SetSprite(image.assetBundle, image.assetName)
  if data.num then
    (self._count):SetActive(true)
    ;
    (self._count):SetText((NumberManager.GetShowNumber)(data.num))
  else
    ;
    (self._count):SetActive(false)
  end
end

NewMainlineFloorWorldRewardCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local width, height = (self:GetRootWindow()):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._data})
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

return NewMainlineFloorWorldRewardCell

