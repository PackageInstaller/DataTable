local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local S = require("Common/Singleton")
local PU = require("Common/PlatformUtil")
local m_configDataManager = S:Get("ConfigDataManager")
local m_curRewardEn = 0
local m_curLimitEn = 0
local m_rewardEn, m_limitEn
local m_speed = 50
local m_numrn = 0
local m_numln = 0

function InitWindow()
  WU.ToggleRendering(REF.Content, false)
  m_numrn = 0
  m_numln = 0
  REF.Black["$SetCallback"](function()
    WU.SetLockFlag(PB.enum.LockInputFlag.UITransition, true)
    WU.ToggleRendering(REF.Content, false)
    WU.RecycleWindow("PlayerLevelupResult")
  end)
end

function UninitWindow()
  m_numrn = 0
  m_numln = 0
  WU.SetLockFlag(PB.enum.LockInputFlag.UITransition, false)
end

function SetData(lvFrom, lvTo)
  local preferences = m_configDataManager.GetPreferences()
  if PU.IsRecordVideoSwitchOn() and lvFrom < 10 and 10 <= lvTo and preferences.VideoGachaOpenRemind == nil then
    preferences.VideoGachaOpenRemind = false
  end
  if PU.IsRecordVideoSwitchOn() and lvFrom < 17 and 17 <= lvTo and preferences.VideoOpenRemind == nil then
    preferences.VideoOpenRemind = false
  end
  if lvFrom < 20 and 20 <= lvTo and preferences.NotifyOpenRemind == nil then
    preferences.NotifyOpenRemind = false
  end
  if lvFrom < 35 and 35 <= lvTo and preferences.SubscribeOpenRemind == nil then
    preferences.SubscribeOpenRemind = false
  end
  m_configDataManager.SetPreferences(preferences)
  REF.LevelLabelNew.UILabel.text = lvTo
  REF.LevelLabelOld.UILabel.text = lvFrom
  local resPlayerLevelInitConfig1 = PB.get("PlayerLevelInitConfig", lvFrom)
  local resPlayerLevelInitConfig2 = PB.get("PlayerLevelInitConfig", lvTo)
  if resPlayerLevelInitConfig1 == nil or resPlayerLevelInitConfig2 == nil then
    error("Player", "PlayerLevelInitConfig.xlsx error(is nil), lv1 " .. lvFrom .. " or lv2 " .. lvTo)
    return
  end
  local levelRewardTo = resPlayerLevelInitConfig2.levelReward[1].count
  for i = lvFrom + 1, lvTo - 1 do
    local res = PB.get("PlayerLevelInitConfig", i)
    if res == nil then
      error("Player", "PlayerLevelInitConfig.xlsx error(is nil), lv " .. i)
      break
    end
    levelRewardTo = levelRewardTo + res.levelReward[1].count
  end
  local powerOld, power
  for i = 1, #resPlayerLevelInitConfig1.incInfo do
    if resPlayerLevelInitConfig1.incInfo[i].type == PB.enum.ResourceType.ResPlayerPower then
      powerOld = resPlayerLevelInitConfig1.incInfo[i].max
      power = resPlayerLevelInitConfig2.incInfo[i].max
      break
    end
  end
  m_rewardEn = levelRewardTo
  m_limitEn = power or 0
  REF.NUM[0].num.UILabel.text = levelRewardTo
  REF.NUM[1].num.UILabel.text = power or 0
  local powerOld, power
  for i = 1, #resPlayerLevelInitConfig1.incInfo do
    if resPlayerLevelInitConfig1.incInfo[i].type == PB.enum.ResourceType.ResPlayerPower then
      powerOld = resPlayerLevelInitConfig1.incInfo[i].max
      power = resPlayerLevelInitConfig2.incInfo[i].max
      break
    end
  end
  local showIsOpen = false
  local showIsOpen = false
  local showNextOpen = false
  local unlockWindowData = this:GetData("UnlockWindowData")
  for i = 1, 2 do
    local res = resPlayerLevelInitConfig2.unlockWindow[i] or 0
    if res ~= nil and res ~= 0 then
      WU.SetActive(REF.Level[i - 1].root, true)
      REF.Level[i - 1].LV.UILabel.text = "LV" .. lvTo
      REF.Level[i - 1].NAME.UILabel.text = WU.GetString("UnlockType_" .. res)
    else
      WU.SetActive(REF.Level[i - 1].root, false)
    end
  end
  this:DelayInvokeInSeconds(0.2, function()
    WU.SetLockFlag(PB.enum.LockInputFlag.UITransition, false)
  end)
  REF.EffectOpen.EffectGenerator:Play()
  this:DelayInvokeInSeconds(0.3, function()
    WU.ToggleRendering(REF.Content, true)
    REF.root.Animator:Play("LevelDetail")
    this:DelayInvokeInSeconds(0.3, function()
      REF.EffectHit.EffectGenerator:Play()
    end)
  end)
end

function UpdateWindow(delta)
  if m_curRewardEn == m_rewardEn and m_curLimitEn == m_limitEn then
    return
  end
  if m_numrn < m_rewardEn then
    m_numrn = m_numrn + delta * m_speed
    m_curRewardEn = math.floor(m_numrn)
    REF.NUM[0].num.UILabel.text = m_curRewardEn
  else
    m_numrn = m_rewardEn
    m_curRewardEn = m_rewardEn
    REF.NUM[0].num.UILabel.text = m_rewardEn
  end
  if m_numln < m_limitEn then
    m_numln = m_numln + delta * m_speed
    m_curLimitEn = math.floor(m_numln)
    REF.NUM[1].num.UILabel.text = m_curLimitEn
  else
    m_curLimitEn = m_limitEn
    REF.NUM[1].num.UILabel.text = m_limitEn
  end
end
