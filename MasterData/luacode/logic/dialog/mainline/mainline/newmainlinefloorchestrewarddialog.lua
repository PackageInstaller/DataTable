local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local MainLineTable = BeanManager.GetTableByName("dungeonselect.cdungeonselectmainline")
local UIManager = CS.PixelNeko.UI.UIManager
local NewMainlineFloorChestRewardDialog = class("NewMainlineFloorChestRewardDialog", Dialog)
NewMainlineFloorChestRewardDialog.AssetBundleName = "ui/layouts.mainline"
NewMainlineFloorChestRewardDialog.AssetName = "DungeonSelectChestReward"

function NewMainlineFloorChestRewardDialog:Ctor(...)
  NewMainlineFloorChestRewardDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function NewMainlineFloorChestRewardDialog:OnCreate()
  self._getBtn = self:GetChild("Back2/GetBtn")
  self._haveGottenBtn = self:GetChild("Back2/GetBtn1")
  self._haveGottenBtn:SetActive(false)
  self._haveGottenBtn:SetInteractable(false)
  self._panel = self:GetChild("Back2/Frame")
  self._progress = self:GetChild("Loading/Loading/BackGround/Progress")
  self._num = self:GetChild("Loading/Num/Num")
  self._backPanel = self:GetChild("Back2")
  self._frame = TableFrame.Create(self._panel, self, false, false)
  self._rx, self._ry = self._panel:GetRectSize()
  self._xs, self._xso, self._ys, self._yso = self._panel:GetSize()
  self._xp, self._xpo, self._yp, self._ypo = self._panel:GetPosition()
  self._getBtn:Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCloseBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnReceive, Common.n_ReceiveDungeonPointAward, nil)
end

function NewMainlineFloorChestRewardDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._frame:Destroy()
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
end

function NewMainlineFloorChestRewardDialog:SetData(data)
  self._data = data
  if data.award.isReceived == 1 then
    self._getBtn:SetActive(false)
    self._haveGottenBtn:SetActive(true)
  else
    self._getBtn:SetActive(true)
    self._haveGottenBtn:SetActive(false)
  end
  if self._data.award.openedBoxes ~= self._data.award.totalBoxes then
    self._getBtn:SetInteractable(false)
  end
  self._item = {}
  local record = MainLineTable:GetRecorder(data.id)
  for i, id in ipairs(record.chestrewardItems) do
    local item = Item.Create(id)
    table.insert(self._item, {
      item = item,
      num = record.chestrewardItemNums[i]
    })
  end
  self._frame:ReloadAllCell()
  local totalLength = self._frame:GetTotalLength()
  local delta = (self._rx - totalLength) / 2
  self._panel:SetSize(0, totalLength, self._ys, self._yso)
  self._panel:SetPosition(self._xp, self._xpo + delta, self._yp, self._ypo)
  self._frame:ReloadAllCell()
  self._num:SetText(tostring(self._data.award.openedBoxes) .. "/" .. tostring(self._data.award.totalBoxes))
  self._progress:SetFillAmount(self._data.award.openedBoxes / self._data.award.totalBoxes)
end

function NewMainlineFloorChestRewardDialog:OnGetBtnClicked()
  if self._data.award.openedBoxes == self._data.award.totalBoxes then
    local csend = LuaNetManager.CreateProtocol("protocol.battle.creceivedungeonpointaward")
    csend.id = self._data.id
    csend:Send()
  end
end

function NewMainlineFloorChestRewardDialog:NumberOfCell(frame)
  return #self._item
end

function NewMainlineFloorChestRewardDialog:CellAtIndex(frame)
  return "mainline.mainline.newmainlinefloorchestrewardcell"
end

function NewMainlineFloorChestRewardDialog:DataAtIndex(frame, index)
  return self._item[index]
end

function NewMainlineFloorChestRewardDialog:OnReceive()
  self._haveGottenBtn:SetActive(true)
  self._getBtn:SetActive(false)
  self:Destroy()
end

function NewMainlineFloorChestRewardDialog:OnCloseBtnClicked(args)
  if not UIManager.RectangleContainsScreenPoint(self._backPanel._uiObject, args.position.x, args.position.y) then
    self:OnBackBtnClicked()
  end
end

function NewMainlineFloorChestRewardDialog:OnBackBtnClicked()
  self:Destroy()
end

return NewMainlineFloorChestRewardDialog
