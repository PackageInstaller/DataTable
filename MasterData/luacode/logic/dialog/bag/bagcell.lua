-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/bag/bagcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CVarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
local BagCell = class("BagCell", Dialog)
BagCell.AssetBundleName = "ui/layouts.bag"
BagCell.AssetName = "BagItemCell"
BagCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BagCell
  ((BagCell.super).Ctor)(self, ...)
end

BagCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._count = self:GetChild("ItemCell/_Count")
  self._Select = self:GetChild("ItemCell/_BackGround/Select")
  self._grayIcon = self:GetChild("Grey")
  ;
  (self._Select):SetActive(false)
  ;
  (self._grayIcon):SetActive(false)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

BagCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._task then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

BagCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CVarconfig, CImagePathTable
  if not data.item then
    local imageRecord = DataCommon.NullImageAsset
    ;
    (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._count):SetText("")
    ;
    (self._grayIcon):SetActive(false)
    local defaultCellVarRecord = CVarconfig:GetRecorder(28)
    imageRecord = CImagePathTable:GetRecorder(tonumber(defaultCellVarRecord.Value))
    ;
    (self._frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    if self._task then
      (ServerGameTimer.RemoveTask)(self._task)
      self._task = nil
    end
    return 
  end
  do
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
    if (self._delegate).IfInResolveMode and (self._delegate):IfInResolveMode() and data.item then
      (self._grayIcon):SetActive(not (data.item):CanResolve())
    else
      ;
      (self._grayIcon):SetActive(false)
    end
    if self._task then
      (ServerGameTimer.RemoveTask)(self._task)
      self._task = nil
    end
    if (data.item):GetTermTime() and (data.item):GetTermTime() > 0 then
      self._task = (ServerGameTimer.AddTask)(0, 1, function()
    -- function num : 0_3_0 , upvalues : self
    self:CountDown()
  end
, nil)
    end
  end
end

BagCell.CountDown = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local time = ((self._cellData).item):GetDelTime() - (ServerGameTimer.GetServerTime)()
  if time < 0 then
    local CUpdateLimitedItems = (LuaNetManager.CreateProtocol)("protocol.item.cupdatelimiteditems")
    if CUpdateLimitedItems then
      CUpdateLimitedItems.itemKey = ((self._cellData).item):GetKey()
      CUpdateLimitedItems.itemId = ((self._cellData).item):GetID()
      CUpdateLimitedItems:Send()
    end
    ;
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

BagCell.SetResoveModelState = function(self, bResove)
  -- function num : 0_5
  if bResove and (self._cellData).item then
    (self._grayIcon):SetActive(not ((self._cellData).item):CanResolve())
  else
    ;
    (self._grayIcon):SetActive(false)
  end
end

BagCell.OnCellClicked = function(self, args, luawindow)
  -- function num : 0_6 , upvalues : ItemTypeEnum, _ENV
  if not (self._cellData).item then
    return 
  end
  if (self._delegate).IfInResolveMode and (self._delegate):IfInResolveMode() and ((self._cellData).item):CanResolve() then
    self:OnResolve()
  end
  do return  end
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
    -- function num : 0_6_0 , upvalues : self
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
    -- function num : 0_6_1 , upvalues : self
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
      if (self._delegate).IsBag then
        tipsDialog:Init(self._cellData, ((self._delegate).IsBag)())
        tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
      end
    end
  end
end

BagCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_7
  if not (self._cellData).item then
    return 
  end
  if ((self._cellData).item):GetKey() ~= arg then
    (self._Select):SetActive(eventName ~= "ChangedSelected")
    -- DECOMPILER ERROR at PC35: Unhandled construct in 'MakeBoolean' P1

    if eventName == "RefreshCell" and (not arg.item or ((self._cellData).item):GetKey() == (arg.item):GetKey()) then
      self:RefreshCell(arg)
    end
    if eventName == "SetResoveModelState" then
      self:SetResoveModelState(arg)
    end
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end
end

BagCell.OnResolve = function(self)
  -- function num : 0_8 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("bag.itemresolvedialog")):Init((self._cellData).item)
end

return BagCell

