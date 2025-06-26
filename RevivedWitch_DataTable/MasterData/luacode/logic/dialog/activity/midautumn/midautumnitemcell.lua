-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/midautumn/midautumnitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MidAutumnItemCell = class("MidAutumnItemCell", Dialog)
MidAutumnItemCell.AssetBundleName = "ui/layouts.activitymidautumn"
MidAutumnItemCell.AssetName = "ActivityMidAutumnMainItemCell"
MidAutumnItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MidAutumnItemCell
  ((MidAutumnItemCell.super).Ctor)(self, ...)
end

MidAutumnItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  ;
  (self._select):SetActive(false)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

MidAutumnItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

MidAutumnItemCell.RefreshCell = function(self, data)
  -- function num : 0_3
  self._item = data
  local imageRecord = (self._item):GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (self._item):GetPinJiImage()
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

MidAutumnItemCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    local width, height = (self:GetRootWindow()):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

return MidAutumnItemCell

