local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_leftSignDelayAction, m_centerSignDelayAction
local m_showSignFlags = 0
local m_inFightScene = false

function InitWindow()
  this:RegisterGameEvent("HideLoadingSignCorner", function(flag)
    m_inFightScene = flag
  end)
  this:Bind("LockInputFlags", UpdateInputLock)
  this:Bind("TutorialSign", UpdateSignPos)
  m_showSignFlags = WU.LockInputFlag.AsyncLoad | WU.LockInputFlag.SceneLoading | WU.LockInputFlag.GameLoading | WU.LockInputFlag.Purchase | WU.LockInputFlag.Fade | WU.LockInputFlag.NetworkLoading | WU.LockInputFlag.NetworkLoading2 | WU.LockInputFlag.NetworkLoading3
  WU.ToggleRendering(REF.NodeLabel, false)
  WU.ToggleRendering(REF.Black, false)
end

function UpdateSignPos(val)
  if val == 1 then
    WU.ToggleRendering(REF.WindowSize, false)
  elseif val == 0 then
    WU.ToggleRendering(REF.WindowSize, true)
  end
end

function UpdateInputLock(flags)
  flags = flags or 0
  local locked = flags ~= 0
  if locked then
    WU.ToggleRendering(REF.Black, true)
    Show(flags)
  else
    HideSign(REF.Sign, flags)
    HideSign(REF.Sign2, flags)
    m_inFightScene = false
  end
  if m_inFightScene then
    REF.Sign.gameObject:SetActive(false)
  end
end

function Show(flags)
  if flags & m_showSignFlags ~= 0 then
    local sign, isNotNetworkLoading = GetSign(flags)
    if IsShowing(sign) then
      if flags & WU.LockInputFlag.NetworkLoading3 ~= 0 then
        REF.LabelDesc.UIHtmlLabel.text = WU.GetString("Window_NetworkRetry3Times")
        WU.ToggleRendering(REF.NodeLabel, true)
      elseif flags & WU.LockInputFlag.NetworkLoading2 ~= 0 then
        REF.LabelDesc.UIHtmlLabel.text = WU.GetString("Window_NetworkRetry1Times")
        WU.ToggleRendering(REF.NodeLabel, true)
      end
    else
      SetIsShowing(sign, true)
      if isNotNetworkLoading then
        if m_leftSignDelayAction == nil then
          m_leftSignDelayAction = this:DelayInvokeInSeconds(GetDelayTime(flags), function()
            ShowSign(sign, flags)
          end)
        end
      elseif m_centerSignDelayAction == nil then
        m_centerSignDelayAction = this:DelayInvokeInSeconds(GetDelayTime(flags), function()
          ShowSign(sign, flags)
        end)
      end
    end
    for i, v in ipairs(GetOtherSigns(sign)) do
      HideSign(v, flags)
    end
  else
    HideSign(REF.Sign, flags)
    HideSign(REF.Sign2, flags)
  end
end

function ShowSign(sign, flags)
  sign.gameObject:SetActive(true)
  sign.UISpriteAnimation.enabled = true
  local tween = sign.TweenAlpha
  tween.duration = 1 - sign.UISprite.alpha
  tween.from = sign.UISprite.alpha
  tween.to = 1
  WU.RestartTween(tween)
  if flags & WU.LockInputFlag.NetworkLoading2 ~= 0 or flags & WU.LockInputFlag.NetworkLoading3 ~= 0 then
    WU.ToggleRendering(REF.NodeLabel, true)
  end
end

function GetSign(flags)
  local isNetworkAboveToDie = flags & WU.LockInputFlag.NetworkLoading2 ~= 0 or flags & WU.LockInputFlag.NetworkLoading3 ~= 0
  if isNetworkAboveToDie then
    return REF.Sign2, false
  else
    local isNetworkLoading = flags & WU.LockInputFlag.NetworkLoading ~= 0
    if isNetworkLoading then
      return REF.Sign2, false
    else
      return REF.Sign, true
    end
  end
end

function IsShowing(sign)
  return _ENV["$"](sign)["@isShowing"] == true
end

function SetIsShowing(sign, isShowing)
  _ENV["$"](sign)["@isShowing"] = isShowing
end

function GetOtherSigns(sign)
  local result = {}
  if REF.Sign ~= sign then
    table.insert(result, REF.Sign)
  end
  if REF.Sign2 ~= sign then
    table.insert(result, REF.Sign2)
  end
  return result
end

function HasIsShowingSign()
  for i, v in ipairs(GetOtherSigns(nil)) do
    if IsShowing(v) then
      return true
    end
  end
  return false
end

function HideSign(sign, flags)
  if IsShowing(sign) then
    StopDelayAction(sign)
    SetIsShowing(sign, false)
    local tween = sign.TweenAlpha
    tween.duration = sign.UISprite.alpha
    tween.from = sign.UISprite.alpha
    tween.to = 0
    WU.RestartTween(tween, function()
      sign.gameObject:SetActive(false)
      sign.UISpriteAnimation.enabled = false
    end)
    if flags & WU.LockInputFlag.NetworkLoading2 == 0 or flags & WU.LockInputFlag.NetworkLoading3 == 0 then
      WU.ToggleRendering(REF.NodeLabel, false)
    end
  end
  if flags == 0 and not HasIsShowingSign() then
    WU.ToggleRendering(REF.Black, false)
  end
end

function StopDelayAction(sign)
  if REF.Sign == sign then
    if m_leftSignDelayAction ~= nil then
      this:StopCoroutine(m_leftSignDelayAction)
      m_leftSignDelayAction = nil
    end
  elseif REF.Sign2 == sign and m_centerSignDelayAction ~= nil then
    this:StopCoroutine(m_centerSignDelayAction)
    m_centerSignDelayAction = nil
  end
end

function GetDelayTime(flags)
  local delayTime = 2
  if flags & WU.LockInputFlag.Fade ~= 0 then
    delayTime = 0
  end
  return delayTime
end
