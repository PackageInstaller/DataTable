inherit("Window/Guild/GuildSensitiveBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GuildUtil")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local m_selectedPlayerId, m_guildMembers, m_guild
local m_windowsOnTop = {}

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonQuit, OnQuitClick)
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateRow
  })
  for i = 0, #REF.WrapContent - 1 do
    REF.WrapContent[i]["$$SetClickCallback"](OnSlotClick)
  end
end

function InitWindow()
  this:Bind("guildId", ValidateRestrictions)
  this:Bind("fci/guild/members", OnGuildMembersChange)
  this:Bind("fci/guild/", OnGuildChange)
end

function UninitWindow()
  CancelSelection()
  ClearTopWindows()
end

function ClearTopWindows()
  for key, _ in pairs(m_windowsOnTop) do
    WU.RecycleWindow(key)
  end
  m_windowsOnTop = {}
end

function OnGuildMembersChange(guildMembers)
  guildMembers = guildMembers or {}
  m_guildMembers = _ENV["!"](guildMembers):values()
  table.sort(m_guildMembers, function(a, b)
    local onlineStatusA = fif(a.lastLogoutTime == 0, 1, 0)
    local onlineStatusB = fif(b.lastLogoutTime == 0, 1, 0)
    if onlineStatusA ~= onlineStatusB then
      return onlineStatusA > onlineStatusB
    elseif a.type ~= b.type then
      return a.type > b.type
    else
      return a.guildScoreRecord > b.guildScoreRecord
    end
  end)
  UpdateMemberList()
end

function OnGuildChange(guild)
  m_guild = guild
  UpdateMemberCount()
end

function UpdateMemberCount()
  local guildMemberCount = 0
  local maxMemberCount = 0
  if m_guild then
    guildMemberCount = m_guild.membersCount
    maxMemberCount = PB.index("GuildLevel", m_guild.level).maxMemberCount
  end
  REF.LabelMemberCount.UILabel.text = WU.GetString("Window_GuildMemberCount") .. guildMemberCount .. "/" .. maxMemberCount
end

function UpdateMemberList()
  if m_guildMembers then
    LU.Set(REF.WrapContent, #m_guildMembers)
    if m_selectedPlayerId then
      local found, member = m_guildMembers:find(function(_, member)
        return member.playerId == m_selectedPlayerId
      end)
      if found then
        local playerOption = WU.FindWindow("PlayerOption")
        if playerOption.InUse then
          _ENV["$"](playerOption)["$$SetContext"](member)
        end
      else
        WU.RecycleWindow("PlayerOption")
        m_selectedPlayerId = nil
      end
      for i = 0, #REF.WrapContent - 1 do
        local slotRef = REF.WrapContent[i]
        local targetMember = m_guildMembers[slotRef["@index"]]
        if targetMember then
          slotRef["$$SetHighlight"](targetMember.playerId == m_selectedPlayerId)
        end
      end
    end
  end
end

function UpdateRow(refRow, wrapIndex, realIndex)
  local itemIndex = realIndex + 1
  if m_guildMembers == nil or itemIndex > #m_guildMembers then
    return
  end
  refRow["@index"] = itemIndex
  refRow["$$SetData"](m_guildMembers[itemIndex], -realIndex)
end

function OnSlotClick(slot)
  WU.RecordButtonClick(163001)
  if m_guildMembers ~= nil then
    _ENV["$"](slot)["$$SetHighlight"](true)
    local member = m_guildMembers[_ENV["$"](slot)["@index"]]
    m_selectedPlayerId = member.playerId
    WU.ShowPlayerOption(member, OnHideOperations)
    m_windowsOnTop.PlayerOption = true
  end
end

function OnHideOperations()
  m_windowsOnTop.PlayerOption = nil
  CancelSelection()
end

function CancelSelection()
  if m_selectedPlayerId then
    if m_guildMembers then
      for i = 0, #REF.WrapContent - 1 do
        local slotRef = REF.WrapContent[i]
        local member = m_guildMembers[slotRef["@index"]]
        if member.playerId == m_selectedPlayerId then
          slotRef["$$SetHighlight"](false)
          break
        end
      end
    end
    m_selectedPlayerId = nil
  end
end

function OnQuitClick(go)
  WU.RecordButtonClick(163002)
  if m_guild then
    local guildMisc = PB.index("GuildMisc", 1)
    local guildPlayer = this:GetData("fci/guild-player/")
    local limitTime = WU.RenderTimeSpan(guildMisc.guildFunctionLimitWhenQuit)
    if GU.IsGuildPresident() then
      if 1 < m_guild.membersCount then
        WU.ShowMessageOK(WU.GetString("Window_GuildDemiseBeforeQuit"))
      elseif guildPlayer.quitCount >= guildMisc.punishQuitCount then
        QuitGuild(WU.GetString("Window_GuildDismissConfirmWithWarning", limitTime))
      else
        QuitGuild(WU.GetString("Window_GuildDismissConfirm"))
      end
    elseif guildPlayer.quitCount >= guildMisc.punishQuitCount then
      QuitGuild(WU.GetString("Window_GuildQuitConfirmWithWarning", limitTime))
    else
      QuitGuild(WU.GetString("Window_GuildQuitConfirm"))
    end
  end
end

function QuitGuild(confirmMessage)
  local donationRefresh = ""
  local guildDonate = this:GetData("fci/guild/donate/")
  if guildDonate then
    local myRequest = guildDonate.donates[this:GetData("playerId")]
    if myRequest and GU.GetDonateInfo(myRequest) > 0 then
      donationRefresh = WU.GetString("Window_GuildQuitSupportNextRefresh")
    end
  end
  WU.ShowMessageYesNo(confirmMessage .. donationRefresh, function(result)
    if result == "YES" then
      this:GameRequest("fci/guild/{guildId}/members/quit/"):Post({
        playerId = this:GetData("playerId")
      }, function(result)
        this:SetData("fci/guild-player/", result)
      end)
    end
  end, WU.GetString("Window_QuitGuild"))
end

function Focus(on)
  WU.RecordWindowFocus(100163, on)
end
