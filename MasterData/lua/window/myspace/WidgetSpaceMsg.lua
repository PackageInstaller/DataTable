local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local CU = require("Common/ChatUtil")
local U = require("Common/Util")
local FU = require("Common/FriendUtil")
local HU = require("Common/HtmlUtil")
local m_data, m_selectedPlayerPath

function Start()
  m_selectedPlayerPath = "Space/SelectedPlayer"
  WU.BindButtonEvent(REF.TryToDelete, function()
    this:BroadcastGameEvent("TryToDeleteMask")
    this:BroadcastGameEvent("ResetAllDeleteBtn")
    WU.ToggleRendering(REF.TryToDelete, false)
    WU.ToggleRendering(REF.DeleteButton, true)
  end)
  WU.BindButtonEvent(REF.DeleteButton, function()
    local playerInfo = this:GetData(m_selectedPlayerPath)
    this:GameRequest("fci/player-message/" .. playerInfo.playerId .. "/" .. m_data.id):Delete(function(result)
      this:BroadcastGameEvent("SpaceMessageDeleted", m_data.id)
      this:BroadcastGameEvent("ResetAllDeleteBtn")
    end)
  end)
  this:RegisterGameEvent("ResetAllDeleteBtn", function()
    WU.ToggleRendering(REF.TryToDelete, true)
    WU.ToggleRendering(REF.DeleteButton, false)
  end)
end

function SetMessage(data, windowName)
  if windowName == "MySpace" then
    m_selectedPlayerPath = "Space/SelectedPlayerOther"
  else
    m_selectedPlayerPath = "Space/SelectedPlayer"
  end
  WU.ToggleRendering(REF.DeleteButton, false)
  local me = this:GetData("playerId")
  local str = ""
  m_data = data
  local sender = "[" .. data.senderName .. "]"
  if data.sender == me then
    sender = HU.ApplyFontColor(sender, "#00f1ff")
  else
    sender = HU.ApplyFontColor(sender, "#09bcfe")
  end
  if data.toName ~= nil and U.trim(data.toName) ~= "" then
    local to = "[" .. data.toName .. "]"
    if data.to == me then
      to = HU.ApplyFontColor(to, "#00f1ff")
    else
      to = HU.ApplyFontColor(to, "#09bcfe")
    end
    str = WU.GetString("Window_SpaceMessageTo", to)
  else
    str = WU.GetString("Window_SpaceMessage", sender)
  end
  str = str .. data.content
  if data.toName ~= nil and U.trim(data.toName) ~= "" then
    str = HU.ApplyHyperLink(str, "MessageTo:" .. data.to)
  else
    str = HU.ApplyHyperLink(str, "MessageTo:" .. data.sender)
  end
  REF.MessageLabel.UIHtmlLabel.text = str
  REF.DateLabel.UIHtmlLabel.text = WU.RenderTime2(data.createTime)
  local playerInfo = this:GetData(m_selectedPlayerPath)
  if playerInfo ~= nil then
    REF.TryToDelete.gameObject:SetActive(playerInfo.playerId == me or data.sender == me)
  end
end
