local TableFrame = require("framework.ui.frame.table.tableframe")
local UIInteraction = require("logic.scene.interaction.uiinteraction")
local DungeonUseItemsSecondConfirm = class("DungeonUseItemsSecondConfirm", Dialog)
DungeonUseItemsSecondConfirm.AssetBundleName = "ui/layouts.dungeon"
DungeonUseItemsSecondConfirm.AssetName = "DungeonItemUse"

function DungeonUseItemsSecondConfirm:Ctor(...)
  DungeonUseItemsSecondConfirm.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._whichitem = nil
end

function DungeonUseItemsSecondConfirm:OnCreate()
  self._confirmBtn = self:GetChild("ConfirmButton")
  self._cancelBtn = self:GetChild("CancelButton")
  self._items = self:GetChild("ItemFrame")
  self._frame = TableFrame.Create(self._items, self, false, false, false)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmClick, self)
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._itemSizeX, self._itemsSizeY = self._items:GetRectSize()
  self._itemSX, self._itemSOX, self._itemSY, self._itemSOY = self._items:GetSize()
  self._itemPX, self._itemPOX, self._itemPY, self._itemPOY = self._items:GetPosition()
end

function DungeonUseItemsSecondConfirm:OnDestroy()
  self._frame:Destroy()
end

function DungeonUseItemsSecondConfirm:SetData(eventid, data)
  self._eventID = eventid
  self._data = {}
  self._whichitem = data[1]
  local s = {}
  for _, v in pairs(data) do
    s = {}
    s.delegate = self
    s.data = v
    table.insert(self._data, s)
  end
  self._frame:ReloadAllCell()
  self:SetItemSize()
end

function DungeonUseItemsSecondConfirm:NumberOfCell(frame)
  return #self._data
end

function DungeonUseItemsSecondConfirm:CellAtIndex(frame, index)
  return "dungeon.dungeonuseitemssecondconfirmcell"
end

function DungeonUseItemsSecondConfirm:DataAtIndex(frame, index)
  return self._data[index]
end

function DungeonUseItemsSecondConfirm:GetTotalLength()
  return self._frame:GetTotalLength()
end

function DungeonUseItemsSecondConfirm:OnConfirmClick()
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  if controller then
    if self._whichitem then
      UIInteraction.RemoveUIReactEvent(controller, self._eventID, self._whichitem)
    else
      LogError("DungeonUseItemsSecondConfirm", "there is no item can be used")
    end
  else
    LogError("DungeonUseItemsSecondConfirm", "there is no scene controller")
  end
  self:Destroy()
end

function DungeonUseItemsSecondConfirm:OnBackBtnClicked()
  self:Destroy()
end

function DungeonUseItemsSecondConfirm:SetItemSize()
  local length = self:GetTotalLength()
  if length ~= self._itemsSizeX then
    local diff = self._itemSizeX - length
    self._items:SetSize(self._itemSX, self._itemSOX - diff, self._itemSY, self._itemSOY)
    self._items:SetPosition(self._itemPX, self._itemPOX + diff / 2, self._itemPY, self._itemPOY)
  end
end

return DungeonUseItemsSecondConfirm
