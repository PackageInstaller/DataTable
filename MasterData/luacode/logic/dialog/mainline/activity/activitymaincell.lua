local TypeInfoTable = BeanManager.GetTableByName("dungeonselect.cresourcedungeontype")
local ImageTable = BeanManager.GetTableByName("ui.cimagepath")
local RedDotManager = require("logic.redpoint.reddotmanager")
local ActivityMainCell = class("ActivityMainCell", Dialog)
ActivityMainCell.AssetBundleName = "ui/layouts.mainline"
ActivityMainCell.AssetName = "ActivityMainCell"
local Activit = {
  Fragment = 1,
  BossRush = 2,
  Tower = 3,
  OffLinePvp = 4,
  UndecidedRoad = 5,
  SeasonPvp = 7
}

function ActivityMainCell:Ctor(...)
  ActivityMainCell.super.Ctor(self, ...)
end

function ActivityMainCell:OnCreate()
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
  self._openTxt = self:GetChild("Panel/RoadOpenTxt")
  self._panel:Subscribe_PointerClickEvent(self.OnCellClicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshOpenState, Common.n_RefreshUndecidedRoadState, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshRed, Common.n_RefreshFragmentPanelRed, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshRed, Common.n_RefreshUndecidedRoadRedDot, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshRed, Common.n_SeasonPvpAward, nil)
end

function ActivityMainCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function ActivityMainCell:RefreshCell(data)
  self._data = data
  self._openTxt:SetActive(false)
  self._name:SetText(TextManager.GetText(data.name))
  local imageRecord = ImageTable:GetRecorder(data.imageID)
  self._img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if data.id == Activit.Tower then
    self.lock = not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Tower)
  elseif data.id == Activit.BossRush then
    self.lock = not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.BossRush)
  elseif data.id == Activit.Fragment then
    self.lock = not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Fragment)
  elseif data.id == Activit.OffLinePvp then
    self.lock = not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.OffLinePvp)
  elseif data.id == Activit.UndecidedRoad then
    self.lock = not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.UndecidedRoad)
    self._openTxt:SetActive(NekoData.BehaviorManager.BM_UndecidedRoad:GetSeasonIsOpen() and not self.lock)
  elseif data.id == Activit.SeasonPvp then
    self.lock = not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.OffLinePvp)
  end
  self._grey:SetActive(self.lock)
  self._lockTxt:SetActive(self.lock)
  self._lockTxt:SetText(TextManager.GetText(data.unlockTxt))
  self._redDot:SetActive(self:IsReadDotOn())
end

function ActivityMainCell:IsReadDotOn()
  return self._data.id == Activit.BossRush and NekoData.BehaviorManager.BM_Game:IsBossPanelShowRed() or self._data.id == Activit.Fragment and NekoData.BehaviorManager.BM_Game:IsFragmentPanelShowRed() or self._data.id == Activit.UndecidedRoad and NekoData.BehaviorManager.BM_Game:IsUndecidedRoadShowRed() or self._data.id == Activit.SeasonPvp and NekoData.BehaviorManager.BM_Battle:GetSeasonNotify() and NekoData.BehaviorManager.BM_Battle:GetSeasonNotify().award and NekoData.BehaviorManager.BM_Battle:GetSeasonNotify().award > 0 or self._data.id == Activit.SeasonPvp and RedDotManager.ShouldSeasonShowRedDot()
end

function ActivityMainCell:OnRefreshRed()
  self._redDot:SetActive(self:IsReadDotOn())
end

function ActivityMainCell:RefreshOpenState()
  if self._data.id == Activit.UndecidedRoad then
    self.lock = not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.UndecidedRoad)
    self._openTxt:SetActive(NekoData.BehaviorManager.BM_UndecidedRoad:GetSeasonIsOpen() and not self.lock)
  end
end

function ActivityMainCell:OnCellClicked()
  if not self.lock then
    self._delegate:OnWorldIClicked(self._data.id)
  end
end

return ActivityMainCell
