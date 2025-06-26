-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/activity/towerv2cell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TypeInfoTable = (BeanManager.GetTableByName)("dungeonselect.cresourcedungeontype")
local ImageTable = (BeanManager.GetTableByName)("ui.cimagepath")
local TowerV2Cell = class("TowerV2Cell", Dialog)
TowerV2Cell.AssetBundleName = "ui/layouts.mainline"
TowerV2Cell.AssetName = "ActivityMainCell"
local Activit = {Fragment = 1, BossRush = 2, Tower = 3, OffLinePvp = 4, UndecidedRoad = 5}
TowerV2Cell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerV2Cell
  ((TowerV2Cell.super).Ctor)(self, ...)
end

TowerV2Cell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._panel = self:GetChild("Panel")
  self._img = self:GetChild("Panel/Map")
  self._grey = self:GetChild("Panel/Grey")
  self._lockTxt = self:GetChild("Panel/LockTxt")
  self._name = self:GetChild("Panel/Title")
  self._back = self:GetChild("Panel/Back")
  self._numPanel = self:GetChild("Panel/Num")
  self._num = self:GetChild("Panel/Num/Num")
  self._maxNumber = self:GetChild("Panel/MaxNum")
  ;
  (self._numPanel):SetActive(false)
  self._redDot = self:GetChild("Panel/RedDot")
  self._waitingBack = self:GetChild("Panel/timeback")
  self._waitingText = self:GetChild("Panel/TimeTxt")
  self._openText = {close = self:GetChild("Panel/StairClose"), open = self:GetChild("Panel/StairOpen")}
  ;
  (self._panel):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshOpenState, Common.n_TowerV2OpenState, nil)
  self._time = 0
end

TowerV2Cell.OnDestroy = function(self)
  -- function num : 0_2
end

TowerV2Cell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, ImageTable, Activit
  self._data = data
  ;
  (self._name):SetText((TextManager.GetText)(data.name))
  local imageRecord = ImageTable:GetRecorder(data.imageID)
  ;
  (self._img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._redDot):SetActive((data.id == Activit.BossRush and ((NekoData.BehaviorManager).BM_Game):IsBossPanelShowRed()))
  self:RefreshOpenState()
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

TowerV2Cell.RefreshOpenState = function(self)
  -- function num : 0_4 , upvalues : _ENV, Activit
  self._time = 0
  self.lock = not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Tower)
  ;
  (self._grey):SetActive(self.lock)
  ;
  (self._lockTxt):SetActive(self.lock)
  ;
  (self._lockTxt):SetText((TextManager.GetText)((self._data).unlockTxt))
  if not self.lock then
    local open = false
    local close = (not open and not self.lock)
    ;
    (self._grey):SetActive(close)
    ;
    ((self._openText).open):SetActive(close)
    ;
    ((self._openText).close):SetActive(not close)
    ;
    (self._waitingText):SetActive(true)
  end
  ;
  (self._grey):SetActive(true)
  if (self._data).id == Activit.Tower then
    ((self._openText).open):SetActive(false)
    ;
    ((self._openText).close):SetActive(false)
    ;
    (self._waitingText):SetText((TextManager.GetText)(1901196))
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

TowerV2Cell.OnUpdate = function(self, deltaTime, unscaledDeltaTime)
  -- function num : 0_5
  self._time = self._time + deltaTime
  if self._time > 60 then
    self:RefreshOpenState()
  end
end

TowerV2Cell.OnCellClicked = function(self)
  -- function num : 0_6 , upvalues : Activit, _ENV
  if (self._data).id == Activit.Tower then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100395)
    return 
  end
end

return TowerV2Cell

