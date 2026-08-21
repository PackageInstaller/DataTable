-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/bag/itemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local ItemCell = class("ItemCell", Dialog)
ItemCell.AssetBundleName = "ui/layouts.bag"
ItemCell.AssetName = "ItemTipsSmall"
ItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ItemCell
  ((ItemCell.super).Ctor)(self, ...)
end

ItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  self._count = self:GetChild("ItemCell/_Count")
  self._name = self:GetChild("Text")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  ;
  (self:GetRootWindow()):SetUserData(self)
  ;
  (self._select):SetActive(false)
end

ItemCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

ItemCell.RefreshCell = function(self, data)
  -- function num : 0_3
  local imageRecord = (data.item):GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (data.item):GetPinJiImage()
  ;
  (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if data.num then
    (self._count):SetNumber(data.num)
  else
    ;
    (self._count):SetNumber((data.item):GetCount())
  end
  if data.dontShowName then
    (self._name):SetActive(false)
  else
    ;
    (self._name):SetActive(true)
    local itemName = (data.item):GetName()
    ;
    (self._name):SetText(itemName)
  end
end

ItemCell.OnCellClicked = function(self, args)
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

ItemCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5 , upvalues : _ENV
  if (self:GetRootWindow()):GetUserData() ~= arg then
    (self._select):SetActive(eventName ~= "SetItemSelectedState")
    ;
    (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

ItemCell.ChangeCellSelected = function(self, notification)
  -- function num : 0_6 , upvalues : _ENV
  if (self:GetRootWindow()):GetUserData() ~= (notification.userInfo).arg then
    (self._select):SetActive((notification.userInfo).eventName ~= "SetItemSelectedState")
    ;
    (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

return ItemCell

