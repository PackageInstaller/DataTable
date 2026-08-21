local PB = require("Common/PbHelper")
local WU, DB, REF = require("Common/WindowUtil")(this)
local HU = require("Common/HtmlUtil")
local ACU = require("Common/ActivityUtil")
local LU = require("Common/ListUtil")
local m_coroutine = {}

function SetupWindow()
  WU.TraverseChildren(REF.WindowSize, function(go)
    WU.BindButtonEvent(go, function()
      this:SetData("ApplyChatRoomHyperLink", true)
      WU.AcquireWindowAsync("ChatRoom", function(ui)
        _ENV["$"](ui)["$$SetChannelVisible"](3)
      end)
    end)
  end)
end

function InitWindow()
  WU.TraverseChildren(REF.WindowSize, function(go)
    go:SetActive(false)
  end)
  this:RegisterGameEvent("DungeonTeamMsgClose", function()
    WU.RecycleWindow(this)
  end)
  this:RegisterGameEvent("PositionChanged", function(changedPosition)
    for _, v in pairs(changedPosition) do
      REF["MsgPlayer" .. v].gameObject:SetActive(false)
    end
  end)
end

function UninitWindow()
  for _, v in pairs(m_coroutine) do
    if v ~= nil then
      this:StopCoroutine(v)
    end
  end
end

function SetContent(position, content)
  if string.match(content, "<img src=.*>") then
    content = WU.GetString("Window_ChatImagePlaceHoder")
  end
  _ENV["$"](REF["MsgPlayer" .. position]).Label.UIHtmlLabel.text = content
  REF["MsgPlayer" .. position].gameObject:SetActive(true)
  if m_coroutine[position] ~= nil then
    this:StopCoroutine(m_coroutine[position])
  end
  m_coroutine[position] = this:DelayInvokeInSeconds(2, function()
    REF["MsgPlayer" .. position].gameObject:SetActive(false)
  end)
end
