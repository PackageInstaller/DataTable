local TypeInfoTable = BeanManager.GetTableByName("dungeonselect.cresourcedungeontype")
local ImageTable = BeanManager.GetTableByName("ui.cimagepath")
local RedDotManager = require("logic.redpoint.reddotmanager")
local TowerV2Cell = class("TowerV2Cell", Dialog)
TowerV2Cell.AssetBundleName = "ui/layouts.mainline"
TowerV2Cell.AssetName = "ActivityMainCell"
local Activit = {
  Fragment = 1,
  BossRush = 2,
  Tower = 3,
  OffLinePvp = 4,
  UndecidedRoad = 5
}

function TowerV2Cell:Ctor(...)
  TowerV2Cell.super.Ctor(self, ...)
end

function TowerV2Cell:OnCreate()
  self._panel = self:GetChild("Panel")
  self._img = self:GetChild("Panel/Map")
  self._grey = self:GetChild("Panel/Grey")
  self._lockTxt = self:GetChild("Panel/LockTxt")
  self._name = self:GetChild("Panel/Title")
  self._back = self:GetChild("Panel/Back")
  self._numPanel = self:GetChild("Panel/Num")
  self._num = self:GetChild("Panel/Num/Num")
  self._maxNumber = self:GetChild("Panel/MaxNum")
  self._numPanel:SetActive(false)
  self._redDot = self:GetChild("Panel/RedDot")
  self._waitingBack = self:GetChild("Panel/timeback")
  self._waitingText = self:GetChild("Panel/TimeTxt")
  self._openText = {
    close = self:GetChild("Panel/StairClose"),
    open = self:GetChild("Panel/StairOpen")
  }
  self._panel:Subscribe_PointerClickEvent(self.OnCellClicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshOpenState, Common.n_TowerV2OpenState, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshRed, Common.n_RefreshTowerV2RedPoint, nil)
  self._time = 0
end

function TowerV2Cell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function TowerV2Cell:RefreshCell(data)
  self._data = data
  self._name:SetText(TextManager.GetText(data.name))
  local imageRecord = ImageTable:GetRecorder(data.imageID)
  self._img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._redDot:SetActive(self:IsReadDotOn())
  self:RefreshOpenState()
end

function TowerV2Cell:IsReadDotOn()
  return self._data.id == Activit.Tower and NekoData.BehaviorManager.BM_TowerV2:GetHasReward() == 1 or self._data.id == Activit.Tower and RedDotManager.ShouldTowerShowRedDot()
end

function TowerV2Cell:OnRefreshRed()
  self._redDot:SetActive(self:IsReadDotOn())
end

function TowerV2Cell:RefreshOpenState()
  self._time = 0
  self.lock = not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Tower)
  self._grey:SetActive(self.lock)
  self._lockTxt:SetActive(self.lock)
  self._lockTxt:SetText(TextManager.GetText(self._data.unlockTxt))
  if not self.lock then
    local open = NekoData.BehaviorManager.BM_TowerV2:IsOpen()
    if open then
      self._grey:SetActive(false)
      self.lock = false
    else
      self._grey:SetActive(true)
      self.lock = true
    end
  end
end

function TowerV2Cell:OnUpdate(deltaTime, unscaledDeltaTime)
  self._time = self._time + deltaTime
  if self._time > 60 then
    self:RefreshOpenState()
  end
end

function TowerV2Cell:OnCellClicked()
  if not self.lock then
    self._delegate:OnWorldIClicked(self._data.id)
  end
end

return TowerV2Cell
