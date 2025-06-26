-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/mainline/newmainlinefloorworldrewarddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local WorldTable = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectworld")
local UIManager = ((CS.PixelNeko).UI).UIManager
local NewMainlineFloorWorldRewardDialog = class("NewMainlineFloorWorldRewardDialog", Dialog)
NewMainlineFloorWorldRewardDialog.AssetBundleName = "ui/layouts.mainline"
NewMainlineFloorWorldRewardDialog.AssetName = "DungeonSelectWorldReward"
NewMainlineFloorWorldRewardDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NewMainlineFloorWorldRewardDialog
  ((NewMainlineFloorWorldRewardDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

NewMainlineFloorWorldRewardDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._getBtn = self:GetChild("Back2/GetBtn")
  self._haveGottenTxt = self:GetChild("Back2/GetTxt")
  ;
  (self._haveGottenTxt):SetActive(false)
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
  (LuaNotificationCenter.AddObserver)(self, self.OnReceive, Common.n_ReceiveDungeonWorldAward, nil)
end

NewMainlineFloorWorldRewardDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._frame):Destroy()
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
end

NewMainlineFloorWorldRewardDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : WorldTable, _ENV, Item
  self._data = data
  if data.isReceived == 1 then
    (self._getBtn):SetActive(false)
    ;
    (self._haveGottenTxt):SetActive(true)
  else
    ;
    (self._getBtn):SetActive(true)
    ;
    (self._haveGottenTxt):SetActive(false)
  end
  if (self._data).clearZones ~= (self._data).totalZones then
    (self._getBtn):SetInteractable(false)
  end
  self._item = {}
  local record = WorldTable:GetRecorder(data.worldId)
  for i,id in ipairs(record.worldrewardItems) do
    local item = (Item.Create)(id)
    ;
    (table.insert)(self._item, {item = item, num = (record.worldrewardItemNums)[i]})
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
  (self._num):SetText(tostring((self._data).clearZones) .. "/" .. tostring((self._data).totalZones))
  ;
  (self._progress):SetFillAmount((self._data).clearZones / (self._data).totalZones)
end

NewMainlineFloorWorldRewardDialog.OnGetBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (self._data).clearZones == (self._data).totalZones then
    local csend = (LuaNetManager.CreateProtocol)("protocol.battle.creceivedungeonworldaward")
    csend.id = (self._data).worldId
    csend:Send()
  end
end

NewMainlineFloorWorldRewardDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._item
end

NewMainlineFloorWorldRewardDialog.CellAtIndex = function(self, frame)
  -- function num : 0_6
  return "mainline.mainline.newmainlinefloorworldrewardcell"
end

NewMainlineFloorWorldRewardDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._item)[index]
end

NewMainlineFloorWorldRewardDialog.OnReceive = function(self)
  -- function num : 0_8
  (self._haveGottenTxt):SetActive(true)
  ;
  (self._getBtn):SetActive(false)
  self:Destroy()
end

NewMainlineFloorWorldRewardDialog.OnCloseBtnClicked = function(self, args)
  -- function num : 0_9 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._backPanel)._uiObject, (args.position).x, (args.position).y) then
    self:OnBackBtnClicked()
  end
end

NewMainlineFloorWorldRewardDialog.OnBackBtnClicked = function(self)
  -- function num : 0_10
  self:Destroy()
end

return NewMainlineFloorWorldRewardDialog

