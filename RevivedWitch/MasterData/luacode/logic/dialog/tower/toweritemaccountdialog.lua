-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tower/toweritemaccountdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local Equip = require("logic.manager.experimental.types.equip")
local Skill = require("logic.manager.experimental.types.skill")
local TowerItemAccountDialog = class("TowerItemAccountDialog", Dialog)
TowerItemAccountDialog.AssetBundleName = "ui/layouts.dungeon"
TowerItemAccountDialog.AssetName = "DungeonItemAccount"
TowerItemAccountDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerItemAccountDialog
  ((TowerItemAccountDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._dataList = {}
  self._cellInfo = {}
  self._taskList = {}
  self._height = 0
  self._width = 0
end

TowerItemAccountDialog.OnCreate = function(self)
  -- function num : 0_1
  self._width = (self:GetRootWindow()):GetRectSize()
end

TowerItemAccountDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._appearTask then
    (GameTimer.RemoveTask)(self._appearTask)
    self._appearTask = nil
  end
  for i,v in ipairs(self._taskList) do
    (GameTimer.RemoveTask)(v)
    v = nil
  end
  for i,v in ipairs(self._cellInfo) do
    if v.cell then
      (v.cell):Destroy()
      ;
      (v.cell):RootWindowDestroy()
      v.cell = nil
    end
  end
end

TowerItemAccountDialog.SetData = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV, ItemTypeEnum, Item, Equip, Skill
  local itemAccounts = {}
  for i,v in ipairs(protocol.items) do
    local item = nil
    if v.gain == 1 then
      if v.itemtype == ItemTypeEnum.BASEITEM then
        item = ((NekoData.BehaviorManager).BM_BagInfo):GetItemWithBagType(v.bagtype, v.id)
      else
        if v.itemtype == ItemTypeEnum.EQUIP then
          item = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(v.id)
        end
      end
    else
      if v.itemtype == ItemTypeEnum.BASEITEM then
        item = (Item.Create)(v.id)
      else
        if v.itemtype == ItemTypeEnum.EQUIP then
          item = (Equip.Create)(v.id)
        else
          if v.itemtype == ItemTypeEnum.SKILL then
            item = (Skill.Create)(v.id)
          end
        end
      end
      if item then
        item:InitWithItemInfo(v)
      end
    end
    if item then
      (table.insert)(itemAccounts, {item = item, num = v.number})
    else
      LogErrorFormat("TowerItemAccountDialog", "bagtype %s item gain %s itemtype %s protocol.id %s", v.bagtype, v.gain, v.itemtype, v.id)
    end
  end
  ;
  (table.sort)(itemAccounts, function(a, b)
    -- function num : 0_3_0
    do return (a.item):GetRank() < (b.item):GetRank() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for i,v in ipairs(itemAccounts) do
    local celldata = {}
    celldata.id = (v.item):GetID()
    celldata.num = v.num
    celldata.name = (v.item):GetName()
    ;
    (table.insert)(self._dataList, celldata)
  end
  if #self._dataList ~= 0 then
    self:ProcessData()
  end
end

TowerItemAccountDialog.ProcessData = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local itemCell = {}
  itemCell.cell = (DialogManager.CreateDialog)("dungeon.dungeonitemaccountcell", (self:GetRootWindow())._uiObject)
  ;
  (itemCell.cell):Refresh((self._dataList)[1])
  ;
  (table.remove)(self._dataList, 1)
  if self._appearTask then
    (GameTimer.RemoveTask)(self._appearTask)
    self._appearTask = nil
  end
  self._appearTask = (GameTimer.AddTask)(0.5, -1, function()
    -- function num : 0_4_0 , upvalues : self
    self._appearTask = nil
    if #self._dataList ~= 0 then
      self:ProcessData()
    end
  end
)
  local _, height = ((itemCell.cell):GetRootWindow()):GetRectSize()
  ;
  ((itemCell.cell):GetRootWindow()):SetYPosition(0, 0)
  ;
  (table.insert)(self._cellInfo, 1, itemCell)
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._taskList)[#self._cellInfo] = (GameTimer.AddTask)(1, 0, function()
    -- function num : 0_4_1 , upvalues : self, _ENV
    if #self._cellInfo > 0 and (self._cellInfo)[#self._cellInfo] and ((self._cellInfo)[#self._cellInfo]).cell then
      (((self._cellInfo)[#self._cellInfo]).cell):Destroy()
      if (((self._cellInfo)[#self._cellInfo]).cell):GetRootWindow() then
        (((self._cellInfo)[#self._cellInfo]).cell):RootWindowDestroy()
      end
      -- DECOMPILER ERROR at PC44: Confused about usage of register: R0 in 'UnsetPending'

      ;
      ((self._cellInfo)[#self._cellInfo]).cell = nil
      ;
      (table.remove)(self._cellInfo, #self._cellInfo)
    end
    if #self._cellInfo <= 0 then
      self:OnRefresh()
    end
  end
, nil)
  self:OnRefresh()
end

TowerItemAccountDialog.OnRefresh = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if #self._cellInfo == 0 then
    if #self._dataList == 0 then
      self:Destroy()
    end
    return 
  end
  local _, height = ((((self._cellInfo)[1]).cell):GetRootWindow()):GetRectSize()
  local deltaHeight = 0
  local deleteIndexList = {}
  for index = 2, #self._cellInfo do
    local w, h = ((((self._cellInfo)[index - 1]).cell):GetRootWindow()):GetRectSize()
    deltaHeight = deltaHeight + h
    ;
    ((((self._cellInfo)[index]).cell):GetRootWindow()):SetYPosition(0, deltaHeight)
    if self._height < deltaHeight + h then
      (table.insert)(deleteIndexList, index)
    end
  end
  do
    while deleteIndexList[#deleteIndexList] do
      local index = deleteIndexList[#deleteIndexList]
      if (self._cellInfo)[index] and ((self._cellInfo)[index]).cell then
        (((self._cellInfo)[index]).cell):Destroy()
        if (((self._cellInfo)[index]).cell):GetRootWindow() then
          (((self._cellInfo)[index]).cell):RootWindowDestroy()
        end
        -- DECOMPILER ERROR at PC87: Confused about usage of register: R6 in 'UnsetPending'

        ;
        ((self._cellInfo)[index]).cell = nil
        ;
        (table.remove)(self._cellInfo, index)
      end
      ;
      (table.remove)(deleteIndexList, #deleteIndexList)
    end
  end
end

return TowerItemAccountDialog

