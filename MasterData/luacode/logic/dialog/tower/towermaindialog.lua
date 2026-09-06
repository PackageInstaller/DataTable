local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local TowerMainDialog = class("TowerMainDialog", Dialog)
TowerMainDialog.AssetBundleName = "ui/layouts.mainline"
TowerMainDialog.AssetName = "TowerMain"

function TowerMainDialog:Ctor(...)
  TowerMainDialog.super.Ctor(self, ...)
  self._groupName = "Cell"
end

function TowerMainDialog:OnCreate()
  self._leftTimeTxt = self:GetChild("Num/Num")
  self._refreshTime = self:GetChild("Refresh/Time")
  self._cellArea = self:GetChild("Frame")
  self._iBtn = self:GetChild("Ibtn")
  self._iBtn:Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  self._cellFrame = TableFrame.Create(self._cellArea, self, false, true, false)
end

function TowerMainDialog:OnDestroy()
  self._cellFrame:Destroy()
  if self._gameTimer then
    ServerGameTimer.RemoveTask(self._gameTimer)
    self._gameTimer = nil
  end
end

function TowerMainDialog:RefreshCell(protocol)
  self._cellList = {}
  self._challengingID = protocol.challenging
  self._totalChance = protocol.totalChance
  self._chanceLeft = protocol.chanceLeft
  for i, v in ipairs(protocol.towerUnlock) do
    table.insert(self._cellList, {id = i, islock = v})
  end
  if self._gameTimer then
    ServerGameTimer.RemoveTask(self._gameTimer)
    self._gameTimer = nil
  end
  self._leftTimeTxt:SetText(self._chanceLeft)
  self._leftTime = protocol.resetTimeLeft // 1000
  self._gameTimer = GameTimer.AddTask(0, 1, function()
    self._leftTime = self._leftTime - 1
    if self._leftTime <= 0 then
      return
    end
    local day = self._leftTime // 60 // 60 // 24
    local hour = (self._leftTime - day * 24 * 60 * 60) // 60 // 60
    local min = (self._leftTime - day * 24 * 60 * 60 - hour * 60 * 60) // 60
    local str = TextManager.GetText(CStringRes:GetRecorder(1215).msgTextID)
    str = string.gsub(str, "%$parameter1%$", day)
    str = string.gsub(str, "%$parameter2%$", hour)
    str = string.gsub(str, "%$parameter3%$", min)
    self._refreshTime:SetText(str)
  end, nil)
  self._cellFrame:ReloadAllCell()
end

function TowerMainDialog:NumberOfCell(frame)
  return #self._cellList
end

function TowerMainDialog:CellAtIndex(frame, index)
  return "tower.towermaincell"
end

function TowerMainDialog:DataAtIndex(frame, index)
  local data = {}
  data.id = self._cellList[index].id
  data.islock = self._cellList[index].islock
  data.ischallenging = self._cellList[index].id == self._challengingID
  return data
end

function TowerMainDialog:OnIBtnClicked()
  DialogManager.CreateSingletonDialog("tower.toweritips")
end

return TowerMainDialog
