local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local CU = require("Common/ChatUtil")
local U = require("Common/Util")
local RU = require("Common/RedMarkUtil")
local CO = require("Common/Coroutine")
local MU = require("Common/MailUtil")
local m_lastAbstractId, m_msgLeftTime, m_mailRedMark, m_messageRedMark

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonMail, OnMailClick)
  WU.BindButtonEvent(REF.ButtonMessage, OnMessageClick)
end

function InitWindow()
  if WU.FindWindow("Login") == nil and this:GetData("NavigationContext") == "City" then
    REF["$UILuaWindow"]:PlayUITweener()
  end
  this:Bind("MessengerContext/Messenger", function(val)
    if val ~= nil then
      REF.ButtonMail.gameObject:SetActive(val)
      REF.ButtonMessage.gameObject:SetActive(val)
    end
  end)
  this:Bind("fci/baseinfo/", function(baseinfo)
    if MU.MailCanReceive() then
      RU.BindRedMark(this, "Mail", function(flag)
        m_mailRedMark = flag
        REF.RedPointMail.gameObject:SetActive(flag)
      end)
    else
      REF.RedPointMail.gameObject:SetActive(false)
    end
  end)
  this:Bind("NewPrivateMsg/Display", function(flag)
    m_messageRedMark = flag
    REF.SpriteNew.gameObject:SetActive(flag or false)
  end)
  this:Bind("ChatRoom/ChatContentWorld", OnAbstractMessage, false)
  if WU.IsStandaloneGame() then
    REF.ButtonMail.gameObject:SetActive(false)
    REF.ButtonMessage.gameObject:SetActive(false)
  end
end

function UpdateWindow(delta)
  if m_msgLeftTime ~= nil then
    m_msgLeftTime = m_msgLeftTime - delta
    WU.ToggleRendering(REF.ChatWorldMsgNode, 0 < m_msgLeftTime)
  else
    WU.ToggleRendering(REF.ChatWorldMsgNode, false)
  end
end

function OnMailClick()
  if m_mailRedMark then
    WU.RecordButtonClick("995R")
  else
    WU.RecordButtonClick(995)
  end
  local topWindow = WU.TopWindow()
  if topWindow == nil or topWindow.name ~= "Mail" then
    WU.AcquireWindowAsync("Mail")
  end
end

function EnableMailButton(bool)
  REF.ButtonMail.UIButton.isEnabled = bool
end

function OnMessageClick()
  if m_messageRedMark then
    WU.RecordButtonClick("994R")
  else
    WU.RecordButtonClick(994)
  end
  if not WU.WindowIsLocked(PB.enum.UnlockWindow.ChatRoom, PB.enum.UnlockWindow.ChatRoom) then
    this:SetData("ApplyChatRoomHyperLink", true)
    WU.AcquireWindowAsync("ChatRoom")
  end
end

function OnAbstractMessage(result)
  if result ~= nil and 0 < #result then
    if string.match(result[#result].content, "<img src=.*>") then
      REF.MsgLabel.UIHtmlLabel.text = WU.GetString("Window_ChatImagePlaceHoder")
    elseif result[#result].id ~= m_lastAbstractId then
      m_lastAbstractId = result[#result].id
      REF.MsgLabel.UIHtmlLabel.text = result[#result].content
    else
      return
    end
    m_msgLeftTime = 2
  end
end
