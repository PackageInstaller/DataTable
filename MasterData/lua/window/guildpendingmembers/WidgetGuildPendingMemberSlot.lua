local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GuildUtil")
local U = require("Common/Util")
local m_pendingMember, m_callback

function Start()
  SetHighlight(false)
  WU.BindButtonEvent(REF.ButtonAccept, OnAcceptClick)
  WU.BindButtonEvent(REF.ButtonReject, OnRejectClick)
  WU.BindButtonEvent(REF.Content, OnSlotClick)
end

function SetData(pendingMember)
  m_pendingMember = pendingMember
  if m_pendingMember then
    REF.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"](m_pendingMember)
    REF.LabelName.UIHtmlLabel.text = m_pendingMember.name
    REF.LabelLevel.UIHtmlLabel.text = WU.GetString("Window_Level", m_pendingMember.level)
    REF.LabelApplyTime.UIHtmlLabel.text = WU.RenderElpasedTime(CS.GameTime.serverUtc - m_pendingMember.applyTime)
  end
end

function SetClickCallback(callback)
  m_callback = callback
end

function SetHighlight(value)
  REF.SpriteHighlight.gameObject:SetActive(value)
end

function OnAcceptClick()
  if GU.IsGuildManager() then
    this:GameRequest("fci/guild/{guildId}/members/"):Put({
      playerId = m_pendingMember.playerId
    }, OnAcceptSucceed, OnAcceptFailed)
  end
end

function OnAcceptSucceed(result)
  this:SetData("fci/guild/", result)
end

function OnAcceptFailed(error)
end

function OnRejectClick()
  if GU.IsGuildManager() then
    this:GameRequest("fci/guild/{guildId}/pending-members/" .. m_pendingMember.playerId):Delete(OnRejectResult)
  end
end

function OnRejectResult()
end

function OnSlotClick()
  if m_callback then
    m_callback(REF["$gameObject"])
  end
end
