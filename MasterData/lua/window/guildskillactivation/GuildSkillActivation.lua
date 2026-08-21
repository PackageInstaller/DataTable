inherit("Window/Guild/GuildSensitiveBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local HU = require("Common/HtmlUtil")
local U = require("Common/Util")
local GU = require("Common/GuildUtil")
local m_activateCount = 1
local m_guildSkill
local m_autoStart = false
local m_activateTime = 24
local m_oldInfo = {}

function SetupWindow()
  WU.BindButtonEvent(REF.BtnMinus, OnMinusClick)
  WU.BindButtonEvent(REF.BtnAdd, OnAddClick)
  WU.BindButtonEvent(REF.BtnMax, OnMaxClick)
  WU.BindButtonEvent(REF.BtnActivateTimeMinus, OnActivateTimeMinusClick)
  WU.BindButtonEvent(REF.BtnActivateTimeAdd, OnActivateTimeAddClick)
  WU.BindButtonEvent(REF.BtnLeft, OnLeftClick)
  WU.BindButtonEvent(REF.BtnRight, OnRightClick)
  WU.BindButtonEvent(REF.SpriteCheckbox, OnCheckBoxClick)
end

function InitWindow()
  this:Bind("guildId", ValidateRestrictions)
  m_activateCount = 1
  this:Bind("fci/guild/", OnGuildChange)
end

function SetData(guildSkill)
  m_guildSkill = guildSkill
  if m_guildSkill then
    local skillActive = IsSkillActive()
    REF.BtnLeft.UIButton.isEnabled = not skillActive
    REF.SpriteSkill.UISprite.spriteName = "guild_skill_" .. m_guildSkill.id
    REF.LabelSkillName.UILabel.text = WU.GetString("GuildSkillName_" .. m_guildSkill.id)
    REF.LabelSkillDesc.UIHtmlLabel.text = WU.GetString("GuildSkillDesc_" .. m_guildSkill.id, m_guildSkill.add)
    m_activateTime = guildSkill.autoHour * 2 + math.modf(guildSkill.autoMinute / 30)
    m_autoStart = guildSkill.autoStart
    m_activateCount = fif(guildSkill.autoUseCount ~= 0, guildSkill.autoUseCount, 1)
    UpdateOldInfo()
    m_autoStart = fif(skillActive, true, m_autoStart)
    UpdateActivationInfo()
  end
end

function OnGuildChange(guild)
  if guild then
    UpdateActivationInfo()
  end
end

function UpdateActivationInfo()
  if m_guildSkill then
    REF.LabelActivateCount.UILabel.text = tostring(m_activateCount)
    REF.SpriteCheckbox.UISprite.spriteName = fif(m_autoStart, "stage_setting/stage_setting_on", "stage_setting/stage_setting_off")
    REF.BtnActivateTimeMinus.UIButton.isEnabled = m_autoStart
    REF.BtnActivateTimeAdd.UIButton.isEnabled = m_autoStart
    local costIcon = "<img src='ResIcon_s.ResGuildScore_0'/>"
    local totalCostCount = m_guildSkill.scoreCost * m_activateCount
    local costText = tostring(totalCostCount)
    local guild = this:GetData("fci/guild/")
    if guild and totalCostCount > guild.score then
      costText = HU.ApplyFontColor(costText, "#fd5454")
    end
    REF.LabelActivateCost.UIHtmlLabel.text = costIcon .. costText
    REF.BtnMinus.UIButton.isEnabled = 1 < m_activateCount
    REF.BtnAdd.UIButton.isEnabled = m_activateCount < m_guildSkill.maxUseCount
    REF.BtnMax.UIButton.isEnabled = m_activateCount ~= m_guildSkill.maxUseCount
    local startHour = math.modf(m_activateTime / 2)
    local startMin = fif(math.fmod(m_activateTime, 2) == 0, 0, 30)
    local endMinute, endHour, endDay = WU.ComputeTime(startMin, startHour, m_guildSkill.time * m_activateCount)
    local nextDay = fif(0 < endDay, true, false)
    REF.LabelActivateTime.UILabel.text = startHour .. ":" .. fif(startMin == 0, "00", startMin)
    local durationText = ""
    if m_autoStart == true then
      durationText = durationText .. WU.GetString("Window_Time_Hour_Min", startHour, fif(startMin == 0, "00", startMin))
      durationText = durationText .. "-"
      durationText = durationText .. WU.GetString("Window_Time_Hour_Min", endHour, fif(9 < endMinute, endMinute, "0" .. endMinute))
      durationText = durationText .. fif(nextDay, "(" .. WU.GetString("Window_NextDay") .. ")", "")
    else
      local timeSpan = CS.System.TimeSpan(0, 0, m_guildSkill.time * m_activateCount)
      durationText = durationText .. WU.GetString("Window_Hour_Min", timeSpan.Hours, timeSpan.Minutes)
    end
    REF.LabelActivateDuration.UILabel.text = durationText
  end
end

function OnMinusClick()
  if 1 < m_activateCount then
    m_activateCount = m_activateCount - 1
    UpdateActivationInfo()
  end
end

function OnAddClick()
  if m_activateCount < m_guildSkill.maxUseCount then
    m_activateCount = m_activateCount + 1
    UpdateActivationInfo()
  end
end

function OnMaxClick()
  m_activateCount = m_guildSkill.maxUseCount
  UpdateActivationInfo()
end

function OnLeftClick()
  if not IsEnoughScore() then
    return
  end
  if m_autoStart == true then
    WU.ShowMessageYesNo(WU.GetString("Window_GuildSkillStartRightNowWarning"), function(res)
      if res == "YES" then
        RequestSkill(true, not m_autoStart, true)
        WU.ShowHintText(WU.GetString("Window_GuildSkillOpen"))
      else
        return
      end
    end)
  else
    RequestSkill(true, m_autoStart, true)
    WU.ShowHintText(WU.GetString("Window_GuildSkillOpen"))
  end
end

function OnRightClick()
  if not IsEnoughScore() then
    return
  end
  if m_autoStart == true then
    if IsInfoChange() then
      if m_oldInfo.autoStart == true then
        RequestSkill(false, m_autoStart, false)
        WU.ShowHintText(WU.GetString("Window_GuildSkillUpdatePlan"))
        UpdateOldInfo()
      elseif m_oldInfo.autoStart == false then
        RequestSkill(false, m_autoStart, false)
        WU.ShowHintText(WU.GetString("Window_GuildSkillSetPlan"))
        UpdateOldInfo()
      end
    else
      WU.ShowHintText(WU.GetString("Window_GuildSkillPlanNoChange"))
    end
  elseif m_oldInfo.autoStart == true then
    RequestSkill(false, m_autoStart, false)
    WU.ShowHintText(WU.GetString("Window_GuildSkillCloseAutoStart"))
    UpdateOldInfo()
  else
    WU.ShowHintText(WU.GetString("Window_GuildSkillSetFailed"))
  end
end

function RequestSkill(OpenRightNow, auto, autoCloseWindow)
  if m_guildSkill then
    local guild = this:GetData("fci/guild/")
    if m_guildSkill.scoreCost * m_activateCount <= guild.score then
      local patchData = {
        id = m_guildSkill.id,
        useCount = m_activateCount,
        autoStart = auto,
        minute = fif(auto, fif(math.fmod(m_activateTime, 2) == 0, 0, 30), 0),
        hour = fif(auto, math.modf(m_activateTime / 2), 0),
        force = not OpenRightNow and IsSkillActive()
      }
      
      local function callBack(result)
        OnGuildSkillActivated(result, autoCloseWindow)
      end
      
      if OpenRightNow then
        this:GameRequest("fci/guild/{guildId}/skill/"):Post(patchData, callBack)
      else
        this:GameRequest("fci/guild/{guildId}/skill/"):Put(patchData, callBack)
      end
    else
      WU.ShowHintText(WU.GetString("Window_ResourceTypeNotEnough", WU.GetString("ResourceTypeName_" .. PB.enum.ResourceType.ResGuildScore)))
    end
  end
end

function OnGuildSkillActivated(result, autoCloseWindow)
  local guildId = this:GetData("guildId")
  local guildSkills = this:GetData("fci/guild/skill/")
  local index, _ = table.find(guildSkills, function(k, v)
    return v.id == result.guildSkillInfo.id
  end)
  if index then
    guildSkills[index] = result.guildSkillInfo
    this:SetData("fci/guild/skill/", guildSkills)
  end
  if result.baseInfo ~= nil then
    this:SetData("fci/guild/", result.baseInfo)
  end
  local profitData = this:GetData("fci/profit/") or {}
  DB:GameRequest("fci/profit/"):Get(function(profit)
    if profit == nil or profit.guildProfitDelayInfo == nil then
      return
    end
    local delayInfo = profit.guildProfitDelayInfo
    local key, value = table.find(delayInfo, function(k, v)
      return v.profitId == result.guildSkillInfo.id
    end)
    if value ~= nil then
      UpdateProfit(profitData.guildProfitDelayInfo, result.guildSkillInfo.id, value)
      this:SetData("fci/profit/", profitData)
    end
  end)
  if autoCloseWindow then
    WU.RecycleWindow(this)
  end
end

function OnActivateTimeAddClick()
  m_activateTime = fif(m_activateTime == 47, 0, m_activateTime + 1)
  UpdateActivationInfo()
end

function OnActivateTimeMinusClick()
  m_activateTime = fif(m_activateTime == 0, 47, m_activateTime - 1)
  UpdateActivationInfo()
end

function UpdateProfit(profitData, guildId, newInfo)
  if profitData == nil then
    profitData = {}
  end
  local key, value = table.find(profitData, function(k, v)
    return v.id == guildId
  end)
  if value ~= nil then
    profitData[key] = newInfo
  else
    table.insert(profitData, newInfo)
  end
end

function OnCheckBoxClick()
  m_autoStart = not m_autoStart
  UpdateActivationInfo()
end

function IsInfoChange()
  local result = false
  if m_oldInfo.activateTime ~= m_activateTime or m_oldInfo.autoStart ~= m_autoStart or m_oldInfo.activateCount ~= m_activateCount then
    result = true
  end
  return result
end

function UpdateOldInfo()
  m_oldInfo.activateTime = m_activateTime
  m_oldInfo.autoStart = m_autoStart
  m_oldInfo.activateCount = m_activateCount
end

function IsEnoughScore()
  if m_guildSkill then
    local guild = this:GetData("fci/guild/")
    if m_guildSkill.scoreCost * m_activateCount <= guild.score then
      return true
    end
  end
  WU.ShowHintText(WU.GetString("Window_ResourceTypeNotEnough", WU.GetString("ResourceTypeName_" .. PB.enum.ResourceType.ResGuildScore)))
  return false
end

function IsSkillActive()
  if m_guildSkill == nil then
    return false
  end
  local serverNow = CS.GameTime.serverUtc
  local active = serverNow >= m_guildSkill.startTime and serverNow < m_guildSkill.endTime
  return active
end
