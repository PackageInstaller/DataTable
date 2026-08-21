-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/dungeonaccountcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local DungeonAccountCell = class("DungeonAccountCell", Dialog)
DungeonAccountCell.AssetBundleName = "ui/layouts.dungeon"
DungeonAccountCell.AssetName = "DungeonFinish2ItemCell"
DungeonAccountCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonAccountCell
  ((DungeonAccountCell.super).Ctor)(self, ...)
end

DungeonAccountCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  ;
  (self._select):SetActive(false)
  self._count = self:GetChild("ItemCell/_Count")
  self._spiritLabel = self:GetChild("Black")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
  ;
  (self:GetRootWindow()):SetUserData(self)
end

DungeonAccountCell.OnDestroy = function(self)
  -- function num : 0_2
end

DungeonAccountCell.RefreshCell = function(self, data)
  -- function num : 0_3
  local image = (data.item):GetIcon()
  ;
  (self._image):SetSprite(image.assetBundle, image.assetName)
  image = (data.item):GetPinJiImage()
  ;
  (self._frame):SetSprite(image.assetBundle, image.assetName)
  ;
  (self._count):SetNumber(data.num)
  if (data.item):GetID() == 35003 and data.num > 0 then
    (self._spiritLabel):SetActive(true)
  else
    ;
    (self._spiritLabel):SetActive(false)
  end
end

DungeonAccountCell.OnCellClick = function(self, args)
  -- function num : 0_4 , upvalues : ItemTypeEnum, _ENV
  (self._select):SetActive(true)
  ;
  (self._delegate):SetSelectedID((self:GetRootWindow()):GetUserData())
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

DungeonAccountCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if (self:GetRootWindow()):GetUserData() ~= arg then
    (self._select):SetActive(eventName ~= "SetItemSelectedState")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

DungeonAccountCell.ChangeCellSelected = function(self, notification)
  -- function num : 0_6 , upvalues : _ENV
  if (self:GetRootWindow()):GetUserData() ~= (notification.userInfo).arg then
    (self._select):SetActive((notification.userInfo).eventName ~= "SetItemSelectedState")
    ;
    (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

return DungeonAccountCell

