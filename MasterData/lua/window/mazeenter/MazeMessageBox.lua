local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local messageCallback, m_defaultYesText, m_defaultNoText, m_defaultOkText, m_closeMessage
local m_toggleSelect = false
local m_cost

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

function SetIndex(index)
  local data = PB.get("ddd", index)
  local limitNum = 0
  REF.LabelNumLimit.UILabel.text = WU.GetString("LocalMaze_Tips2", limitNum)
end

function SetCost()
  local desc = WU.GetString("LocalMaze_Tips1")
  local cost = m_cost
  local stockAmount = this:GetData("fci/item/" .. cost.id).count
  local temp
  if stockAmount < cost.count then
    temp = "<img src='Achievement.achievement_bg_3'/><font color=#FF0000>" .. tostring(cost.count) .. "</font>"
    REF.BtnYes.UISprite.graify = true
    REF.BtnYes.BoxCollider2D.enabled = false
  else
    temp = "<img src='Achievement.achievement_bg_3'/><font color=#FFFFFF>" .. tostring(cost.count) .. "</font>"
    REF.BtnYes.UISprite.graify = false
    REF.BtnYes.BoxCollider2D.enabled = true
  end
  desc = desc .. temp
  REF.HtmlLabelCost.UIHtmlLabel.text = desc
end

function ShowMessage(message, callback, showOK, showYes, showNo, yesText, noText, okText, alignLeft, disableButtonClose, toggleText)
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
  SetCost()
end

function ShowMessageYesNo(message, callback, yesText, noText, alignLeft, disableButtonClose, justClose, toggleText)
  if justClose then
    m_closeMessage = "Close"
  else
    m_closeMessage = "NO"
  end
  ShowMessage(message, callback, false, true, true, yesText, noText, nil, alignLeft, disableButtonClose, toggleText)
end

function OnClick(message, toggleSelect)
  WU.RecycleWindow(this)
  if messageCallback ~= nil then
    messageCallback(message, toggleSelect)
    messageCallback = nil
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
