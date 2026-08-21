local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_number = 0
local m_min, m_max
local m_elapsedTime = 0
local m_interval = {
  start = 1,
  min = 0.05,
  acceleration = 0.3,
  current = 1
}
local m_holdButtonIncrease = false
local m_holdButtonDecrease = false
local m_numberUpdateCallback, m_numberValidateCallback

function Start()
  CS.EventDelegate.Add(REF.InputNumber.UIInput.onSubmit, OnInputSubmit)
  CS.EventDelegate.Add(REF.InputNumber.UIInput.onDeselect, OnInputDeselect)
  WU.BindPressEvent(REF.ButtonIncrease, function(go, pressed)
    if pressed then
      OnButtonPress(true)
    else
      OnButtonRelease(true)
    end
  end)
  WU.BindPressEvent(REF.ButtonDecrease, function(go, pressed)
    if pressed then
      OnButtonPress(false)
    else
      OnButtonRelease(false)
    end
  end)
  WU.BindButtonEvent(REF.ButtonMax, OnButtonMax)
  WU.BindDragStartEvent(REF.ButtonIncrease, function()
    m_holdButtonIncrease = false
  end)
  WU.BindDragStartEvent(REF.ButtonDecrease, function()
    m_holdButtonDecrease = false
  end)
end

function Update(deltaTime)
  if m_holdButtonIncrease or m_holdButtonDecrease then
    m_elapsedTime = m_elapsedTime + deltaTime
    if m_elapsedTime > m_interval.current then
      if m_holdButtonIncrease then
        m_holdButtonIncrease = OnIncreaseClick()
      elseif m_holdButtonDecrease then
        m_holdButtonDecrease = OnDecreaseClick()
      end
      if m_interval.current > m_interval.min then
        m_interval.current = math.max(m_interval.min, m_interval.current * (1 - m_interval.acceleration))
      end
      m_elapsedTime = m_elapsedTime - m_interval.current
    end
  end
end

function SetNumberUpdateCallback(callback)
  m_numberUpdateCallback = callback
end

function SetNumberValidateCallback(callback)
  m_numberValidateCallback = callback
end

function SetShowMax(show)
  REF.ButtonMax.gameObject:SetActive(show)
end

function SetNumber(number, forceUpdate)
  local isValidated = true
  if m_numberValidateCallback then
    isValidated = m_numberValidateCallback(number)
  end
  if (m_number ~= number or forceUpdate) and isValidated then
    m_number = number
    SetButtonStatus()
    if m_numberUpdateCallback then
      m_numberUpdateCallback(m_number)
    end
  end
  REF.InputNumber.UIInput.value = tostring(m_number)
end

function SetRange(min, max)
  m_min = min
  m_max = max
  SetButtonStatus()
end

function IsInRange(number)
  local isInRange = true
  if m_min ~= nil and number < m_min then
    isInRange = false
  end
  if isInRange and m_max ~= nil and number > m_max then
    isInRange = false
  end
  return isInRange
end

function OnButtonPress(increaseOrDecrease)
  if increaseOrDecrease then
    m_holdButtonIncrease = true
  else
    m_holdButtonDecrease = true
  end
  m_interval.current = m_interval.start
end

function OnButtonRelease(increaseOrDecrease)
  if increaseOrDecrease then
    m_holdButtonIncrease = false
  else
    m_holdButtonDecrease = false
  end
  if m_interval.current == m_interval.start then
    if increaseOrDecrease then
      OnIncreaseClick()
    else
      OnDecreaseClick()
    end
  end
end

function OnIncreaseClick()
  local validClick = false
  if IsInRange(m_number + 1) then
    validClick = true
    SetNumber(m_number + 1)
    SetButtonStatus()
  end
  return validClick
end

function OnDecreaseClick()
  local validClick = false
  if IsInRange(m_number - 1) then
    validClick = true
    SetNumber(m_number - 1)
    SetButtonStatus()
  end
  return validClick
end

function OnButtonMax()
  SetNumber(m_max)
  SetButtonStatus()
end

function SetButtonStatus()
  REF.ButtonIncrease.UIButton.isEnabled = IsInRange(m_number + 1)
  REF.ButtonDecrease.UIButton.isEnabled = IsInRange(m_number - 1)
  REF.ButtonMax.UIButton.isEnabled = m_max and m_number < m_max
end

function OnInputSubmit()
  local number = tonumber(REF.InputNumber.UIInput.value) or 0
  if number < 0 then
    number = 0
  end
  if m_max and m_min then
    number = math.max(m_min, math.min(m_max, number))
  end
  SetNumber(number)
end

function OnInputDeselect()
  REF.InputNumber.UIInput.value = tostring(m_number)
end
