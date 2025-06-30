-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/activity/activitymainbosscell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ImageTable = (BeanManager.GetTableByName)("ui.cimagepath")
local ActivityMainBossCell = class("ActivityMainBossCell", Dialog)
ActivityMainBossCell.AssetBundleName = "ui/layouts.mainline"
ActivityMainBossCell.AssetName = "ActivityMainBossRushCell"
local Activit = {BossRush = 2, WeekBoss = 6}
local mapCount = 2
local SecToDay = 86400
local SecToHour = 3600
local SecToMin = 60
ActivityMainBossCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ActivityMainBossCell
  ((ActivityMainBossCell.super).Ctor)(self, ...)
end

ActivityMainBossCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : mapCount, _ENV
  self._panel = self:GetChild("Panel")
  self._map = {}
  for i = 1, mapCount do
    do
      -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

      (self._map)[i] = {}
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._map)[i]).panel = self:GetChild("Panel/Map" .. i)
      -- DECOMPILER ERROR at PC29: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._map)[i]).title = self:GetChild("Panel/Map" .. i .. "/Title")
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._map)[i]).redDot = self:GetChild("Panel/Map" .. i .. "/RedDot")
      ;
      (((self._map)[i]).panel):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnCellClicked(i)
  end
, self)
    end
  end
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self._map)[2]).tipsTxt = self:GetChild("Panel/Map2/Txt")
  self._grey = self:GetChild("Panel/Grey")
  self._lockTxt = self:GetChild("Panel/Grey/Image/LockTxt")
  self._name = self:GetChild("Panel/Title")
  self._img = self:GetChild("Panel/Map1")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshTimes, Common.n_SWeekBossTime, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshWeekBossRushRed, Common.n_SReceiveWeekAward, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshWeekBossRushRed, Common.n_SWeekBossRedPoint, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshWeekBossRushRed, Common.n_WeekBossTaskRedPoint, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshWeekBossRushRed, Common.n_SOpenWeekBossPanel, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshWeekBossRushRed, Common.n_WeekBossChallengeRedPoint, nil)
end

ActivityMainBossCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._task then
    (ServerGameTimer.RemoveTask)(self._task)
    self._task = nil
  end
end

local GetDelTimeStr = function(ms)
  -- function num : 0_3 , upvalues : _ENV, SecToDay, SecToHour, SecToMin
  local sec = ms // 1000
  local str = nil
  if ((NekoData.BehaviorManager).BM_WeekBoss):GetLeftTime() ~= -1 then
    if SecToDay < sec then
      str = (TextManager.GetText)(1901555)
      str = (string.gsub)(str, "%$parameter1%$", sec // SecToDay)
      str = (string.gsub)(str, "%$parameter2%$", sec % SecToDay // SecToHour)
    else
      if SecToHour < sec then
        str = (TextManager.GetText)(1901554)
        str = (string.gsub)(str, "%$parameter1%$", sec // SecToHour)
      else
        if SecToMin < sec then
          str = (TextManager.GetText)(1901553)
          str = (string.gsub)(str, "%$parameter1%$", sec // SecToMin)
        else
          str = (TextManager.GetText)(1901553)
          str = (string.gsub)(str, "%$parameter1%$", 1)
        end
      end
    end
  else
    if ((NekoData.BehaviorManager).BM_WeekBoss):GetResetTime() ~= -1 then
      if SecToHour < sec then
        str = (TextManager.GetText)(1901557)
        str = (string.gsub)(str, "%$parameter1%$", sec // SecToHour)
      else
        if SecToMin < sec then
          str = (TextManager.GetText)(1901556)
          str = (string.gsub)(str, "%$parameter1%$", sec // SecToMin)
        else
          str = (TextManager.GetText)(1901556)
          str = (string.gsub)(str, "%$parameter1%$", 1)
        end
      end
    end
  end
  return str
end

ActivityMainBossCell.TimerTask = function(self)
  -- function num : 0_4 , upvalues : _ENV, GetDelTimeStr
  if self._timeNumber == nil then
    if self._task then
      (ServerGameTimer.RemoveTask)(self._task)
      self._task = nil
    end
    return 
  end
  self._timeNumber = self._timeNumber - 1000
  if self._timeNumber > 0 then
    (((self._map)[2]).tipsTxt):SetActive(true)
    ;
    (((self._map)[2]).tipsTxt):SetText(GetDelTimeStr(self._timeNumber))
  else
    ;
    (((self._map)[2]).tipsTxt):SetActive(false)
    if self._task then
      (ServerGameTimer.RemoveTask)(self._task)
      self._task = nil
    end
  end
end

ActivityMainBossCell.RefreshCell = function(self, data)
  -- function num : 0_5 , upvalues : _ENV, mapCount, ImageTable, Activit
  (self._name):SetText((TextManager.GetText)((data[1]).name))
  for i = 1, mapCount do
    local imageRecord = ImageTable:GetRecorder((data[i]).imageID)
    ;
    (((self._map)[i]).panel):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    if (data[i]).id == Activit.BossRush then
      (((self._map)[i]).title):SetText((TextManager.GetText)(1901551))
    else
      if (data[i]).id == Activit.WeekBoss then
        (((self._map)[i]).title):SetText((TextManager.GetText)(1901552))
      end
    end
    ;
    (((self._map)[i]).redDot):SetActive(self:IsReadDotOn(R11_PC59))
  end
  local bossLock = not ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).BossRush)
  ;
  (self._grey):SetActive(bossLock)
  ;
  (self._lockTxt):SetActive(bossLock)
  ;
  (self._lockTxt):SetText((TextManager.GetText)((data[1]).unlockTxt))
  self:RefreshTimes()
end

ActivityMainBossCell.IsReadDotOn = function(self, i)
  -- function num : 0_6 , upvalues : Activit, _ENV
  if ((self._cellData)[i]).id == Activit.BossRush then
    return ((NekoData.BehaviorManager).BM_Game):IsBossPanelShowRed()
  else
    if ((self._cellData)[i]).id == Activit.WeekBoss then
      return ((NekoData.BehaviorManager).BM_WeekBoss):IfShowRedDotInMainlinePanel()
    end
  end
end

ActivityMainBossCell.OnCellClicked = function(self, i)
  -- function num : 0_7 , upvalues : _ENV, Activit
  if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).BossRush) and (((self._cellData)[i]).id == Activit.BossRush or ((self._cellData)[i]).id == Activit.WeekBoss) then
    (self._delegate):OnWorldIClicked(((self._cellData)[i]).id)
  end
end

ActivityMainBossCell.RefreshTimes = function(self)
  -- function num : 0_8 , upvalues : Activit, _ENV
  if (self._cellData)[2] and ((self._cellData)[2]).id == Activit.WeekBoss then
    local leftTime = ((NekoData.BehaviorManager).BM_WeekBoss):GetLeftTime()
    local resetTime = ((NekoData.BehaviorManager).BM_WeekBoss):GetResetTime()
    self._timeNumber = -1
    if leftTime ~= -1 then
      self._timeNumber = leftTime
    else
      if resetTime ~= -1 then
        self._timeNumber = resetTime
      else
        LogError("ActivityMainBossCell", "SOpenWeekBossPanel leftTime and resetTime both -1")
      end
    end
    if self._timeNumber ~= -1 then
      if self._task then
        (ServerGameTimer.RemoveTask)(self._task)
        self._task = nil
      end
      self._task = (ServerGameTimer.AddTask)(0, 1, function()
    -- function num : 0_8_0 , upvalues : self
    self:TimerTask()
  end
, nil)
    end
  else
    do
      ;
      (((self._map)[2]).tipsTxt):SetActive(false)
    end
  end
end

ActivityMainBossCell.OnRefreshWeekBossRushRed = function(self)
  -- function num : 0_9 , upvalues : Activit
  if (self._cellData)[2] and ((self._cellData)[2]).id == Activit.WeekBoss then
    (((self._map)[2]).redDot):SetActive(self:IsReadDotOn(2))
  end
end

return ActivityMainBossCell

