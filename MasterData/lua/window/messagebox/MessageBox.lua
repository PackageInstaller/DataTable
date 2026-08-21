local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local messageCallback, m_defaultYesText, m_defaultNoText, m_defaultOkText, m_closeMessage
local m_toggleSelect = false
local m_noCloseButton = false

function SetupWindow()
  WU.BindButtonEvent(REF.BtnOK, OnUIOK)
  WU.BindButtonEvent(REF.BtnYes, OnUIYes)
  WU.BindButtonEvent(REF.BtnNo, OnUINo)
  REF.ButtonClose["$SetCallback"](OnUIClose)
  REF.Black["$SetCallback"](OnUIClose)
  CS.EventDelegate.Add(REF.ToggleUnselect.UIToggle.onChange, function()
    m_toggleSelect = CS.UIToggle.current.value
    REF.ToggleSelect.gameObject:SetActive(m_toggleSelect)
  end)
end

function ShowMessage(message, callback, showOK, showYes, showNo, yesText, noText, okText, alignLeft, disableButtonClose, toggleText, noCloseButton)
  REF.Message.UIHtmlLabel.text = message
  local align = CS.NGUIText.Alignment.Center
  if alignLeft then
    align = CS.NGUIText.Alignment.Left
  end
  if disableButtonClose then
    REF.Black.BoxCollider2D.enabled = false
  else
    REF.Black.BoxCollider2D.enabled = true
  end
  REF.Message.UIHtmlLabel.alignment = align
  messageCallback = callback
  REF.BtnOK.gameObject:SetActive(showOK)
  REF.BtnYes.gameObject:SetActive(showYes)
  REF.BtnNo.gameObject:SetActive(showNo)
  m_defaultYesText = m_defaultYesText or WU.GetString("WindowSystem_Confirm")
  m_defaultNoText = m_defaultNoText or WU.GetString("WindowSystem_Cancel")
  m_defaultOkText = m_defaultOkText or WU.GetString("WindowSystem_Confirm")
  REF.LabelYes.UILabel.text = yesText or m_defaultYesText
  REF.LabelNo.UILabel.text = noText or m_defaultNoText
  REF.LabelOK.UILabel.text = okText or m_defaultOkText
  local showToggle = toggleText ~= nil
  REF.NodeToggle.gameObject:SetActive(showToggle)
  m_toggleSelect = false
  if showToggle then
    if toggleText == "" then
      toggleText = WU.GetString("Window_DonotShowAgain")
    end
    REF.LabelToggle.UILabel.text = toggleText
    REF.ToggleUnselect.UIToggle.value = m_toggleSelect
  end
  m_noCloseButton = noCloseButton
  REF.ButtonClose.gameObject:SetActive(not m_noCloseButton)
  this:BroadcastGameEvent("ShowMessageOpened")
end

function ShowMessageWithNoButton(message)
  ShowMessage(message, nil, false, false, false, "", "", "", nil, nil, nil, true)
end

function ShowMessageYesNo(message, callback, yesText, noText, alignLeft, disableButtonClose, justClose, toggleText)
  if justClose then
    m_closeMessage = "Close"
  else
    m_closeMessage = "NO"
  end
  ShowMessage(message, callback, false, true, true, yesText, noText, nil, alignLeft, disableButtonClose, toggleText)
end

function ShowMessageOK(message, callback, okText, alignLeft)
  m_closeMessage = "OK"
  ShowMessage(message, callback, true, false, false, nil, nil, okText, alignLeft)
end

function OnClick(message, toggleSelect)
  if not m_noCloseButton then
    WU.RecycleWindow(this)
    if messageCallback ~= nil then
      messageCallback(message, toggleSelect)
      messageCallback = nil
    end
  end
end

function OnUIOK()
  OnClick("OK", m_toggleSelect)
end

function OnUIYes()
  OnClick("YES", m_toggleSelect)
end

function OnUINo()
  OnClick("NO", m_toggleSelect)
end

function OnUIClose()
  OnClick(m_closeMessage, false)
end
