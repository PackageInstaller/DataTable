local ImageTable = BeanManager.GetTableByName("ui.cimagepath")
local ActivityMainBossCell = class("ActivityMainBossCell", Dialog)
ActivityMainBossCell.AssetBundleName = "ui/layouts.mainline"
ActivityMainBossCell.AssetName = "ActivityMainBossRushCell"
local Activit = {BossRush = 2, WeekBoss = 6}
local mapCount = 2
local SecToDay = 86400
local SecToHour = 3600
local SecToMin = 60

function ActivityMainBossCell:Ctor(...)
  ActivityMainBossCell.super.Ctor(self, ...)
end

function ActivityMainBossCell:OnCreate()
  self._panel = self:GetChild("Panel")
  self._map = {}
  for i = 1, mapCount do
    self._map[i] = {}
    self._map[i].panel = self:GetChild("Panel/Map" .. i)
    self._map[i].title = self:GetChild("Panel/Map" .. i .. "/Title")
    self._map[i].redDot = self:GetChild("Panel/Map" .. i .. "/RedDot")
    self._map[i].panel:Subscribe_PointerClickEvent(function()
      self:OnCellClicked(i)
    end, self)
  end
  self._map[2].tipsTxt = self:GetChild("Panel/Map2/Txt")
  self._grey = self:GetChild("Panel/Grey")
  self._lockTxt = self:GetChild("Panel/Grey/Image/LockTxt")
  self._name = self:GetChild("Panel/Title")
  self._img = self:GetChild("Panel/Map1")
  LuaNotificationCenter.AddObserver(self, self.RefreshTimes, Common.n_SWeekBossTime, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshWeekBossRushRed, Common.n_SReceiveWeekAward, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshWeekBossRushRed, Common.n_SWeekBossRedPoint, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshWeekBossRushRed, Common.n_WeekBossTaskRedPoint, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshWeekBossRushRed, Common.n_SOpenWeekBossPanel, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshWeekBossRushRed, Common.n_WeekBossChallengeRedPoint, nil)
end

function ActivityMainBossCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._task then
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
end

local function GetDelTimeStr(ms)
  local sec = ms // 1000
  local str
  if NekoData.BehaviorManager.BM_WeekBoss:GetLeftTime() ~= -1 then
    if sec > SecToDay then
      str = TextManager.GetText(1901555)
      str = string.gsub(str, "%$parameter1%$", sec // SecToDay)
      str = string.gsub(str, "%$parameter2%$", sec % SecToDay // SecToHour)
    elseif sec > SecToHour then
      str = TextManager.GetText(1901554)
      str = string.gsub(str, "%$parameter1%$", sec // SecToHour)
    elseif sec > SecToMin then
      str = TextManager.GetText(1901553)
      str = string.gsub(str, "%$parameter1%$", sec // SecToMin)
    else
      str = TextManager.GetText(1901553)
      str = string.gsub(str, "%$parameter1%$", 1)
    end
  elseif NekoData.BehaviorManager.BM_WeekBoss:GetResetTime() ~= -1 then
    if sec > SecToHour then
      str = TextManager.GetText(1901557)
      str = string.gsub(str, "%$parameter1%$", sec // SecToHour)
    elseif sec > SecToMin then
      str = TextManager.GetText(1901556)
      str = string.gsub(str, "%$parameter1%$", sec // SecToMin)
    else
      str = TextManager.GetText(1901556)
      str = string.gsub(str, "%$parameter1%$", 1)
    end
  end
  return str
end

function ActivityMainBossCell:TimerTask()
  if self._timeNumber == nil then
    if self._task then
      ServerGameTimer.RemoveTask(self._task)
      self._task = nil
    end
    return
  end
  self._timeNumber = self._timeNumber - 1000
  if self._timeNumber > 0 then
    self._map[2].tipsTxt:SetActive(true)
    self._map[2].tipsTxt:SetText(GetDelTimeStr(self._timeNumber))
  else
    self._map[2].tipsTxt:SetActive(false)
    if self._task then
      ServerGameTimer.RemoveTask(self._task)
      self._task = nil
    end
  end
end

function ActivityMainBossCell:RefreshCell(data)
  self._name:SetText(TextManager.GetText(data[1].name))
  for i = 1, mapCount do
    local imageRecord = ImageTable:GetRecorder(data[i].imageID2)
    self._map[i].panel:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    if data[i].id == Activit.BossRush then
      self._map[i].title:SetText(TextManager.GetText(1901551))
    elseif data[i].id == Activit.WeekBoss then
      self._map[i].title:SetText(TextManager.GetText(1901552))
    end
    self._map[i].redDot:SetActive(self:IsReadDotOn(i))
  end
  local bossLock = not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.BossRush)
  self._grey:SetActive(bossLock)
  self._lockTxt:SetActive(bossLock)
  self._lockTxt:SetText(TextManager.GetText(data[1].unlockTxt))
  self:RefreshTimes()
end

function ActivityMainBossCell:IsReadDotOn(i)
  if self._cellData[i].id == Activit.BossRush then
    return NekoData.BehaviorManager.BM_Game:IsBossPanelShowRed()
  elseif self._cellData[i].id == Activit.WeekBoss then
    return NekoData.BehaviorManager.BM_WeekBoss:IfShowRedDotInMainlinePanel()
  end
end

function ActivityMainBossCell:OnCellClicked(i)
  if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.BossRush) and (self._cellData[i].id == Activit.BossRush or self._cellData[i].id == Activit.WeekBoss) then
    self._delegate:OnWorldIClicked(self._cellData[i].id)
  end
end

function ActivityMainBossCell:RefreshTimes()
  if self._cellData[2] and self._cellData[2].id == Activit.WeekBoss then
    local leftTime = NekoData.BehaviorManager.BM_WeekBoss:GetLeftTime()
    local resetTime = NekoData.BehaviorManager.BM_WeekBoss:GetResetTime()
    self._timeNumber = -1
    if leftTime ~= -1 then
      self._timeNumber = leftTime
    elseif resetTime ~= -1 then
      self._timeNumber = resetTime
    else
      LogError("ActivityMainBossCell", "SOpenWeekBossPanel leftTime and resetTime both -1")
    end
    if self._timeNumber ~= -1 then
      if self._task then
        ServerGameTimer.RemoveTask(self._task)
        self._task = nil
      end
      self._task = ServerGameTimer.AddTask(0, 1, function()
        self:TimerTask()
      end, nil)
    end
  else
    self._map[2].tipsTxt:SetActive(false)
  end
end

function ActivityMainBossCell:OnRefreshWeekBossRushRed()
  if self._cellData[2] and self._cellData[2].id == Activit.WeekBoss then
    self._map[2].redDot:SetActive(self:IsReadDotOn(2))
  end
end

return ActivityMainBossCell
