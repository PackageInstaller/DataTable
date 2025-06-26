-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/dungeonuseitemssecondconfirm.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIInteraction = require("logic.scene.interaction.uiinteraction")
local DungeonUseItemsSecondConfirm = class("DungeonUseItemsSecondConfirm", Dialog)
DungeonUseItemsSecondConfirm.AssetBundleName = "ui/layouts.dungeon"
DungeonUseItemsSecondConfirm.AssetName = "DungeonItemUse"
DungeonUseItemsSecondConfirm.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonUseItemsSecondConfirm
  ((DungeonUseItemsSecondConfirm.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._whichitem = nil
end

DungeonUseItemsSecondConfirm.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._confirmBtn = self:GetChild("ConfirmButton")
  self._cancelBtn = self:GetChild("CancelButton")
  self._items = self:GetChild("ItemFrame")
  self._frame = (TableFrame.Create)(self._items, self, false, false, false)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmClick, self)
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._itemSizeX = (self._items):GetRectSize()
  self._itemSX = (self._items):GetSize()
  self._itemPX = (self._items):GetPosition()
end

DungeonUseItemsSecondConfirm.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

DungeonUseItemsSecondConfirm.SetData = function(self, eventid, data)
  -- function num : 0_3 , upvalues : _ENV
  self._eventID = eventid
  self._data = {}
  self._whichitem = data[1]
  local s = {}
  for _,v in pairs(data) do
    s = {}
    s.delegate = self
    s.data = v
    ;
    (table.insert)(self._data, s)
  end
  ;
  (self._frame):ReloadAllCell()
  self:SetItemSize()
end

DungeonUseItemsSecondConfirm.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._data
end

DungeonUseItemsSecondConfirm.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "dungeon.dungeonuseitemssecondconfirmcell"
end

DungeonUseItemsSecondConfirm.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._data)[index]
end

DungeonUseItemsSecondConfirm.GetTotalLength = function(self)
  -- function num : 0_7
  return (self._frame):GetTotalLength()
end

DungeonUseItemsSecondConfirm.OnConfirmClick = function(self)
  -- function num : 0_8 , upvalues : _ENV, UIInteraction
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  if controller then
    if self._whichitem then
      (UIInteraction.RemoveUIReactEvent)(controller, self._eventID, self._whichitem)
    else
      LogError("DungeonUseItemsSecondConfirm", "there is no item can be used")
    end
  else
    LogError("DungeonUseItemsSecondConfirm", "there is no scene controller")
  end
  self:Destroy()
end

DungeonUseItemsSecondConfirm.OnBackBtnClicked = function(self)
  -- function num : 0_9
  self:Destroy()
end

DungeonUseItemsSecondConfirm.SetItemSize = function(self)
  -- function num : 0_10
  local length = self:GetTotalLength()
  if length ~= self._itemsSizeX then
    local diff = self._itemSizeX - length
    ;
    (self._items):SetSize(self._itemSX, self._itemSOX - diff, self._itemSY, self._itemSOY)
    ;
    (self._items):SetPosition(self._itemPX, self._itemPOX + diff / 2, self._itemPY, self._itemPOY)
  end
end

return DungeonUseItemsSecondConfirm

