-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tower/towermaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TowerMainDialog = class("TowerMainDialog", Dialog)
TowerMainDialog.AssetBundleName = "ui/layouts.mainline"
TowerMainDialog.AssetName = "TowerMain"
TowerMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerMainDialog
  ((TowerMainDialog.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

TowerMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._leftTimeTxt = self:GetChild("Num/Num")
  self._refreshTime = self:GetChild("Refresh/Time")
  self._cellArea = self:GetChild("Frame")
  self._iBtn = self:GetChild("Ibtn")
  ;
  (self._iBtn):Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  self._cellFrame = (TableFrame.Create)(self._cellArea, self, false, true, false)
end

TowerMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._cellFrame):Destroy()
  if self._gameTimer then
    (ServerGameTimer.RemoveTask)(self._gameTimer)
    self._gameTimer = nil
  end
end

TowerMainDialog.RefreshCell = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV, CStringRes
  self._cellList = {}
  self._challengingID = protocol.challenging
  self._totalChance = protocol.totalChance
  self._chanceLeft = protocol.chanceLeft
  for i,v in ipairs(protocol.towerUnlock) do
    (table.insert)(self._cellList, {id = i, islock = v})
  end
  if self._gameTimer then
    (ServerGameTimer.RemoveTask)(self._gameTimer)
    self._gameTimer = nil
  end
  ;
  (self._leftTimeTxt):SetText(self._chanceLeft)
  self._leftTime = protocol.resetTimeLeft // 1000
  self._gameTimer = (GameTimer.AddTask)(0, 1, function()
    -- function num : 0_3_0 , upvalues : self, _ENV, CStringRes
    self._leftTime = self._leftTime - 1
    if self._leftTime <= 0 then
      return 
    end
    local day = self._leftTime // 60 // 60 // 24
    local hour = (self._leftTime - day * 24 * 60 * 60) // 60 // 60
    local min = (self._leftTime - day * 24 * 60 * 60 - hour * 60 * 60) // 60
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1215)).msgTextID)
    str = (string.gsub)(str, "%$parameter1%$", day)
    str = (string.gsub)(str, "%$parameter2%$", hour)
    str = (string.gsub)(str, "%$parameter3%$", min)
    ;
    (self._refreshTime):SetText(str)
  end
, nil)
  ;
  (self._cellFrame):ReloadAllCell()
end

TowerMainDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._cellList
end

TowerMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "tower.towermaincell"
end

TowerMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  local data = {}
  data.id = ((self._cellList)[index]).id
  data.islock = ((self._cellList)[index]).islock
  data.ischallenging = ((self._cellList)[index]).id == self._challengingID
  do return data end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

TowerMainDialog.OnIBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("tower.toweritips")
end

return TowerMainDialog

