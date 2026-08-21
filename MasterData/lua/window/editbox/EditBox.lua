local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_confirmCallback, m_cancelCallback, m_cost, m_costEx
local m_checkCost = true
local m_checkEmpty = true
local m_multiple = false
local m_keyboardType, m_inputBox, m_lenLimit, m_allowEmpty

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonConfirm, OnConfirmClick)
  WU.BindButtonEvent(REF.ButtonCancel, OnCancelClick)
end

function ShowEditBox(context, confirmCallback, cancelCallback, lenLimit)
  m_cost = context.cost
  m_costEx = context.costEx
  m_checkCost = context.checkCost
  m_checkEmpty = context.m_checkEmpty
  m_multiple = context.multiple
  m_allowEmpty = context.allowEmpty
  m_keyboardType = context.keyboardType or CS.UIInput.KeyboardType.Default
  REF.InputSingle.UIInput.keyboardType = m_keyboardType
  REF.InputMultiple.UIInput.keyboardType = m_keyboardType
  if context.characterLimit ~= nil then
    REF.InputMultiple.UIInput.characterLimit = context.characterLimit
    REF.InputSingle.UIInput.characterLimit = context.characterLimit
  else
    REF.InputMultiple.UIInput.characterLimit = 100
    REF.InputSingle.UIInput.characterLimit = 20
  end
  m_confirmCallback = confirmCallback
  m_cancelCallback = cancelCallback
  m_lenLimit = lenLimit or 500
  REF.LabelTitle.UIHtmlLabel.text = context.title or ""
  REF.LabelSubTitle.UIHtmlLabel.text = context.subTitle or ""
  REF.LabelCost.gameObject:SetActive(m_cost or m_costEx)
  REF.InputSingle.gameObject:SetActive(not m_multiple)
  REF.InputMultiple.gameObject:SetActive(m_multiple)
  if context.multiple then
    m_inputBox = REF.InputMultiple
  else
    m_inputBox = REF.InputSingle
  end
  m_inputBox.UIInput.defaultText = context.tips or ""
  m_inputBox.UIInput.value = context.defaultText or ""
  if m_cost then
    REF.LabelCost.ResourcePrinter:SetResource(m_cost.type, m_cost.id, m_cost.count)
  elseif m_costEx then
    REF.LabelCost.UIHtmlLabel.text = m_costEx
  end
end

function OnConfirmClick()
  if m_cost then
    WU.TryToPay(m_cost.type, m_cost.id, m_cost.count, ValidateInput)
  else
    ValidateInput()
  end
end

function OnCancelClick()
  if m_cancelCallback then
    m_cancelCallback()
  end
  CloseWindow()
end

function CloseWindow()
  m_confirmCallback = nil
  m_cancelCallback = nil
  m_cost = nil
  m_costEx = nil
  m_checkCost = true
  m_checkEmpty = true
  m_multiple = false
  m_allowEmpty = false
  m_inputBox.UIInput.value = ""
  WU.RecycleWindow("EditBox")
end

function ValidateInput()
  local text = U.trim(m_inputBox.UIInput.value)
  if utf8.len(text) <= m_lenLimit then
    if m_allowEmpty then
      ConfirmEdit(text)
    elseif text == "" then
      WU.ShowHintText(WU.GetString("Window_EditBoxEmpty"))
    else
      ConfirmEdit(text)
    end
  elseif utf8.len(text) > m_lenLimit then
    WU.ShowHintText(WU.GetString("Window_EditBoxTooLong", m_lenLimit))
  end
end

function ConfirmEdit(text)
  if m_confirmCallback then
    if m_allowEmpty and text == "" then
      text = " "
    end
    if m_confirmCallback(text) then
      CloseWindow()
    end
  end
end
