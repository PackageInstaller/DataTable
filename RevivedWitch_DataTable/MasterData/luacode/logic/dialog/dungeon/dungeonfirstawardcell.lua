-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/dungeonfirstawardcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local DungeonFirstAwardCell = class("DungeonFirstAwardCell", Dialog)
DungeonFirstAwardCell.AssetBundleName = "ui/layouts.dungeon"
DungeonFirstAwardCell.AssetName = "DungeonFinish1ItemCell"
DungeonFirstAwardCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonFirstAwardCell
  ((DungeonFirstAwardCell.super).Ctor)(self, ...)
end

DungeonFirstAwardCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._count = self:GetChild("ItemCell/_Count")
  self._mark = self:GetChild("Image")
  ;
  (self._mark):SetActive(false)
  ;
  (self._count):SetText("")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
  ;
  (self:GetRootWindow()):SetUserData(self)
end

DungeonFirstAwardCell.OnDestroy = function(self)
  -- function num : 0_2
end

DungeonFirstAwardCell.RefreshCell = function(self, data)
  -- function num : 0_3
  local image = (data.item):GetIcon()
  ;
  (self._image):SetSprite(image.assetBundle, image.assetName)
  image = (data.item):GetPinJiImage()
  ;
  (self._frame):SetSprite(image.assetBundle, image.assetName)
  if data.num then
    (self._count):SetNumber(data.num)
  else
    ;
    (self._count):SetNumber((data.item):GetCount())
  end
end

DungeonFirstAwardCell.OnCellClick = function(self, args)
  -- function num : 0_4 , upvalues : ItemTypeEnum, _ENV
  local tipsDialog = nil
  local width, height = (self:GetRootWindow()):GetRectSize()
  if ((self._cellData).item):GetItemType() == ItemTypeEnum.EQUIP then
    if ((self._cellData).item):IsGained() then
      tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipsdialog")
      if tipsDialog then
        tipsDialog:Init(((self._cellData).item):GetKey())
        tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_4_0 , upvalues : self
    local width, height = (self:GetRootWindow()):GetRectSize()
    local pos = (self:GetRootWindow()):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
      end
    else
      tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipspreviewdialog")
      if tipsDialog then
        tipsDialog:Init(((self._cellData).item):GetID())
        tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_4_1 , upvalues : self
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
      tipsDialog:Init(self._cellData)
      tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
    end
  end
end

DungeonFirstAwardCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5 , upvalues : _ENV
  if eventName == "SetItemSelectedState" then
    (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
  end
end

return DungeonFirstAwardCell

