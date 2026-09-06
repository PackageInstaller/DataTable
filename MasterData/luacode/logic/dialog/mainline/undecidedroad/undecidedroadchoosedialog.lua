local TableFrame = require("framework.ui.frame.table.tableframe")
local UndecidedRoadChooseDialog = class("UndecidedRoadChooseDialog", Dialog)
UndecidedRoadChooseDialog.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadChooseDialog.AssetName = "ActivityRoadChoose"

function UndecidedRoadChooseDialog:Ctor(...)
  UndecidedRoadChooseDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._data = {}
end

function UndecidedRoadChooseDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._panel = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._panel, self, false, true, false)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_EnterMianCity, nil)
end

function UndecidedRoadChooseDialog:OnDestroy()
  DialogManager.DestroySingletonDialog("mainline.undecidedroad.undecidedroadbossrecorddialog")
  DialogManager.DestroySingletonDialog("mainline.undecidedroad.undecidedroadrecorddialog")
  self._frame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function UndecidedRoadChooseDialog:SetData(data)
  while #self._data > 0 do
    table.remove(self._data, #self._data)
  end
  local id = 1
  for _, v in pairs(data.trainsInfo) do
    local temp = {
      id = id,
      battleId = v.battleId,
      score = v.score
    }
    table.insert(self._data, temp)
    id = id + 1
  end
  local lastPos = self._frame:GetCurrentPosition()
  self._frame:ReloadAllCell()
  if lastPos then
    self._frame:MoveToAssignedPos(lastPos)
  end
end

function UndecidedRoadChooseDialog:NumberOfCell(frame)
  return #self._data
end

function UndecidedRoadChooseDialog:CellAtIndex(frame, index)
  return "mainline.undecidedroad.undecidedroadchoosecell"
end

function UndecidedRoadChooseDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function UndecidedRoadChooseDialog:OnBackBtnClicked()
  self:Destroy()
end

function UndecidedRoadChooseDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function UndecidedRoadChooseDialog:Refresh()
  local csend = LuaNetManager.CreateProtocol("protocol.activity.copentrain")
  if csend then
    csend:Send()
  end
end

return UndecidedRoadChooseDialog
