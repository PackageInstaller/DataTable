local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GuildUtil")
local U = require("Common/Util")
local m_guildSkill
local m_elapsedTime = 0
local m_updateInterval = 0.4

function Start()
  WU.BindButtonEvent(REF.ButtonActivate, OnActivateClick)
end

function SetData(guildSkill, index)
  m_guildSkill = guildSkill
  m_elapsedTime = index * m_updateInterval / 4
  REF.SpriteSkill.UISprite.spriteName = "guild_skill_" .. m_guildSkill.id
  REF.LabelName.UILabel.text = WU.GetString("GuildSkillName_" .. m_guildSkill.id)
  REF.LabelDesc.UIHtmlLabel.text = WU.GetString("GuildSkillDesc_" .. m_guildSkill.id, m_guildSkill.add)
  WU.SetActive(REF.LabelAutoStartTime, m_guildSkill.autoStart)
  if m_guildSkill.autoStart == true then
    local endMinute, endHour, endDay = WU.ComputeTime(m_guildSkill.autoMinute, m_guildSkill.autoHour, m_guildSkill.time * m_guildSkill.autoUseCount)
    local nextDay = fif(0 < endDay, true, false)
    local autoStartLabel = ""
    autoStartLabel = autoStartLabel .. WU.GetString("Window_OpenDaily") .. " "
    autoStartLabel = autoStartLabel .. m_guildSkill.autoHour .. ":" .. fif(m_guildSkill.autoMinute > 9, m_guildSkill.autoMinute, "0" .. m_guildSkill.autoMinute)
    autoStartLabel = autoStartLabel .. " - "
    autoStartLabel = autoStartLabel .. endHour .. ":" .. fif(9 < endMinute, endMinute, "0" .. endMinute)
    autoStartLabel = autoStartLabel .. fif(nextDay, "(" .. WU.GetString("Window_NextDay") .. ")", "")
    REF.LabelAutoStartTime.UILabel.text = autoStartLabel
  end
  this:Bind("fci/profit/", function(profit)
    if profit == nil or profit.result == nil then
      return
    end
    local thisProfit
    local result = profit.result
    for i = 1, #result do
      if m_guildSkill.id == result[i].id then
        thisProfit = result[i]
        break
      end
    end
    if thisProfit ~= nil then
      m_guildSkill.startTime = thisProfit.startTime
      m_guildSkill.endTime = thisProfit.endTime
    else
      m_guildSkill.startTime = 0
      m_guildSkill.endTime = 0
    end
  end)
  UpdateImp()
end

function Update(delta)
  if m_guildSkill then
    m_elapsedTime = m_elapsedTime + delta
    if m_elapsedTime >= m_updateInterval then
      UpdateImp()
      m_elapsedTime = m_elapsedTime - m_updateInterval
    end
  end
end

function UpdateImp()
  local serverNow = CS.GameTime.serverUtc
  local active = serverNow >= m_guildSkill.startTime and serverNow < m_guildSkill.endTime
  WU.SetActive(REF.LabelAutoStartTime, m_guildSkill.autoStart)
  WU.ToggleRendering(REF.LabelTimeLeft, active)
  WU.ToggleRendering(REF.SpriteTimeLeft, active)
  WU.ToggleRendering(REF.NodeInactive, not active and not GU.IsGuildManager())
  WU.ToggleRendering(REF.ButtonActivate, GU.IsGuildManager())
  _ENV["$"](REF.ButtonActivate).Label.UILabel.text = fif(not active, WU.GetString("Window_GuildActivateSkill"), WU.GetString("Window_PresetGuildSkill"))
  if active then
    local timeLeft = m_guildSkill.endTime - serverNow
    REF.LabelTimeLeft.UIHtmlLabel.text = WU.RenderCountDownTime(timeLeft, REF.LabelTimeLeft.UIHtmlLabel.fontSize)
  end
end

function OnActivateClick()
  WU.AcquireWindowAsync("GuildSkillActivation", function(window)
    _ENV["$"](window)["$$SetData"](m_guildSkill)
  end)
end
