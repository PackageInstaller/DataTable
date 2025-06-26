-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/mainline/newmainlineflooritemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local NewMainLineFloorItemCell = class("NewMainLineFloorItemCell", Dialog)
NewMainLineFloorItemCell.AssetBundleName = "ui/layouts.mainline"
NewMainLineFloorItemCell.AssetName = "DungeonSelectItemCell"
NewMainLineFloorItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NewMainLineFloorItemCell
  ((NewMainLineFloorItemCell.super).Ctor)(self, ...)
end

NewMainLineFloorItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  ;
  (self._select):SetActive(false)
  self._count = self:GetChild("ItemCell/_Count")
  ;
  (self._count):SetActive(false)
  self._check = self:GetChild("Check")
  ;
  (self._check):SetActive(false)
  self._firstLable = self:GetChild("First")
  self._normalLable = self:GetChild("Normal")
  self._chanceLable = self:GetChild("Chance")
  self._limitLable = self:GetChild("Limited")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

NewMainLineFloorItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

local SetActive = function(self, first, normal, chance, activityLimit)
  -- function num : 0_3
  (self._firstLable):SetActive(first)
  ;
  (self._normalLable):SetActive(normal)
  ;
  (self._chanceLable):SetActive(chance)
  ;
  (self._limitLable):SetActive(activityLimit)
end

NewMainLineFloorItemCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : SetActive
  if data.first then
    SetActive(self, true, false, false, false)
  else
    if data.normal then
      SetActive(self, false, true, false, false)
    else
      if data.chance then
        SetActive(self, false, false, true, false)
      else
        if data.activityLimit then
          SetActive(self, false, false, false, true)
        end
      end
    end
  end
  self._data = data.item
  if data.get then
    (self._check):SetActive(true)
  else
    ;
    (self._check):SetActive(false)
  end
  local image = (self._data):GetIcon()
  ;
  (self._image):SetSprite(image.assetBundle, image.assetName)
  image = (self._data):GetPinJiImage()
  ;
  (self._frame):SetSprite(image.assetBundle, image.assetName)
end

NewMainLineFloorItemCell.OnCellClick = function(self, args)
  -- function num : 0_5 , upvalues : ItemTypeEnum, _ENV
  if ((self._cellData).item):GetItemType() == ItemTypeEnum.BASEITEM then
    local width, height = (self:GetRootWindow()):GetRectSize()
    local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({item = self._data})
      tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
    end
  else
    do
      if ((self._cellData).item):GetItemType() == ItemTypeEnum.EQUIP then
        local tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipspreviewdialog")
        local width, height = (self:GetRootWindow()):GetRectSize()
        if tipsDialog then
          tipsDialog:Init((self._data):GetID())
          tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_5_0 , upvalues : self
    local width, height = (self:GetRootWindow()):GetRectSize()
    local pos = (self:GetRootWindow()):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
        end
      end
    end
  end
end

return NewMainLineFloorItemCell

