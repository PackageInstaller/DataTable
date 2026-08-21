local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local m_manager = S:Get("TutorialManager")
local m_curTalk = 0
local m_curStep, m_indicator
local m_waiting = false
local m_isTutorialUIShowing = false
local m_clickCount = 0
local m_flipVector = CS.UnityEngine.Vector3(0, 180, 0)
local m_time = 0
local m_curtainTime = 0
local m_continueShowing = false
local m_focusDelta = 1
local m_state = 0

function SetupWindow()
  WU.BindButtonEvent(REF.Block, OnBlockClick)
  WU.BindButtonEvent(REF.ClickArea, OnClickAreaClick)
  m_focusDelta = PB.all("Misc")[1].tutorialFocusDelta or 1
end

function InitWindow()
  WU.ToggleRendering(REF.Talk, true)
  WU.SetActive(REF.NodeContinue, false)
  REF.Talk.gameObject:SetActive(false)
  REF.Curtain.gameObject:SetActive(false)
  this:RegisterGameEvent("HideTutorial", OnHideTalk)
end

function UpdateWindow(delta)
  if m_state == 1 then
    if m_curStep then
      m_time = m_time + delta
      if m_time > m_curStep.delay then
        PlayFocusAnim()
        m_time = 0
        m_state = 2
      end
    end
  elseif m_state == 2 then
    m_time = m_time + delta
    if m_time > m_focusDelta then
      PlayFocusAnim()
      m_time = 0
    end
  end
  if not m_continueShowing and m_curStep then
    m_curtainTime = m_curtainTime + delta
    if 2 < m_curtainTime and m_curStep.continue then
      WU.SetActive(REF.NodeContinue, true)
      m_continueShowing = true
      m_curtainTime = 0
    end
  end
end

function OnClickAreaClick(go)
  m_state = 0
  m_continueShowing = false
  if WU.CurrentScene() ~= "SceneFight" then
    TryToJumpForceTutorial()
  end
  if m_indicator ~= nil then
    WU.RemoveAllChild(REF.Content)
    REF.Curtain.gameObject:SetActive(false)
    local target = m_indicator.Target
    local hasPressEvent = m_curStep.id == 23 and m_curStep.step == 41 or m_curStep.id == 33 and m_curStep.step == 51 or m_curStep.id == 40 and m_curStep.step == 51 or m_curStep.id == 51 and m_curStep.step == 51 or m_curStep.id == 58 and m_curStep.step == 51 or m_curStep.id == 59 and m_curStep.step == 61 or m_curStep.id == 59 and m_curStep.step == 71
    if m_indicator.Uri == "" then
      m_manager.DoTutorial()
    end
    if hasPressEvent then
      local onPress = CS.UIEventListener.Get(target).onPress
      if onPress ~= nil then
        onPress(target, true)
        onPress(target, false)
      end
    else
      local toggle = _ENV["$"](target).root.UIToggle
      if toggle ~= nil then
        toggle.value = true
      end
      local onClick = CS.UIEventListener.Get(target).onClick
      if onClick ~= nil then
        onClick(target)
      end
    end
  end
end

function OnBlockClick()
  if WU.CurrentScene() ~= "SceneFight" then
    TryToJumpForceTutorial()
  end
  if not m_waiting and m_curTalk < m_curStep.talkCount then
    if REF.LabelTalk.TypewriterEffect.isTyping then
      REF.LabelTalk.TypewriterEffect:Finish()
    else
      NextTalk()
    end
  end
end

function TryToJumpForceTutorial(force)
  if m_curStep == nil then
    return
  end
  if not force and m_curTalk < m_curStep.talkCount then
    return
  end
  m_clickCount = m_clickCount + 1
  if m_clickCount == 10 then
    local count = m_manager.GetSkipCount()
    local tip
    if count == 0 or count == nil then
      tip = WU.GetString("WindowTutorial_Reset")
    elseif count == 1 then
      tip = WU.GetString("WindowTutorial_Restart")
    elseif count == 2 then
      tip = WU.GetString("WindowTutorial_Jump")
    end
    WU.ShowMessageYesNo(tip, function(action)
      if action == "YES" then
        WU.RemoveAllChild(REF.Content)
        REF.Curtain.gameObject:SetActive(false)
        m_manager.Skip()
      elseif action == "NO" then
        m_clickCount = 0
      end
    end)
  end
end

function ToggleTutorial(visible)
  REF.WindowSize.UIKeyResponser.enabled = m_curStep ~= nil and m_curStep.force and visible
  REF.ClickArea.gameObject:SetActive(false)
  WU.SetActive(REF.WindowSize, visible)
  m_isTutorialUIShowing = visible
  m_state = 0
end

function Show(tutorial, needCheckWindow)
  m_clickCount = 0
  m_curStep = tutorial
  m_curTalk = 0
  info("Tutorial", "next step " .. table.dump(m_curStep))
  REF.Block.gameObject:SetActive(true)
  REF.ClickArea.gameObject:SetActive(false)
  WU.SetActive(REF.NodeContinue, false)
  REF.Talk.transform.localPosition = CS.UnityEngine.Vector3(m_curStep.uiPositionX, m_curStep.uiPositionY, 0)
  local curWindow = WU.TopWindow().name
  info("Tutorial", "needCheckWindow " .. tostring(needCheckWindow) .. " curWindow " .. curWindow)
  if not needCheckWindow or m_curStep.whenShowWindow == "" and m_curStep.whenCloseWindow == "" and m_curStep.whenOpenWindow == "" or m_curStep.whenCloseWindow == "" and (m_curStep.whenShowWindow == curWindow or m_curStep.whenOpenWindow == curWindow) then
    info("Tutorial", "show next step ")
    NextTalk()
  else
    m_indicator = nil
    ToggleTutorial(false)
  end
end

function NextTalk()
  ToggleTutorial(true)
  if m_curTalk == 0 then
    m_waiting = true
    REF.Talk.gameObject:SetActive(false)
    this:DelayInvokeInSeconds(m_curStep.delay, function()
      m_waiting = false
      REF.Talk.gameObject:SetActive(true)
      NextTalkImpl()
    end)
  else
    NextTalkImpl()
  end
end

function NextTalkImpl()
  REF.Curtain.gameObject:SetActive(true)
  WU.SetActive(REF.DynamicSaku, m_curStep.mode == 0 and not m_curStep.flipSaku)
  WU.SetActive(REF.DynamicSakuFlip, m_curStep.mode == 0 and m_curStep.flipSaku)
  WU.SetActive(REF.StaticSaku, m_curStep.mode == 1 and not m_curStep.flipSaku)
  WU.SetActive(REF.StaticSakuFlip, m_curStep.mode == 1 and m_curStep.flipSaku)
  if m_curStep.flipSaku then
    this:DelayInvokeInFrames(1, function()
      _ENV["$"](REF.DynamicSakuFlip).EffectRight.transform.localEulerAngles = m_flipVector
      _ENV["$"](REF.StaticSakuFlip).Decorate2.transform.localEulerAngles = m_flipVector
    end)
  end
  local hasTalk = m_curStep.talkCount ~= 0
  m_curTalk = m_curTalk + 1
  if m_curTalk == m_curStep.talkCount or not hasTalk then
    SetIndicator()
  end
  REF.Talk.gameObject:SetActive(hasTalk)
  if hasTalk then
    local text = WU.GetString("Tutorial_" .. m_curStep.id .. "_" .. m_curStep.step .. "_" .. m_curTalk)
    text = "[3b578b]" .. text .. "[-]"
    REF.LabelTalk.UILabel.text = text
    REF.LabelTalk.TypewriterEffect:ResetToBeginning()
    m_isTutorialUIShowing = true
  end
  info("Tutorial", "NextTalk " .. m_curTalk)
end

function SetIndicator()
  info("Tutorial", "try to Set indicator ")
  m_indicator = CS.TutorialIndicator.Get(m_curStep.id, m_curStep.step)
  if m_indicator == nil then
    local func = _ENV["$"](WU.TopWindow()).root["$GetTutorialIndicator"]
    if func ~= nil then
      m_indicator = func(m_curStep.id, m_curStep.step)
    end
  end
  if m_indicator ~= nil then
    info("Tutorial", "Set indicator " .. tostring(m_indicator.Target))
    m_curtainTime = 0
    m_curStep.Indicator = m_indicator
    REF.Block.gameObject:SetActive(m_curStep.force)
    REF.ClickArea.gameObject:SetActive(m_curStep.force)
    REF.ClickArea.UIWidget.width = m_curStep.clickAreaWidth
    REF.ClickArea.UIWidget.height = m_curStep.clickAreaHeight
    local pos = m_indicator.Target.transform.position
    pos.z = 0
    REF.ClickArea.transform.position = pos
    local localPos = REF.ClickArea.transform.localPosition
    if localPos.y >= 5000 then
      localPos.y = localPos.y - 5000
      REF.ClickArea.transform.localPosition = localPos
    end
    local highlight = CS.UnityEngine.GameObject.Instantiate(m_indicator.Highlight, REF.Highlight.transform, true)
    local pos = highlight.transform.position
    pos.z = 0
    REF.Content.transform.position = pos
    highlight.transform:SetParent(REF.Content.transform)
    highlight.transform.localPosition = CS.UnityEngine.Vector3.zero
    CS.UIWindowManager.Instance:AdjustPanelDepth(highlight)
    highlight:SetActive(true)
    if m_curStep.id == 14 and m_curStep.step == 22 then
      _ENV["$"](highlight).root["$UpdateSelectedStatus"](true)
    elseif m_curStep.id == 19 and m_curStep.step == 11 then
      _ENV["$"](highlight).root.UIToggle.value = true
    end
    if m_curStep.id == 24 and m_curStep.step == 91 and _ENV["$"](highlight).buffInfo_2 then
      WU.SetActive(_ENV["$"](highlight).buffInfo_2, false)
    end
    REF.Effect.transform.position = pos
    if m_curStep.focusPosX == 0 then
      REF.FocusEffect.transform.localPosition = CS.UnityEngine.Vector3.zero
    else
      REF.FocusEffect.transform.localPosition = {
        x = m_curStep.focusPosX,
        y = m_curStep.focusPosY,
        z = 1
      }
    end
    local glow = _ENV["$"](highlight).TutorialGlow
    if glow ~= nil then
      glow.gameObject:SetActive(true)
      if m_curStep.id == 7 and m_curStep.step == 55 then
        glow.transform.localScale = {
          x = 1.18,
          y = 1.15,
          z = 1
        }
      end
    end
    if m_curStep.clickAreaWidth < 3000 then
      m_time = 0
      m_state = 1
    end
    if m_curStep.continue then
      REF.HandGuide.transform.localPosition = {
        x = m_curStep.handX,
        y = m_curStep.handY,
        z = 0
      }
    end
  else
    REF.Block.gameObject:SetActive(false)
    REF.ClickArea.gameObject:SetActive(false)
    REF.Curtain.gameObject:SetActive(false)
    this:BroadcastGameEvent("Tutorial/StepStart", m_curStep.step)
    info("Tutorial", "StepStart")
    m_isTutorialUIShowing = false
  end
end

function IsTutorialUIShowing()
  return m_isTutorialUIShowing
end

function IsImageTextTutorial()
  if m_curStep == nil then
    return false
  end
  if m_curStep.id == 27 and m_curStep.step == 105 or m_curStep.id == 2 and m_curStep.step == 81 or m_curStep.id == 2 and m_curStep.step == 101 or m_curStep.id == 10 and m_curStep.step == 11 or m_curStep.id == 22 and m_curStep.step == 91 then
    return true
  end
  return false
end

function PlayFocusAnim()
  if IsImageTextTutorial() or IsBuffTutorial() or RemoveTween() then
  elseif RemoveFocus() then
    WU.RestartTween(REF.Content.TweenScale)
  else
    WU.RestartTween(REF.Content.TweenScale)
    REF.FocusEffect.EffectGenerator:Play()
  end
end

function IsBuffTutorial()
  if m_curStep == nil then
    return false
  end
  if m_curStep.id == 27 and m_curStep.step == 115 then
    return true
  end
end

function OnHideTalk(param)
  WU.ToggleRendering(REF.Talk, not param)
end

function RemoveFocus()
  if m_curStep == nil then
    return false
  end
  if m_curStep.id == 31 and m_curStep.step == 11 or m_curStep.id == 35 and m_curStep.step == 11 then
    return true
  end
end

function RemoveTween()
  return m_curStep.id == 35 and m_curStep.step == 11
end
