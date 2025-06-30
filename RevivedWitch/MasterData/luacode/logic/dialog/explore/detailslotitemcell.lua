-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/explore/detailslotitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DetailSlotItemCell = class("DetailSlotItemCell", Dialog)
DetailSlotItemCell.AssetBundleName = "ui/layouts.yard"
DetailSlotItemCell.AssetName = "YardExploreTaskItemCell"
DetailSlotItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DetailSlotItemCell
  ((DetailSlotItemCell.super).Ctor)(self, ...)
end

DetailSlotItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._count = self:GetChild("ItemCell/_Count")
  self._itemCell = self:GetChild("ItemCell")
  self._mainItemBlack = self:GetChild("Black")
  self._mainItemTxt = self:GetChild("First")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

DetailSlotItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

DetailSlotItemCell.RefreshCell = function(self, data)
  -- function num : 0_3
  local item = data.item
  local imageRecord = item:GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetPinJiImage()
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local count = item:GetCount()
  if count > 0 then
    (self._count):SetActive(true)
    ;
    (self._icon):SetAlpha(1)
    ;
    (self._frame):SetAlpha(1)
    ;
    (self._count):SetNumber(count)
    ;
    (self._mainItemBlack):SetActive(false)
    ;
    (self._mainItemTxt):SetActive(false)
  else
    ;
    (self._count):SetActive(false)
    ;
    (self._icon):SetAlpha(1)
    ;
    (self._frame):SetAlpha(1)
    if data.isMainItem then
      (self._mainItemBlack):SetActive(true)
      ;
      (self._mainItemTxt):SetActive(true)
    else
      ;
      (self._mainItemBlack):SetActive(false)
      ;
      (self._mainItemTxt):SetActive(false)
      if (self._delegate)._dialogName == "explore.detailworkingcell" then
        (self._icon):SetAlpha(0.3)
        ;
        (self._frame):SetAlpha(0.25)
      end
    end
  end
end

DetailSlotItemCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local width, height = (self._itemCell):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (self._cellData).item})
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

return DetailSlotItemCell

