-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/resourcedungeonaccountcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local ResourceDungeonAccountCell = class("ResourceDungeonAccountCell", Dialog)
ResourceDungeonAccountCell.AssetBundleName = "ui/layouts.mainline"
ResourceDungeonAccountCell.AssetName = "ResourceDungeonFinishItemCell"
ResourceDungeonAccountCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ResourceDungeonAccountCell
  ((ResourceDungeonAccountCell.super).Ctor)(self, ...)
end

ResourceDungeonAccountCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._count = self:GetChild("ItemCell/_Count")
  self._Select = self:GetChild("ItemCell/_BackGround/Select")
  ;
  (self._Select):SetActive(false)
  self._got = self:GetChild("Image")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

ResourceDungeonAccountCell.OnDestroy = function(self)
  -- function num : 0_2
end

ResourceDungeonAccountCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : _ENV, CImagePathTable
  do
    if not (self._cellData).item then
      local imageRecord = DataCommon.NullImageAsset
      ;
      (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (self._count):SetText("")
      imageRecord = CImagePathTable:GetRecorder(10374)
      ;
      (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      return 
    end
    local imageRecord = ((self._cellData).item):GetIcon()
    ;
    (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = ((self._cellData).item):GetPinJiImage()
    ;
    (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._count):SetText((NumberManager.GetShowNumber)(((self._cellData).item):GetCount()))
    ;
    (self._got):SetActive((self._cellData).got == true)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
end

ResourceDungeonAccountCell.OnCellClicked = function(self, args, luawindow)
  -- function num : 0_4 , upvalues : ItemTypeEnum, _ENV
  if not (self._cellData).item then
    return 
  end
  ;
  (self._Select):SetActive(true)
  ;
  (self._delegate):SetSelectedID(((self._cellData).item):GetKey())
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
      tipsDialog:Init(self._cellData, true)
      tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
    end
  end
end

ResourceDungeonAccountCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if not (self._cellData).item then
    return 
  end
  if ((self._cellData).item):GetKey() ~= arg then
    (self._Select):SetActive(eventName ~= "ChangedSelected")
    if eventName == "RefreshCell" and (not arg.item or ((self._cellData).item):GetKey() == (arg.item):GetKey()) then
      self._cellData = arg
      self:RefreshCell()
    end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

return ResourceDungeonAccountCell

