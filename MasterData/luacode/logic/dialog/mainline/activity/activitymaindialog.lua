local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CArenaSeasonConfig = BeanManager.GetTableByName("dungeonselect.carenaseasonconfig")
local ActivityMainDialog = class("ActivityMainDialog", Dialog)
ActivityMainDialog.AssetBundleName = "ui/layouts.mainline"
ActivityMainDialog.AssetName = "ActivityMain"
local oneline = 4
local slideRow = 2

function ActivityMainDialog:Ctor(...)
  ActivityMainDialog.super.Ctor(self, ...)
  self._data = {}
end

function ActivityMainDialog:OnCreate()
  self._field = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._field, self, false, true)
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(6)
end

function ActivityMainDialog:OnDestroy()
  if self._frame then
    self._frame:Destroy()
  end
  UIBackManager.SetUIBackShow(false)
end

function ActivityMainDialog:RefreshCell(data)
  self._data = clone(data)
  for k, v in pairs(self._data) do
    if #v.data == 1 and v.data[1].id == 3 and not NekoData.BehaviorManager.BM_TowerV2:IsOpen() then
      table.remove(self._data, k)
      break
    end
  end
  if self._frame then
    self._frame:Destroy()
    self._frame = nil
  end
  if #self._data > oneline then
    self._frame = TableFrame.Create(self._field, self, false, true)
  elseif #self._data > oneline * slideRow then
    self._frame = TableFrame.Create(self._field, self, false, true)
  else
    self._frame = GridFrame.Create(self._field, self, true, oneline, false)
  end
  self._frame:ReloadAllCell()
end

function ActivityMainDialog:NumberOfCell(frame)
  return #self._data
end

function ActivityMainDialog:CellAtIndex(frame, index)
  if #self._data[index].data == 1 then
    if self._data[index].data[1].id == 3 then
      return "mainline.activity.towerv2cell"
    end
    return "mainline.activity.activitymaincell"
  else
    return "mainline.activity.activitymainbosscell"
  end
end

function ActivityMainDialog:DataAtIndex(frame, index)
  if #self._data[index].data == 1 then
    return self._data[index].data[1]
  else
    return self._data[index].data
  end
end

function ActivityMainDialog:OnWorldIClicked(id)
  if id == 1 then
    if NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(49) then
      NekoData.BehaviorManager.BM_Guide:FinishGuide(49)
    end
    local csend = LuaNetManager.CreateProtocol("protocol.activity.cgetshatteredzonesinfo")
    csend:Send()
  elseif id == 2 then
    DialogManager.GetDialog("mainline.mainline.mainlineworlddialog"):OpenBossRushPanel()
  elseif id == 3 then
    if NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(26) then
      NekoData.BehaviorManager.BM_Guide:FinishGuide(26)
    end
    NekoData.BehaviorManager.BM_TowerV2:TryEnter()
  elseif id == 4 then
    if NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(47) then
      NekoData.BehaviorManager.BM_Guide:FinishGuide(47)
    end
    local protocol = LuaNetManager.CreateProtocol("protocol.battle.copenarenapanel")
    if protocol then
      protocol:Send()
    end
  elseif id == 5 then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.copenundecidedroad")
    csend:Send()
    local dialog = DialogManager.CreateSingletonDialog("mainline.undecidedroad.undecidedroadmaindialog")
    dialog:Init()
  elseif id == 6 then
    DialogManager.GetDialog("mainline.mainline.mainlineworlddialog"):OpenWeekBossDialog()
  elseif id == 7 then
    if NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(47) then
      NekoData.BehaviorManager.BM_Guide:FinishGuide(47)
    end
    local fantasyProtocol = LuaNetManager.CreateProtocol("protocol.battle.cfantasyconflictopenpanel")
    if fantasyProtocol then
      fantasyProtocol:Send()
    end
  end
end

return ActivityMainDialog
