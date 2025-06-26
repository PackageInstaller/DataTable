-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/mainline/newmainlinefloorchestrewarddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local MainLineTable = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local UIManager = ((CS.PixelNeko).UI).UIManager
local NewMainlineFloorChestRewardDialog = class("NewMainlineFloorChestRewardDialog", Dialog)
NewMainlineFloorChestRewardDialog.AssetBundleName = "ui/layouts.mainline"
NewMainlineFloorChestRewardDialog.AssetName = "DungeonSelectChestReward"
NewMainlineFloorChestRewardDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NewMainlineFloorChestRewardDialog
  ((NewMainlineFloorChestRewardDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

NewMainlineFloorChestRewardDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._getBtn = self:GetChild("Back2/GetBtn")
  self._haveGottenBtn = self:GetChild("Back2/GetBtn1")
  ;
  (self._haveGottenBtn):SetActive(false)
  ;
  (self._haveGottenBtn):SetInteractable(false)
  self._panel = self:GetChild("Back2/Frame")
  self._progress = self:GetChild("Loading/Loading/BackGround/Progress")
  self._num = self:GetChild("Loading/Num/Num")
  self._backPanel = self:GetChild("Back2")
  self._frame = (TableFrame.Create)(self._panel, self, false, false)
  self._rx = (self._panel):GetRectSize()
  self._xs = (self._panel):GetSize()
  self._xp = (self._panel):GetPosition()
  ;
  (self._getBtn):Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCloseBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnReceive, Common.n_ReceiveDungeonPointAward, nil)
end

NewMainlineFloorChestRewardDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._frame):Destroy()
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
end

NewMainlineFloorChestRewardDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : MainLineTable, _ENV, Item
  self._data = data
  if (data.award).isReceived == 1 then
    (self._getBtn):SetActive(false)
    ;
    (self._haveGottenBtn):SetActive(true)
  else
    ;
    (self._getBtn):SetActive(true)
    ;
    (self._haveGottenBtn):SetActive(false)
  end
  if ((self._data).award).openedBoxes ~= ((self._data).award).totalBoxes then
    (self._getBtn):SetInteractable(false)
  end
  self._item = {}
  local record = MainLineTable:GetRecorder(data.id)
  for i,id in ipairs(record.chestrewardItems) do
    local item = (Item.Create)(id)
    ;
    (table.insert)(self._item, {item = item, num = (record.chestrewardItemNums)[i]})
  end
  ;
  (self._frame):ReloadAllCell()
  local totalLength = (self._frame):GetTotalLength()
  local delta = (self._rx - totalLength) / 2
  ;
  (self._panel):SetSize(0, totalLength, self._ys, self._yso)
  ;
  (self._panel):SetPosition(self._xp, self._xpo + delta, self._yp, self._ypo)
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._num):SetText(tostring(((self._data).award).openedBoxes) .. "/" .. tostring(((self._data).award).totalBoxes))
  ;
  (self._progress):SetFillAmount(((self._data).award).openedBoxes / ((self._data).award).totalBoxes)
end

NewMainlineFloorChestRewardDialog.OnGetBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if ((self._data).award).openedBoxes == ((self._data).award).totalBoxes then
    local csend = (LuaNetManager.CreateProtocol)("protocol.battle.creceivedungeonpointaward")
    csend.id = (self._data).id
    csend:Send()
  end
end

NewMainlineFloorChestRewardDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._item
end

NewMainlineFloorChestRewardDialog.CellAtIndex = function(self, frame)
  -- function num : 0_6
  return "mainline.mainline.newmainlinefloorchestrewardcell"
end

NewMainlineFloorChestRewardDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._item)[index]
end

NewMainlineFloorChestRewardDialog.OnReceive = function(self)
  -- function num : 0_8
  (self._haveGottenBtn):SetActive(true)
  ;
  (self._getBtn):SetActive(false)
  self:Destroy()
end

NewMainlineFloorChestRewardDialog.OnCloseBtnClicked = function(self, args)
  -- function num : 0_9 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._backPanel)._uiObject, (args.position).x, (args.position).y) then
    self:OnBackBtnClicked()
  end
end

NewMainlineFloorChestRewardDialog.OnBackBtnClicked = function(self)
  -- function num : 0_10
  self:Destroy()
end

return NewMainlineFloorChestRewardDialog

