local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GuildUtil")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local m_dataCount = 0
local m_currentIndex = 0
local m_callback
local m_selectedIndex = 0
local m_guildId, m_creation

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonConfirm, OnConfirmClick)
  WU.BindButtonEvent(REF.ButtonClose, CloseWindow)
end

function InitWindow()
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateRow
  })
  for i = 0, #REF.WrapContent - 1 do
    REF.WrapContent[i]["$$SetClickCallback"](OnSlotClick)
  end
  this:DelayInvokeInFrames(1, function()
    this:Bind("guildId", ValidateRestrictions)
  end)
end

function Focus(on)
  if on then
    ValidateRestrictions(this:GetData("guildId"))
  end
end

function ValidateRestrictions(guildId)
  local top = WU.TopWindow()
  if top and top.name == this.name then
    if 0 < guildId and m_creation then
      local guildPlayer = this:GetData("fci/guild-player")
      if guildPlayer.type ~= PB.enum.GuildMemberType.President and not this:GetData("GuildJoinNotified") then
        this:SetData("GuildJoinNotified", true)
        WU.ShowMessageOK(WU.GetString("Window_JustJoinGuild"), function(result)
          local top = WU.TopWindow()
          if top and top.name == this.name then
            WU.RecycleWindow(this)
          end
        end)
      else
        WU.RecycleWindow(this)
      end
    elseif guildId == 0 and not m_creation then
      if not this:GetData("GuildQuitNotified") then
        this:SetData("GuildQuitNotified", true)
        WU.ShowMessageOK(WU.GetString("Window_JustQuitGuild"), function(result)
          local top = WU.TopWindow()
          if top and top.name == this.name then
            WU.RecycleWindow(this)
          end
        end)
      else
        WU.RecycleWindow(this)
      end
    end
  end
end

function CloseWindow()
  m_callback = nil
  WU.RecycleWindow(this)
end

function SetData(dataCount, currentIndex, callback, creation)
  m_dataCount = dataCount
  m_currentIndex = currentIndex
  m_callback = callback
  m_creation = creation
  m_guildId = this:GetData("guildId") or 0
  m_selectedIndex = m_currentIndex
  REF.LabelTips.gameObject:SetActive(m_guildId == 0)
  REF.LabelCost.gameObject:SetActive(0 < m_guildId)
  if 0 < m_guildId then
    local guild = this:GetData("fci/guild/")
    local cost = PB.index("GuildMisc", 1).editIconCost
    local costHtml = "<img src='ResIcon_s.ResGuildScore_0'/>&nbsp;" .. tostring(cost)
    if cost > guild.score then
      costHtml = "<font color=#fd5454>" .. costHtml .. "</font>"
    end
    REF.LabelCost.UIHtmlLabel.text = costHtml
  end
  LU.Set(REF.WrapContent, m_dataCount)
end

function UpdateRow(refRow, wrapIndex, realIndex)
  local index = realIndex
  refRow["@index"] = index
  refRow["$$SetData"](index)
  refRow["$$SetHighlight"](index == m_selectedIndex)
end

function OnSlotClick(slot)
  local newIndex = _ENV["$"](slot)["@index"]
  if newIndex ~= m_selectedIndex then
    for i = 0, #REF.WrapContent - 1 do
      if REF.WrapContent[i]["@index"] == m_selectedIndex then
        REF.WrapContent[i]["$$SetHighlight"](false)
      end
    end
    m_selectedIndex = newIndex
    _ENV["$"](slot)["$$SetHighlight"](true)
  end
end

function OnConfirmClick()
  if m_selectedIndex ~= m_currentIndex and m_callback then
    if 0 < m_guildId then
      local guild = this:GetData("fci/guild/")
      if guild.score >= PB.index("GuildMisc", 1).editIconCost then
        ConfirmSelection()
      else
        WU.ShowHintText(WU.GetString("Window_GuildScoreInsufficient"))
      end
    else
      ConfirmSelection()
    end
  else
    CloseWindow()
  end
end

function ConfirmSelection()
  m_callback(m_selectedIndex)
  CloseWindow()
end
